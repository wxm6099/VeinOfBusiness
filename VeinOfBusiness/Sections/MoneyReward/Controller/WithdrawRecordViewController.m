//
//  WithdrawRecordViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "WithdrawRecordViewController.h"
#import "WithdrawRecordTableCell.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"

@interface WithdrawRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeButtonWidth;
@property (weak, nonatomic) IBOutlet UITableView *myTableVIew;

@property (nonatomic, strong)NSArray *dataArray;


@end

@implementation WithdrawRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提现记录";
    self.timeButtonWidth.constant = (DLScreenWidth - 2) / 3.0;
    
    self.myTableVIew.delegate = self;
    self.myTableVIew.dataSource = self;
    
    [self.myTableVIew registerNib:[UINib nibWithNibName:@"WithdrawRecordTableCell" bundle:nil] forCellReuseIdentifier:@"WithdrawRecordTableCell"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.myTableVIew.tableFooterView = view;
    
    [self netRequest];
    
    
}


- (void)netRequest{
    
    
    Account *acc = [Account findAll][0];
    NSDictionary *dic = @{@"customerId": acc.customerId};
    
    [RestfulAPIRequestTool routeName:@"reward_moneyhistory" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        NSLog(@"提现记录为 %@", json);
        
        if ([json[@"status"] isEqualToString:@"success"]) {
            self.dataArray = [NSArray arrayWithArray:json[@"data"]];
            [self.myTableVIew reloadData];
        }
        
    } failure:^(id errorJson) {
        
    }];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WithdrawRecordTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WithdrawRecordTableCell"];
    cell.withdrawDic = self.dataArray[indexPath.row];
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
