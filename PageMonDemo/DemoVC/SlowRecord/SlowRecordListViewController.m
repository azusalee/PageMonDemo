//
//  SlowRecordListViewController.m
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import "SlowRecordListViewController.h"
#import "SlowRecordTableViewCell.h"
#import "SlowRecordDetailViewController.h"
#import "SlowRecordManager.h"

@interface SlowRecordListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation SlowRecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.dataArray = [[SlowRecordManager shareInstance] getRecordArray];
    
    self.tableView.rowHeight = 80;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SlowRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"SlowRecordTableViewCell"];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SlowRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SlowRecordTableViewCell"];
    
    SlowRecord *model = self.dataArray[indexPath.row];
    cell.timeLabel.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:model.timeStamp]];
    cell.messageLabel.text = model.message;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SlowRecord *model = self.dataArray[indexPath.row];
    SlowRecordDetailViewController *controller = [[SlowRecordDetailViewController alloc] init];
    controller.record = model;
    [self.navigationController pushViewController:controller animated:YES];
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
