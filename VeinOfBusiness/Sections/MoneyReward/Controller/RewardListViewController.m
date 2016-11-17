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

@interface RewardListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation RewardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"赏金任务";
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, 192)];
    view.backgroundColor = BackColor;
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, 150)];
    
    im.backgroundColor = [UIColor redColor];
    [view addSubview:im];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(21, 168, 1100, 21)];
    label.text = @"猜你喜欢";
    [view addSubview:label];
    
    
    self.myTableView.tableHeaderView = view;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"RewardListTableCell" bundle:nil] forCellReuseIdentifier:@"RewardListTableCell"];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RewardListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RewardListTableCell"];
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskWebViewController *web = [[TaskWebViewController alloc]initWithNibName:@"TaskWebViewController" bundle:nil];
    [self.navigationController pushViewController:web animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}




@end
