//
//  SlowRecordManager.h
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SlowRecordManager : NSObject

+ (instancetype)shareInstance;

- (void)addLongSlowRecord:(NSString *)stackLog;

- (void)addShortSlowRecord:(NSString *)stackLog;


- (NSArray *)getRecordArray;

@end

NS_ASSUME_NONNULL_END
