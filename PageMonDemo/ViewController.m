//
//  ViewController.m
//  PageMonDemo
//
//  Created by yangming on 2019/8/5.
//  Copyright © 2019 AL. All rights reserved.
//

#import "ViewController.h"
#import "JumpVCModel.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = 44;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupData];
}

//設置數據
- (void)setupData{
    self.dataArray = [[NSMutableArray alloc] init];
    
    {
        JumpVCModel *model = [[JumpVCModel alloc] init];
        model.title = @"卡顿模拟";
        model.vcName = @"SlowTestViewController";
        [self.dataArray addObject:model];
    }
    
    {
        JumpVCModel *model = [[JumpVCModel alloc] init];
        model.title = @"卡顿记录列表";
        model.vcName = @"SlowRecordListViewController";
        [self.dataArray addObject:model];
    }
    
    {
        JumpVCModel *model = [[JumpVCModel alloc] init];
        model.title = @"页面时间记录";
        model.vcName = @"PageRecordListViewController";
        [self.dataArray addObject:model];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    JumpVCModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JumpVCModel *model = self.dataArray[indexPath.row];
    if (model.viewController) {
        [self.navigationController pushViewController:model.viewController animated:YES];
    }else{
        id viewController = [[NSClassFromString(model.vcName) alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
