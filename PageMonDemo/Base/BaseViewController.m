//
//  BaseViewController.m
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import "BaseViewController.h"
#import "PageLoadRecordManager.h"

@interface BaseViewController ()

@property (nonatomic, strong) PageLoadRecord *pl_pageLoadRecord;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    self.pl_pageLoadRecord = [[PageLoadRecord alloc] init];
    self.pl_pageLoadRecord.pageName = NSStringFromClass([self class]);
    [[PageLoadRecordManager shareInstance] addRecord:self.pl_pageLoadRecord];
    self.pl_pageLoadRecord.loadTimeStamp = [NSDate date].timeIntervalSince1970;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.pl_pageLoadRecord.firstWillAppearStamp == 0) {
        self.pl_pageLoadRecord.firstWillAppearStamp = [NSDate date].timeIntervalSince1970;
        self.pl_pageLoadRecord.loadUseTime = self.pl_pageLoadRecord.firstWillAppearStamp-self.pl_pageLoadRecord.loadTimeStamp;
    }
    
}

- (void)pl_refreshStart{
    self.pl_pageLoadRecord.refreshStartTimeStamp = [NSDate date].timeIntervalSince1970;
}

- (void)pl_refreshEnd{
    self.pl_pageLoadRecord.refreshEndTimeStamp = [NSDate date].timeIntervalSince1970;
    self.pl_pageLoadRecord.refreshUseTime = self.pl_pageLoadRecord.refreshEndTimeStamp-self.pl_pageLoadRecord.refreshStartTimeStamp;
}

- (void)pl_apiStart{
    self.pl_pageLoadRecord.apiStartTimeStamp = [NSDate date].timeIntervalSince1970;
}

- (void)pl_apiEnd{
    self.pl_pageLoadRecord.apiEndTimeStamp = [NSDate date].timeIntervalSince1970;
    self.pl_pageLoadRecord.apiUseTime = self.pl_pageLoadRecord.apiEndTimeStamp-self.pl_pageLoadRecord.apiStartTimeStamp;
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
