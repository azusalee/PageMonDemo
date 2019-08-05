//
//  SlowRecordManager.m
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import "SlowRecordManager.h"
#import "SlowRecord.h"

@interface SlowRecordManager()
{

}

@property (nonatomic, strong) NSMutableArray<SlowRecord*> *slowRecordArray;

@end

@implementation SlowRecordManager

+ (instancetype)shareInstance {
    static id instance = nil;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        _slowRecordArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)addLongSlowRecord:(NSString *)stackLog{
    SlowRecord *record = [[SlowRecord alloc] init];
    record.timeStamp = [NSDate date].timeIntervalSince1970;
    record.mainStackLog = stackLog;
    record.message = @"单次长时间卡顿";
    [self.slowRecordArray addObject:record];
    
}

- (void)addShortSlowRecord:(NSString *)stackLog{
    SlowRecord *record = [[SlowRecord alloc] init];
    record.timeStamp = [NSDate date].timeIntervalSince1970;
    record.mainStackLog = stackLog;
    record.message = @"多次短时间卡顿";
    [self.slowRecordArray addObject:record];
}

- (NSArray *)getRecordArray{
    return [self.slowRecordArray copy];
}

@end
