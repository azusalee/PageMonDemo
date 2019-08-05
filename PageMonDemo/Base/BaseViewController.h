//
//  BaseViewController.h
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

// 开始刷新的时候调用
- (void)pl_refreshStart;
// 结束刷新的时候调用
- (void)pl_refreshEnd;

// 开始调用api调用
- (void)pl_apiStart;
// 结束调用api调用
- (void)pl_apiEnd;


@end

NS_ASSUME_NONNULL_END
