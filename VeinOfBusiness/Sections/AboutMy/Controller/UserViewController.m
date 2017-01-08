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
#import "AuthViewController.h"


@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

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

            NSString *status = [json objectForKey:@"status"];
            NSString *msg = [json objectForKey:@"Msg"];
            NSDictionary *dicData= [json objectForKey:@"data"];
            
            if ([status isEqualToString:@"success"]) {
                if (dicData) {
                    NSString *user_name = [dicData objectForKey:@"username"];
                    NSString *area_info = [dicData objectForKey:@"areaInfo"];
                    NSString *verify_status = [dicData objectForKey:@"verifyStatus"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableDictionary *dic0 = [NSMutableDictionary dictionaryWithDictionary:self.arraySource[0]];
                        [dic0 setObject:user_name forKey:@"footer"];
                        
                        NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:self.arraySource[1]];
                        [dic1 setObject:area_info forKey:@"footer"];
                        
                        NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithDictionary:self.arraySource[2]];
                        NSString *verify = @"";
                        switch (verify_status.integerValue) {
                            case 0:
                                verify = @"未提交";
                                break;
                            case 1:
                                verify = @"待审核";
                                break;
                            case 2:
                                verify = @"通过";
                                break;
                            case 3:
                                verify = @"失败";
                                break;
                                
                            default:
                                break;
                        }
                        [dic2 setObject:verify forKey:@"footer"];
                        
                        [self.arraySource removeAllObjects];
                        self.arraySource = [NSMutableArray arrayWithObjects:dic0,dic1,dic2, nil];
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
    
    NSDictionary *dic1 = @{@"header":@"昵称",
                             @"footer":@""};
    
    NSDictionary *dic2 = @{@"header":@"所在地区",
                             @"footer":@""};
    
    NSDictionary *dic3 = @{@"header":@"身份验证",
                             @"footer":@""};
    
    _arraySource = [NSMutableArray arrayWithObjects:dic1,dic2,dic3, nil];
    
    [self createUI];
}

- (void)createUI
{
    [self table];
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
    static NSString *ident = @"ident";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    }
    
    NSDictionary *dic = [self.arraySource objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"header"];
    cell.detailTextLabel.text = [dic objectForKey:@"footer"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"修改昵称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 25;
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
    if (indexPath.row == 1) {
        
    }
    if (indexPath.row == 2) {
        AuthViewController *auth = [[AuthViewController alloc]init];
        [self.navigationController pushViewController:auth animated:YES];
    }
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 25) {
        if (buttonIndex == 1) {
            UITextField *field = [alertView textFieldAtIndex:0];
            NSString *name = field.text;
        }
    }
}

// 变更资料
- (void)modifyUserDetail{
    
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
