//
//  PageRecordListViewController.m
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import "PageRecordListViewController.h"
#import "PageLoadRecordManager.h"
#import "PageRecordTableViewCell.h"

@interface PageRecordListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation PageRecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.dataArray = [[PageLoadRecordManager shareInstance] getRecordArray];
    
    self.tableView.rowHeight = 130;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PageRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"PageRecordTableViewCell"];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PageRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PageRecordTableViewCell"];
    
    PageLoadRecord *model = self.dataArray[indexPath.row];
    cell.pageNameLabel.text = model.pageName;
    cell.loadTimeLabel.text = [NSString stringWithFormat:@"加载时间:%f", model.loadUseTime];
    cell.apiTimeLabel.text = [NSString stringWithFormat:@"api时间:%f", model.apiUseTime];
    cell.refreshTimeLabel.text = [NSString stringWithFormat:@"刷新时间:%f", model.refreshUseTime];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
