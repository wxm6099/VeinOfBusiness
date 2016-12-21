//
//  RankingViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RankingViewController.h"
#import "RankingCell.h"
#import "RestfulAPIRequestTool.h"

@interface RankingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;
@property (nonatomic,retain) UITableView *table;

@end

@implementation RankingViewController

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作
//        Account *acc = [[Account findAll] objectAtIndex:0];
        
        NSDictionary *dic = @{@"index" : @"10"};
        [RestfulAPIRequestTool routeName:Personalcenter_rank_URL requestModel:dic useKeys:[dic allKeys] success:^(id json) {
            
            NSLog(@"请求结果为%@", json);
            if (json == nil || [json isEqualToString:@""]) {
                json =
                @{@"status":@"success",
                  @"data":@[@{@"pic":@"",
                              @"username":@"sense",
                              @"sumPoint":@"363654545"},
                            @{@"pic":@"",
                              @"username":@"sense",
                              @"sumPoint":@"254546"},
                            @{@"pic":@"",
                              @"username":@"sense",
                              @"sumPoint":@"567"},
                            @{@"pic":@"",
                              @"username":@"sense",
                              @"sumPoint":@"254546"},
                            @{@"pic":@"",
                              @"username":@"sense",
                              @"sumPoint":@"254546"},
                            @{@"pic":@"",
                              @"username":@"sense",
                              @"sumPoint":@"254546"},
                            @{@"pic":@"",
                              @"username":@"sense",
                              @"sumPoint":@"254546"},
                            @{@"pic":@"",
                              @"username":@"sense",
                              @"sumPoint":@"254546"},
                            ],
                  @"msg":@"",
                  };
            }
            NSString *status = [json objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                
                NSString *msg = [json objectForKey:@"msg"];
                NSArray *arrData = [json objectForKey:@"data"];
                self.arraySource = [NSMutableArray arrayWithArray:arrData];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.table reloadData];
                });
            }
            
        } failure:^(id errorJson) {
            NSLog(@"登录结果为%@", errorJson);
        }];
        
        
        
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"排行";
    
//    NSDictionary *dic1_1 = @{@"name":@"昵称",
//                             @"detail":@"哎哟不错先生"};
//    
//    NSDictionary *dic1_2 = @{@"name":@"性别",
//                             @"detail":@"男"};
//    
//    NSDictionary *dic1_3 = @{@"name":@"我的排行榜",
//                             @"detail":@"1990-08-08"};
//    
//    NSDictionary *dic1_4 = @{@"name":@"所在地区",
//                             @"detail":@"未设置"};
//    
//    _arraySource = [NSMutableArray arrayWithObjects:dic1_1,dic1_2,dic1_3,dic1_4, nil];
    self.arraySource = [NSMutableArray array];
    
    [self createUI];
    
}

- (void)createUI
{
//    UILabel *labelNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, 33)];
//    labelNum.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
//    labelNum.font = [UIFont systemFontOfSize:14];
//    labelNum.textColor = [UIColor blackColor];
//    labelNum.text = @"总人数:7,386,389";
//    labelNum.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:labelNum];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
//    self.table.tableHeaderView = labelNum;
//    [table registerClass:[RankingCell class] forCellReuseIdentifier:@"ranking"];
    //    [table registerClass:[AboutMeCell class] forCellReuseIdentifier:@"aboutMeFirst"];
    _table.scrollEnabled = YES;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
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
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"ranking";
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[RankingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    NSDictionary *dic = [self.arraySource objectAtIndex:indexPath.row];
    NSString *imgUrl = [dic objectForKey:@"pic"];
    if ([imgUrl isKindOfClass:[NSNull class]] || !imgUrl||[imgUrl isEqualToString:@""]) {
        cell.imageView.image = [UIImage imageNamed:@"Message"];
    } else {
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
    }
    cell.textLabel.text = [dic objectForKey:@"username"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"第%ld名",indexPath.row + 1];
    cell.labelMoney.text = [NSString stringWithFormat:@"%@积分",[dic objectForKey:@"sumPoint"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
        }
        if (indexPath.row == 1) {
            
        }
        if (indexPath.row == 2) {
            
        }
        if (indexPath.row == 3) {
            
        }
    }
    
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
