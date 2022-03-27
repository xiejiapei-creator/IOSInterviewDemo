//
//  NetworkTrafficLog.h
//  OCDemo
//
//  Created by 谢佳培 on 2022/3/10.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NetworkTrafficDataType)
{
    NetworkTrafficDataTypeResponse,
    NetworkTrafficDataTypeRequest,
};

NS_ASSUME_NONNULL_BEGIN

@interface NetworkTrafficLog : NSObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, assign) NetworkTrafficDataType type;
@property (nonatomic, assign) NSUInteger lineLength;
@property (nonatomic, assign) NSUInteger headerLength;
@property (nonatomic, assign) NSUInteger bodyLength;
@property (nonatomic, assign) NSUInteger length;

@end

NS_ASSUME_NONNULL_END
