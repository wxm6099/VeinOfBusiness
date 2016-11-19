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


@interface TaskListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *modelArray;
@end

@implementation TaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self netRequest];
    
    
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"TaskListTableCell" bundle:nil] forCellReuseIdentifier:@"TaskListTableCell"];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [button setTitle:@"红包" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    [button addTarget:self action:@selector(redEnvelopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.title = @"任务";
}




- (void)netRequest{
    
    NSArray *array = [Account findAll];
    Account *acc = array[0];
    
    NSDictionary *dic = @{@"type": @"1",
                          @"customerId": acc.customerId,
                          @"userType": @"3"};
    
    
    
    [RestfulAPIRequestTool routeName:@"ad_getad" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        
        NSLog(@"获取的广告数据为 %@", json);
        NSArray *dataArray = json[@"data"];
        
        for (NSDictionary *temp in dataArray) {
            AdvertiseModel *model = [AdvertiseModel new];
            [model setValuesForKeysWithDictionary:temp];
            [self.modelArray addObject:model];
        }
        [self.myTableView reloadData];
        
    } failure:^(id errorJson) {
        
    }];
    
}


- (void)redEnvelopButtonAction:(UIButton *)sender
{
    
    [self netRequest];
    /*
    RedEnvelopeViewController *red = [[RedEnvelopeViewController alloc]initWithNibName:@"RedEnvelopeViewController" bundle:nil];
    [self.navigationController pushViewController:red animated:YES];
    */
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
