//
//  NSURLResponse+DoggerMonitor.m
//  OCDemo
//
//  Created by 谢佳培 on 2022/3/10.
//

#import "NSURLResponse+DoggerMonitor.h"

typedef CFHTTPMessageRef (*CustomURLResponseGetHTTPResponse)(CFURLRef response);

@implementation NSURLResponse (DoggerMonitor)

- (NSString *)statusLineFromCF {
    NSString *statusLine = @"";
    //...
    return statusLine;
}

- (NSUInteger)getLineLength {
    NSString *lineStr = @"";
    if ([self isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self;
        lineStr = [self statusLineFromCF];
    }
    NSData *lineData = [lineStr dataUsingEncoding:NSUTF8StringEncoding];
    return lineData.length;
}

- (NSUInteger)getHeadersLength {
    NSUInteger headersLength = 0;
    if ([self isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self;
        NSDictionary<NSString *, NSString *> *headerFields = httpResponse.allHeaderFields;
        NSString *headerStr = @"";
        for (NSString *key in headerFields.allKeys) {
            headerStr = [headerStr stringByAppendingString:key];
            headerStr = [headerStr stringByAppendingString:@": "];
            if ([headerFields objectForKey:key]) {
                headerStr = [headerStr stringByAppendingString:headerFields[key]];
            }
            headerStr = [headerStr stringByAppendingString:@"\n"];
        }
        NSData *headerData = [headerStr dataUsingEncoding:NSUTF8StringEncoding];
        headersLength = headerData.length;
    }
    return headersLength;
}

- (NSUInteger)getBodyLength {
    NSDictionary<NSString *, NSString *> *headerFields = self.allHTTPHeaderFields;
    NSUInteger bodyLength = [self.HTTPBody length];

    if ([headerFields objectForKey:@"Content-Encoding"]) {
        NSData *bodyData;
        if (self.HTTPBody == nil) {
            uint8_t d[1024] = {0};
            NSInputStream *stream = self.HTTPBodyStream;
            NSMutableData *data = [[NSMutableData alloc] init];
            [stream open];
            while ([stream hasBytesAvailable]) {
                NSInteger len = [stream read:d maxLength:1024];
                if (len > 0 && stream.streamError == nil) {
                    [data appendBytes:(void *)d length:len];
                }
            }
            bodyData = [data copy];
            [stream close];
        } else {
            bodyData = self.HTTPBody;
        }
        //bodyLength = [[bodyData gzippedData] length];
    }
    return bodyLength;
}



@end
