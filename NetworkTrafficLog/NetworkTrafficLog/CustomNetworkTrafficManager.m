//
//  CustomNetworkTrafficManager.m
//  OCDemo
//
//  Created by 谢佳培 on 2022/3/10.
//

#import "CustomNetworkTrafficManager.h"
#import "CustomURLProtocol.h"

@implementation CustomNetworkTrafficManager

+ (CustomNetworkTrafficManager *)manager {
    static CustomNetworkTrafficManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[CustomNetworkTrafficManager alloc] init];
    });
    return manager;
}

+ (void)startWithProtocolClasses:(NSArray *)protocolClasses {
    [self manager].protocolClasses = protocolClasses;
    [CustomURLProtocol start];
}

+ (void)start {
    [self manager].protocolClasses = @[[CustomURLProtocol class]];
    [CustomURLProtocol start];
}

+ (void)end {
    [CustomURLProtocol end];
}



@end

