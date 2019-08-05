//
//  SlowRecord.h
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SlowRecord : NSObject

// 发生的时间戳
@property (nonatomic, assign) NSTimeInterval timeStamp;

// 主线程的堆栈信息
@property (nonatomic, strong) NSString *mainStackLog;

// 自定义内容
@property (nonatomic, strong) NSString *message;

@end

NS_ASSUME_NONNULL_END
