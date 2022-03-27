//
//  NSURLResponse+DoggerMonitor.h
//  OCDemo
//
//  Created by 谢佳培 on 2022/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLResponse (DoggerMonitor)

- (NSUInteger)getLineLength;
- (NSUInteger)getHeadersLength;

@end

NS_ASSUME_NONNULL_END
