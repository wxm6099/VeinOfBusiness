//
//  TaskListViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TaskListViewController.h"
#import "TaskListTableCell.h"
#import "TaskWebViewController.h"
#import "RedEnvelopeViewController.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"
#import "AdvertiseModel.h"
#import <MJRefresh/MJRefreshHeader.h>
#import <MJRefresh/MJRefreshFooter.h>
#import <MJRefresh.h>


@interface TaskListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *modelArray;
@end

@implementation TaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self netRequest:0];
    
    
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"TaskListTableCell" bundle:nil] forCellReuseIdentifier:@"TaskListTableCell"];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self netRequest:0];
        
    }];
//    self.myTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//    }];
    
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self netRequest:1];
    }];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [button setTitle:@"红包" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    [button addTarget:self action:@selector(redEnvelopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.title = @"任务";
}




- (void)netRequest:(NSInteger)num{
    
    NSArray *array = [Account findAll];
    Account *acc = array[0];
    NSString *page;
    
    if (num == 0) { // 刷新
        
        page = [NSString stringWithFormat:@"1"];
        
        
    } else {  // 加载
        
        NSInteger tempNum = self.modelArray.count / 10;
        
        page = [NSString stringWithFormat:@"%ld", tempNum + 1];
    }
    
    NSDictionary *dic = @{@"type": @"1",
                          @"customerId": acc.customerId,
                          @"userType": @"3",
                          @"page":page};
    
    
    [RestfulAPIRequestTool routeName:@"ad_getad" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        
        if (num == 0) {
            [self.modelArray removeAllObjects];
        }
        
        NSLog(@"获取的广告数据为 %@", json);
        NSArray *dataArray = json[@"data"];
        
        for (NSDictionary *temp in dataArray) {
            AdvertiseModel *model = [AdvertiseModel new];
            [model setValuesForKeysWithDictionary:temp];
            [self.modelArray addObject:model];
        }
        [self.myTableView reloadData];
        [self endRefresh];
        
        if (![page isEqualToString:@"1"] && dataArray.count == 0) {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(id errorJson) {
        
    }];
    
}

-(void)endRefresh{
    [self.myTableView.mj_footer endRefreshing];
    [self.myTableView.mj_header endRefreshing];
}

- (void)redEnvelopButtonAction:(UIButton *)sender
{
    
    
    
    RedEnvelopeViewController *red = [[RedEnvelopeViewController alloc]initWithNibName:@"RedEnvelopeViewController" bundle:nil];
    [self.navigationController pushViewController:red animated:YES];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TaskListTableCell *task = [tableView dequeueReusableCellWithIdentifier:@"TaskListTableCell"];
    task.cellModel = self.modelArray[indexPath.row];
    return task;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskWebViewController *task = [[TaskWebViewController alloc]initWithNibName:@"TaskWebViewController" bundle:nil];
    //刷新浏览数
    AdvertiseModel *model = self.modelArray[indexPath.row];
    model.openTimes = [NSString stringWithFormat:@"%ld", [model.openTimes integerValue] + 1];
    TaskListTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.cellModel = model;
    
    task.model = self.modelArray[indexPath.row];
    
    [self.navigationController pushViewController:task animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}
@end
