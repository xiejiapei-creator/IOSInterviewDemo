//
//  CustomURLProtocol.h
//  OCDemo
//
//  Created by 谢佳培 on 2022/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomURLProtocol : NSURLProtocol

/** 开启网络请求拦截 */
+ (void)start;
/** 停止网络请求拦截 */
+ (void)end;

@end

NS_ASSUME_NONNULL_END
