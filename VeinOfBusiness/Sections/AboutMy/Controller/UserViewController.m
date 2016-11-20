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
            
//            NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dic = nil;
//            {
//            status:"success"，
//                data：{username：用户名,
//                gender:性别,
//                birthday:生日,
//                Idcode:身份证,
//                    address:地址},
//            Msg:""
//            }
            
            if (dic) {
                NSString *status = [dic objectForKey:@"status"];
                NSString *msg = [dic objectForKey:@"Msg"];
                if ([status isEqualToString:@"success"]) {
                    NSDictionary *dataUser = [dic objectForKey:@"data"];
                    
                    if (dataUser) {
                        
                        NSString *username = [dataUser objectForKey:@"username"];
                        NSString *gender = [dataUser objectForKey:@"gender"];
                        NSString *birthday = [dataUser objectForKey:@"birthday"];
                        NSString *address = [dataUser objectForKey:@"address"];
                        
                        NSString *Idcode = [dataUser objectForKey:@"Idcode"];

                        NSString *major = [dataUser objectForKey:@"major"];
                        NSString *money = [dataUser objectForKey:@"money"];
                        NSString *education = [dataUser objectForKey:@"education"];
                        NSString *interest = [dataUser objectForKey:@"interset"];
                        
                        
                        for (int j = 0; j < self.arraySource.count; j++) {
                            
                            NSArray *arr = [self.arraySource objectAtIndex:j];
                            switch (j) {
                                case 0:
                                    for (int i = 0; i <arr.count; i++) {
                                        NSMutableDictionary *dic = [arr objectAtIndex:i];
                                        switch (i) {
                                            case 0:
                                                [dic setObject:username forKey:@"header"];
                                                break;
                                            case 1:
                                                [dic setObject:gender forKey:@"header"];
                                                break;
                                            case 2:
                                                [dic setObject:birthday forKey:@"header"];
                                                break;
                                            case 3:
                                                [dic setObject:address forKey:@"header"];
                                                break;
                                                
                                            default:
                                                break;
                                        }
                                    }
                                    break;
                                
                                case 1:
                                    for (int i = 0; i <arr.count; i++) {
                                        NSMutableDictionary *dic = [arr objectAtIndex:i];
                                        switch (i) {
                                            case 0:
                                                [dic setObject:major forKey:@"header"];
                                                break;
                                            case 1:
                                                [dic setObject:money forKey:@"header"];
                                                break;
                                            case 2:
                                                [dic setObject:education forKey:@"header"];
                                                break;
                                            case 3:
                                                [dic setObject:interest forKey:@"header"];
                                                break;
                                                
                                            default:
                                                break;
                                        }
                                    }
                                    break;
                                    
                                default:
                                    break;
                            }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.table reloadData];
                        });
                    }
                    
                }
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

- (NSMutableArray *)arraySource
{
    if (!_arraySource) {
        
        //        UIImage *image0 = [UIImage imageNamed:@"DrawMoney"];
        //        NSDictionary *dic0 = @{@"image":image0,
        //                               @"name":@"提现"};
        
        
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
    }
    return _arraySource;
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
