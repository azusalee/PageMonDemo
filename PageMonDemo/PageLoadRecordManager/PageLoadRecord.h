//
//  PageLoadRecord.h
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageLoadRecord : NSObject

@property (nonatomic, strong) NSString *pageName;

@property (nonatomic, assign) NSTimeInterval loadUseTime;
@property (nonatomic, assign) NSTimeInterval refreshUseTime;
@property (nonatomic, assign) NSTimeInterval apiUseTime;

@property (nonatomic, assign) NSTimeInterval loadTimeStamp;
@property (nonatomic, assign) NSTimeInterval firstWillAppearStamp;

@property (nonatomic, assign) NSTimeInterval refreshStartTimeStamp;
@property (nonatomic, assign) NSTimeInterval refreshEndTimeStamp;

@property (nonatomic, assign) NSTimeInterval apiStartTimeStamp;
@property (nonatomic, assign) NSTimeInterval apiEndTimeStamp;

@end

NS_ASSUME_NONNULL_END
