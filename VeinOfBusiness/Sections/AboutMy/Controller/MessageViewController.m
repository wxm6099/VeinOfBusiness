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
#import <MJRefresh.h>
#import "MBProgressHUD.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;
@property (nonatomic,retain) UITableView *table;
@property (nonatomic,retain) MBProgressHUD *HUD;

@end

@implementation MessageViewController

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作
        [self request];
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
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.HUD.label.text = @"loading";
    
    self.navigationItem.title = @"消息";
    [self createUI];
    
}

- (void)createUI
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
    [self.table registerClass:[MessageCell class] forCellReuseIdentifier:@"message"];
    self.table.delegate = self;
    self.table.dataSource = self;
    
//    self.table.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
//        [self request];
//    }];
//    self.table.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        [self request];
//    }];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)request
{
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
                [self.HUD hideAnimated:YES];
                if (self.arraySource.count == 0) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有更多消息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                }
            });
            
        }
        
    } failure:^(id errorJson) {
        NSLog(@"登录结果为%@", errorJson);
    }];
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
