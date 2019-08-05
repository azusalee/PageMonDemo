//
//  PageLoadRecordManager.h
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageLoadRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface PageLoadRecordManager : NSObject

+ (instancetype)shareInstance;

- (void)addRecord:(PageLoadRecord *)record;
- (NSArray *)getRecordArray;

@end

NS_ASSUME_NONNULL_END
