//
//  MessageViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"消息";
    
    [self createUI];
    
}

- (void)createUI
{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
    [table registerClass:[MessageCell class] forCellReuseIdentifier:@"message"];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arraySource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];

    NSDictionary *dic = [self.arraySource objectAtIndex:indexPath.row];
    cell.labelContent.text = [dic objectForKey:@"name"];
    cell.labelTitle.text = [dic objectForKey:@"title"];
    cell.labelTime.text = [dic objectForKey:@"time"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }
    if (indexPath.row == 1) {
        
    }
    if (indexPath.row == 2) {
        
    }
    if (indexPath.row == 3) {

    }
}

- (NSMutableArray *)arraySource
{
    if (!_arraySource) {

        NSDictionary *dic1 = @{@"name":@"我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么",
                               @"title":@"国庆放假通知",
                               @"time":@"2010-09-09"};
        NSDictionary *dic2 = @{@"name":@"我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么",
                               @"title":@"国庆放假通知",
                               @"time":@"2010-09-09"};
        NSDictionary *dic3 = @{@"name":@"我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么",
                               @"title":@"国庆放假通知",
                               @"time":@"2010-09-09"};
        
//        NSArray *arr1 = [NSArray arrayWithObjects:dic1,dic2, nil];
//        NSArray *arr2 = [NSArray arrayWithObject:dic3];
        _arraySource = [NSMutableArray arrayWithObjects:dic1,dic2,dic3, nil];
    }
    return _arraySource;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
