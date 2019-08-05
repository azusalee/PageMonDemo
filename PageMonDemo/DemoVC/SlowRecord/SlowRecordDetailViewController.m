//
//  SlowRecordDetailViewController.m
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import "SlowRecordDetailViewController.h"

@interface SlowRecordDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation SlowRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.textView.text = [NSString stringWithFormat:@"%@\n%@\n%@", [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.record.timeStamp]], self.record.message, self.record.mainStackLog];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
