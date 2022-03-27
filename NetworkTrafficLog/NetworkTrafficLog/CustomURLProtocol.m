//
//  CustomURLProtocol.m
//  OCDemo
//
//  Created by 谢佳培 on 2022/3/10.
//

#import "CustomURLProtocol.h"
#import "CustomURLSessionConfiguration.h"
#import "CustomNetworkTrafficManager.h"
#import "NetworkTrafficLog.h"
#import "NSURLResponse+DoggerMonitor.h"
#import "NSURLRequest+DoggerMonitor.h"

static NSString *const URLProtocolHandledKey = @"XJPHTTP";

@interface CustomURLProtocol() <NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLRequest *urlRequest;
@property (nonatomic, strong) NSURLResponse *urlResponse;
@property (nonatomic, strong) NSMutableData *urlData;

@end

@implementation CustomURLProtocol

+ (void)start {
    CustomURLSessionConfiguration *sessionConfiguration = [CustomURLSessionConfiguration defaultConfiguration];
    for (id protocolClass in [CustomNetworkTrafficManager manager].protocolClasses) {
        [NSURLProtocol registerClass:protocolClass];
    }
    if (![sessionConfiguration isSwizzle]) {
        [sessionConfiguration load];// 设置交换
    }
}

+ (void)end {
    CustomURLSessionConfiguration *sessionConfiguration = [CustomURLSessionConfiguration defaultConfiguration];
    [NSURLProtocol unregisterClass:[CustomURLProtocol class]];
    if ([sessionConfiguration isSwizzle]) {
        [sessionConfiguration unload];// 取消交换
    }
}

#pragma mark - 拦截请求

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if (![request.URL.scheme isEqualToString:@"http"] && ![request.URL.scheme isEqualToString:@"https"]) {
        return NO;
    }
    if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request] ) {
        return NO;
    }
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableReqeust];
    return [mutableReqeust copy];
}

- (void)startLoading {
    NSURLRequest *request = [[self class] canonicalRequestForRequest:self.request];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.protocolClasses = @[[CustomURLProtocol class]];
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:mainQueue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    self.urlSession = session;
    self.urlRequest = request;
    [dataTask resume];
}

- (void)stopLoading {
    [self.urlSession invalidateAndCancel];

    NetworkTrafficLog *model = [[NetworkTrafficLog alloc] init];
    model.path = self.request.URL.path;
    model.host = self.request.URL.host;
    model.type = NetworkTrafficDataTypeResponse;
    model.lineLength = [self.urlResponse getLineLength];
    model.headerLength = [self.urlResponse getHeadersLength];
    
    if ([self.urlResponse isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self.urlResponse;
        NSData *data = self.urlData;
        // 模拟压缩
        if ([[httpResponse.allHeaderFields objectForKey:@"Content-Encoding"] isEqualToString:@"gzip"]) {
            data = [self.urlData gzippedData];
        }
        model.bodyLength = data.length;
    }
    model.length = model.lineLength + model.headerLength + model.bodyLength;
    [model settingOccurTime];
    [[CustomDataManager defaultDB] addNetworkTrafficLog:model];
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    self.urlResponse = response;
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    [self.urlData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    
    if (response != nil) {
        self.urlResponse = response;
        [self.client URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
    }

    NetworkTrafficLog *model = [[NetworkTrafficLog alloc] init];
    model.path = request.URL.path;
    model.host = request.URL.host;
    model.type = NetworkTrafficDataTypeRequest;
    model.lineLength = [request getLineLength];
    model.headerLength = [request getHeadersLengthWithCookie];
    model.bodyLength = [request getBodyLength];
    model.length = model.lineLength + model.headerLength + model.bodyLength;
    [model settingOccurTime];
    [[DataManager defaultDB] addNetworkTrafficLog:model];
    return request;
}

@end
