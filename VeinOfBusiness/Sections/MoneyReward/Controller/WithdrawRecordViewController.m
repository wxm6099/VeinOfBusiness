//
//  WithdrawRecordViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "WithdrawRecordViewController.h"
#import "WithdrawRecordTableCell.h"
@interface WithdrawRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeButtonWidth;
@property (weak, nonatomic) IBOutlet UITableView *myTableVIew;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WithdrawRecordTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WithdrawRecordTableCell"];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
