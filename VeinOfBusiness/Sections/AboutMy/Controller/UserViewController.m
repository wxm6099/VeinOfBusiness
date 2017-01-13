//
//  UserViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UserViewController.h"
#import "Account.h"
#import "RestfulAPIRequestTool.h"

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *arraySource;
@property (nonatomic,retain) UITableView *table;

@end

@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作
        Account *acc = [[Account findAll] objectAtIndex:0];
        
        NSDictionary *dic = @{@"customerId" : acc.customerId};
        [RestfulAPIRequestTool routeName:Personalcenter_detail_URL requestModel:dic useKeys:[dic allKeys] success:^(id json) {
            
            NSLog(@"请求结果为%@", json);
            
            //            {
            //            status:"success"，
            //                data：{username：用户名,
            //                    mobile：
            //                    Pic：},
            //            Msg:""
            //            }
            
            NSString *status = [json objectForKey:@"status"];
            NSString *msg = [json objectForKey:@"Msg"];
            NSDictionary *dicData= json[@"data"];
            
            if ([status isEqualToString:@"success"]) {
                
                if (dicData) {
                    
                    //                        NSString *username = [dataUser objectForKey:@"username"];
                    
                    NSString *username = [self setNullString:[dicData objectForKey:@"username"]];
                    NSString *gender = [self setNullString:[dicData objectForKey:@"gender"]];
                    NSString *birthday = [self setNullString:[dicData objectForKey:@"birthday"]];
                    NSString *address = [self setNullString:[dicData objectForKey:@"address"]];
                    
                    NSString *Idcode = [dicData objectForKey:@"Idcode"];
                    
                    NSString *major = [self setNullString:[dicData objectForKey:@"major"]];
                    NSString *money = [self setNullString:[dicData objectForKey:@"money"]];
                    NSString *education = [self setNullString: [dicData objectForKey:@"education"]];
                    NSString *interest = [self setNullString:[dicData objectForKey:@"interset"]];
                    
                    
                    NSDictionary *dic1_1 = @{@"header":@"昵称",
                                             @"footer":username};
                    
                    NSDictionary *dic1_2 = @{@"header":@"性别",
                                             @"footer":gender};
                    
                    NSDictionary *dic1_3 = @{@"header":@"我的排行榜",
                                             @"footer":birthday};
                    
                    NSDictionary *dic1_4 = @{@"header":@"所在地区",
                                             @"footer":address};
                    NSArray *arr1 = [NSArray arrayWithObjects:dic1_1,dic1_2,dic1_3,dic1_4, nil];
                    
                    NSDictionary *dic2_1 = @{@"header":@"所属行业",
                                             @"footer":major};
                    
                    NSDictionary *dic2_2 = @{@"header":@"月收入",
                                             @"footer":money};
                    
                    NSDictionary *dic2_3 = @{@"header":@"学历",
                                             @"footer":education};
                    
                    NSDictionary *dic2_4 = @{@"header":@"兴趣爱好",
                                             @"footer":interest};
                    NSArray *arr2 = [NSArray arrayWithObjects:dic2_1,dic2_2,dic2_3,dic2_4,nil];
                    
                    _arraySource = [NSMutableArray arrayWithObjects:arr1,arr2, nil];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.table reloadData];
                    });
                    
                }
                
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
    
    self.navigationItem.title = @"基本资料";
    
    
    NSDictionary *dic1_1 = @{@"header":@"昵称",
                             @"footer":@"哎哟不错先生"};
    
    NSDictionary *dic1_2 = @{@"header":@"性别",
                             @"footer":@"男"};
    
    NSDictionary *dic1_3 = @{@"header":@"我的排行榜",
                             @"footer":@"1990-08-08"};
    
    NSDictionary *dic1_4 = @{@"header":@"所在地区",
                             @"footer":@"未设置"};
    NSArray *arr1 = [NSArray arrayWithObjects:dic1_1,dic1_2,dic1_3,dic1_4, nil];
    
    NSDictionary *dic2_1 = @{@"header":@"所属行业",
                             @"footer":@"未设置"};
    
    NSDictionary *dic2_2 = @{@"header":@"月收入",
                             @"footer":@"未设置"};
    
    NSDictionary *dic2_3 = @{@"header":@"学历",
                             @"footer":@"本科"};
    
    NSDictionary *dic2_4 = @{@"header":@"兴趣爱好",
                             @"footer":@"未设置"};
    NSArray *arr2 = [NSArray arrayWithObjects:dic2_1,dic2_2,dic2_3,dic2_4,nil];
    
    _arraySource = [NSMutableArray arrayWithObjects:arr1,arr2, nil];
    
    [self createUI];
}

- (void)createUI
{
    [self table];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arraySource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.arraySource objectAtIndex:section];
    return array.count;
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
    static NSString *ident = @"ident";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    }
    
    NSArray *array = [self.arraySource objectAtIndex:indexPath.section];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"header"];
    cell.detailTextLabel.text = [dic objectForKey:@"footer"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    if (indexPath.section == 1) {
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


- (UITableView *)table
{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
        //    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"user"];
        //    [table registerClass:[AboutMeCell class] forCellReuseIdentifier:@"aboutMeFirst"];
        _table.scrollEnabled = NO;
        _table.delegate = self;
        _table.dataSource = self;
        [self.view addSubview:_table];
    }
    return _table;
    
}


- (NSString *)setNullString:(NSString *)str
{
    if (!str) {
        str = @"未设置";
    }
    if ([str isKindOfClass:[NSNull class]]) {
        str = @"未设置";
    }
    return str;
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
