//
//  CustomURLSessionConfiguration.h
//  OCDemo
//
//  Created by 谢佳培 on 2022/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomURLSessionConfiguration : NSObject

@property (nonatomic,assign) BOOL isSwizzle;
+ (CustomURLSessionConfiguration *)defaultConfiguration;
- (void)load;
- (void)unload;

@end

NS_ASSUME_NONNULL_END
