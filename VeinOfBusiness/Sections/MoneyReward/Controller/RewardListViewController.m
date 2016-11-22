//
//  RewardListViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RewardListViewController.h"
#import "RewardListTableCell.h"
#import "TaskWebViewController.h"

#import "TaskWebViewController.h"
#import "RedEnvelopeViewController.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"
#import "AdvertiseModel.h"
#import <MJRefresh/MJRefreshHeader.h>
#import <MJRefresh/MJRefreshFooter.h>
#import <MJRefresh.h>



@interface RewardListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *modelArray;

@end

@implementation RewardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"赏金任务";
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, 192)];
    view.backgroundColor = BackColor;
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, 150)];
    im.image = [UIImage imageNamed:@"Bitmap"];
    
    im.backgroundColor = [UIColor redColor];
    [view addSubview:im];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(21, 168, 1100, 21)];
    label.text = @"猜你喜欢";
    [view addSubview:label];
    
    
    self.myTableView.tableHeaderView = view;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"RewardListTableCell" bundle:nil] forCellReuseIdentifier:@"RewardListTableCell"];
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self netRequest:1];
    }];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.myTableView.tableFooterView = tempView;
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
    
    NSDictionary *dic = @{@"type": @"2",
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
        
        // 在首次请求就不满足10条数据的情况下结束加载更多
        
        if ([page isEqualToString:@"1"] &&dataArray.count < 10){
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } failure:^(id errorJson) {
        
    }];
    
}

-(void)endRefresh{
    [self.myTableView.mj_footer endRefreshing];
    [self.myTableView.mj_header endRefreshing];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RewardListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RewardListTableCell"];
    
    cell.cellModel = self.modelArray[indexPath.row];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskWebViewController *task = [[TaskWebViewController alloc]initWithNibName:@"TaskWebViewController" bundle:nil];
    //刷新浏览数
    AdvertiseModel *model = self.modelArray[indexPath.row];
    model.openTimes = [NSString stringWithFormat:@"%ld", [model.openTimes integerValue] + 1];
    RewardListTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.cellModel = model;
    
    task.model = self.modelArray[indexPath.row];
    
    [self.navigationController pushViewController:task animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
