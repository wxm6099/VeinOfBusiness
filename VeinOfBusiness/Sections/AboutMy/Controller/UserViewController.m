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
#import "ListViewController.h"


@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,retain) NSMutableArray *arraySource;
@property (nonatomic,retain) UITableView *table;

//@property (nonatomic,copy) NSString *province_id;
//@property (nonatomic,copy) NSString *city_id;
//@property (nonatomic,copy) NSString *district_id;
//@property (nonatomic,copy) NSString *ali_account;
//@property (nonatomic,copy) NSString *area_Info;
//@property (nonatomic,copy) NSString *user_name;
//@property (nonatomic,copy) NSString *verify;


@end

@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated
{
    Account *acc = [[Account findAll] objectAtIndex:0];
    NSDictionary *dic1 = @{@"header":@"昵称",
                           @"footer":acc.username};
    NSDictionary *dic2 = @{@"header":@"所在地区",
                           @"footer":acc.areaInfo};
    NSDictionary *dic3 = @{@"header":@"身份验证",
                           @"footer":acc.verify};
    _arraySource = [NSMutableArray arrayWithObjects:dic1,dic2,dic3, nil];
    [self.table reloadData];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
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
    NSString *footer = [dic objectForKey:@"footer"];
    cell.detailTextLabel.text = footer;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 2) {
        if ([footer isEqualToString:@"待审核"]||[footer isEqualToString:@"通过"]) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.arraySource objectAtIndex:indexPath.row];
    NSString *footer = [dic objectForKey:@"footer"];
    if (indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"修改昵称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 25;
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
    if (indexPath.row == 1) {
        ListViewController *list = [[ListViewController alloc]init];
        list.dic = @{@"title":@"地区选择(省)",
                     @"area_id":@"",
                     @"page":@"province"};
        [self.navigationController pushViewController:list animated:YES];
        
    }
    if (indexPath.row == 2) {
        if ([footer isEqualToString:@"待审核"]||[footer isEqualToString:@"通过"]) {
            return;
        }
        AuthViewController *auth = [[AuthViewController alloc]init];
        [self.navigationController pushViewController:auth animated:YES];
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 25) {
        if (buttonIndex == 1) {
            UITextField *field = [alertView textFieldAtIndex:0];
            
            Account *acc = [[Account findAll] objectAtIndex:0];
            acc.username = field.text;
            [acc update];
//            NSDictionary *dic = @{@"customerId":acc.customerId,
//                                  @"username":field.text,
//                                  @"getAccount":acc.aliAccount,
//                                  @"provinceId":acc.provinceId,
//                                  @"cityId":acc.cityId,
//                                  @"districtId":acc.districtId,
//                                  @"areaInfo":acc.areaInfo,
//                                  @"pic":acc.photo};
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFY_Personal object:acc userInfo:@{@"type":@"modify"}];
            
         
            NSMutableDictionary *dic0 = [NSMutableDictionary dictionaryWithDictionary:self.arraySource[0]];
            [dic0 setObject:field.text forKey:@"footer"];
            
            [self.arraySource replaceObjectAtIndex:0 withObject:dic0];
            [self.table reloadData];
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
