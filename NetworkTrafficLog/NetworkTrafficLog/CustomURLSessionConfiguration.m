//
//  CustomURLSessionConfiguration.m
//  OCDemo
//
//  Created by 谢佳培 on 2022/3/10.
//

#import "CustomURLSessionConfiguration.h"
#import <objc/runtime.h>
#import "CustomURLProtocol.h"
#import "CustomNetworkTrafficManager.h"

@implementation CustomURLSessionConfiguration

+ (CustomURLSessionConfiguration *)defaultConfiguration {
    static CustomURLSessionConfiguration *staticConfiguration;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticConfiguration = [[CustomURLSessionConfiguration alloc] init];
    });
    return staticConfiguration;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isSwizzle = NO;
    }
    return self;
}

- (void)load {
    self.isSwizzle = YES;
    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    [self swizzleSelector:@selector(protocolClasses) fromClass:cls toClass:[self class]];
}

- (void)unload {
    self.isSwizzle = NO;
    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    [self swizzleSelector:@selector(protocolClasses) fromClass:cls toClass:[self class]];
}

- (void)swizzleSelector:(SEL)selector fromClass:(Class)original toClass:(Class)stub {
    Method originalMethod = class_getInstanceMethod(original, selector);
    Method stubMethod = class_getInstanceMethod(stub, selector);
    if (!originalMethod || !stubMethod) {
        [NSException raise:NSInternalInconsistencyException format:@"Couldn't load NEURLSessionConfiguration."];
    }
    method_exchangeImplementations(originalMethod, stubMethod);
}

- (NSArray *)protocolClasses {
    // CustomNetworkTrafficManager 中的 protocolClasses 可以给使用者设置自定义的 protocolClasses
    return [CustomNetworkTrafficManager manager].protocolClasses;
}


@end
