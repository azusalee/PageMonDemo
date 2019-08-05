//
//  PageLoadRecordManager.m
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import "PageLoadRecordManager.h"


@interface PageLoadRecordManager()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PageLoadRecordManager

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
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addRecord:(PageLoadRecord *)record{
    [self.dataArray addObject:record];
}

- (NSArray *)getRecordArray{
    return [self.dataArray copy];
}

@end
