//
//  SlowTestViewController.m
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import "SlowTestViewController.h"

@interface SlowTestViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeCount;
@end

@implementation SlowTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)shortSlowDidTap:(id)sender {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(sleepTimerAction) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)sleepTimerAction{
    usleep(160*1000);
    
    self.timeCount += 1;
    if (self.timeCount == 5) {
        [self.timer invalidate];
        self.timer = nil;
        self.timeCount = 0;
    }
}

- (IBAction)longSlowDidTap:(id)sender {
    usleep(600*1000);
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
