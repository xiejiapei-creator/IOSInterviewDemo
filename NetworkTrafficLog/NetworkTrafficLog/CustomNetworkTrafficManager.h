//
//  CustomNetworkTrafficManager.h
//  OCDemo
//
//  Created by 谢佳培 on 2022/3/10.
//

#import <Foundation/Foundation.h>

@class CustomNetworkLog;

NS_ASSUME_NONNULL_BEGIN

@interface CustomNetworkTrafficManager : NSObject

/** 所有 NSURLProtocol 对外设置接口，可以防止其他外来监控 NSURLProtocol */
@property (nonatomic, strong) NSArray *protocolClasses;

/** 单例 */
+ (CustomNetworkTrafficManager *)manager;
/** 通过 protocolClasses 启动流量监控模块 */
+ (void)startWithProtocolClasses:(NSArray *)protocolClasses;
/** 仅以 CustomURLProtocol 启动流量监控模块 */
+ (void)start;
/** 停止 CustomURLProtocol 的流量监控 */
+ (void)end;

@end

NS_ASSUME_NONNULL_END
