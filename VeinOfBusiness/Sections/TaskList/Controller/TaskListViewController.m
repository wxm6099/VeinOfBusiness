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



@interface TaskListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation TaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"TaskListTableCell" bundle:nil] forCellReuseIdentifier:@"TaskListTableCell"];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [button setTitle:@"红包" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    [button addTarget:self action:@selector(redEnvelopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.title = @"任务";
}



- (void)redEnvelopButtonAction:(UIButton *)sender
{
    RedEnvelopeViewController *red = [[RedEnvelopeViewController alloc]initWithNibName:@"RedEnvelopeViewController" bundle:nil];
    [self.navigationController pushViewController:red animated:YES];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TaskListTableCell *task = [tableView dequeueReusableCellWithIdentifier:@"TaskListTableCell"];
    
    return task;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskWebViewController *task = [[TaskWebViewController alloc]initWithNibName:@"TaskWebViewController" bundle:nil];
    [self.navigationController pushViewController:task animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end
