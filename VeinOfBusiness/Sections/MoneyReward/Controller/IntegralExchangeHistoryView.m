//
//  IntegralExchangeHistoryView.m
//  VeinOfBusiness
//
//  Created by 太阳 on 2016/11/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "IntegralExchangeHistoryView.h"
#import "WithdrawRecordTableCell.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"


@interface IntegralExchangeHistoryView ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeButtonWidth;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSArray *dataArray;
@end

@implementation IntegralExchangeHistoryView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timeButtonWidth.constant = (DLScreenWidth - 2) / 3.0;
    
    [self netRequest];
    
    self.title = @"积分历史";
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"WithdrawRecordTableCell" bundle:nil] forCellReuseIdentifier:@"WithdrawRecordTableCell"];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.myTableView.tableFooterView = view;
    
}

- (void)netRequest{
    Account *account = [Account findAll][0];
    
    NSDictionary *dic = @{@"customerId": account.customerId};
    [RestfulAPIRequestTool routeName:@"reward_pointhistory" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        
        NSLog(@"网络请求的结果为 %@", json);
        
        [self analysisDataWithDic:json];
        
    } failure:^(id errorJson) {
        
    }];
    
}


- (void)analysisDataWithDic:(NSDictionary *)json
{
    self.dataArray = [NSArray arrayWithArray: json[@"data"]];
    
    [self.myTableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WithdrawRecordTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WithdrawRecordTableCell"];
    
    cell.integralDic = self.dataArray[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}





@end
