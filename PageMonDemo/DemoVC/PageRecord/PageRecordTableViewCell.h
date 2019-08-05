//
//  PageRecordTableViewCell.h
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *loadTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *apiTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *refreshTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageNameLabel;

@end

NS_ASSUME_NONNULL_END
