//
//  MessageViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "Account.h"
#import "RestfulAPIRequestTool.h"
#import "MessageModel.h"
#import "CommonViewController.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;
@property (nonatomic,retain) UITableView *table;

@end

@implementation MessageViewController

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作
        Account *acc = [[Account findAll] objectAtIndex:0];
        
        NSDictionary *dic = @{@"customerId" : acc.customerId};
        [RestfulAPIRequestTool routeName:Personal_msg_URL requestModel:dic useKeys:[dic allKeys] success:^(id json) {
            
            NSLog(@"请求结果为%@", json);

            NSString *status = [json objectForKey:@"status"];
            NSMutableArray *arrayData = [json objectForKey:@"data"];
            
            if ([status isEqualToString:@"success"]) {
                
                for (NSDictionary *dic in arrayData) {
                    MessageModel *model = [[MessageModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    if (!self.arraySource) {
                        self.arraySource = [NSMutableArray array];
                    }
                    [self.arraySource addObject:model];
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.table reloadData];
                });
                
            }
            
            
            
            
            
        } failure:^(id errorJson) {
            NSLog(@"登录结果为%@", errorJson);
        }];
        
        
        
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"消息";
    
    [self createUI];
    
}

- (void)createUI
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
    [self.table registerClass:[MessageCell class] forCellReuseIdentifier:@"message"];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];

    MessageModel *model = [self.arraySource objectAtIndex:indexPath.row];
    cell.labelContent.text = model.summary;
    cell.labelTitle.text = model.title;
    cell.labelTime.text = model.addTime;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *model = [self.arraySource objectAtIndex:indexPath.row];
    CommonViewController *common = [[CommonViewController alloc]init];
    common.url = model.link;
    [self.navigationController pushViewController:common animated:YES];
    
}

//- (NSMutableArray *)arraySource
//{
//    if (!_arraySource) {

//        NSDictionary *dic1 = @{@"name":@"我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么",
//                               @"title":@"国庆放假通知",
//                               @"time":@"2010-09-09"};
//        NSDictionary *dic2 = @{@"name":@"我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么",
//                               @"title":@"国庆放假通知",
//                               @"time":@"2010-09-09"};
//        NSDictionary *dic3 = @{@"name":@"我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么我也不知道在这里说些什么",
//                               @"title":@"国庆放假通知",
//                               @"time":@"2010-09-09"};
        
//        NSArray *arr1 = [NSArray arrayWithObjects:dic1,dic2, nil];
//        NSArray *arr2 = [NSArray arrayWithObject:dic3];
//        _arraySource = [NSMutableArray arrayWithObjects:dic1,dic2,dic3, nil];
//    }
//    return _arraySource;
//}



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
