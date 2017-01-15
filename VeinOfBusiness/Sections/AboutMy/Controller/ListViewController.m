//
//  ListViewController.m
//  VeinOfBusiness
//
//  Created by sense on 17/1/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ListViewController.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"
#import "MBProgressHUD.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;
@property (nonatomic,retain) UITableView *table;

@property (nonatomic,retain) MBProgressHUD *HUD;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.HUD.label.text = @"loading";
    
    self.title = self.dic[@"title"];
    [self createUI];
    [self getList];
}

- (void)getList{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作
        NSString *routeName = @"";
        NSDictionary *model = @{};
        if ([self.dic[@"page"]isEqualToString:@"province"]) {
            routeName = Personal_province;
            model = nil;
        }else if ([self.dic[@"page"]isEqualToString:@"city"]){
            routeName = Personal_city;
            model = @{@"provinceId":self.dic[@"province_id"]};
        }else{
            routeName = Personal_district;
            model = @{@"cityId":self.dic[@"city_id"]};
        }
        

        [RestfulAPIRequestTool routeName:routeName requestModel:model useKeys:nil success:^(id json) {
            
            NSString *status = [json objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                NSMutableArray *arr = [json objectForKey:@"data"];
                
                self.arraySource = arr;
                [self.table reloadData];
                
                [self.HUD hideAnimated:YES];
            }
            
        } failure:^(id errorJson) {
            NSLog(@"登录结果为%@", errorJson);
        }];
        
    });
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
    cell.textLabel.text = [dic objectForKey:@"area_name"];
//    cell.detailTextLabel.text = [dic objectForKey:@"footer"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic= [self.arraySource objectAtIndex:indexPath.row];
    
    if ([self.dic[@"page"]isEqualToString:@"province"]) {
        ListViewController *list = [[ListViewController alloc]init];
        list.dic = @{@"title":@"地区选择(市)",
                     @"province_id":[dic objectForKey:@"area_id"],
                     @"province_name":[dic objectForKey:@"area_name"],
                     @"page":@"city"};
        [self.navigationController pushViewController:list animated:YES];
        
    }else if ([self.dic[@"page"]isEqualToString:@"city"]){
        ListViewController *list = [[ListViewController alloc]init];
        list.dic = @{@"title":@"地区选择(区)",
                     @"province_id":[self.dic objectForKey:@"province_id"],
                     @"province_name":[self.dic objectForKey:@"province_name"],
                     @"city_id":[dic objectForKey:@"area_id"],
                     @"city_name":[dic objectForKey:@"area_name"],
                     @"page":@"district"};
        [self.navigationController pushViewController:list animated:YES];
        
    }else{
        
        Account *acc = [[Account findAll] objectAtIndex:0];
        NSString *str = [NSString stringWithFormat:@"%@%@%@",[self.dic objectForKey:@"province_name"],[self.dic objectForKey:@"city_name"],[dic objectForKey:@"area_name"]];
        NSDictionary *modify_dic = @{@"customerId":acc.customerId,
                              @"username":acc.name,
                              @"getAccount":acc.aliAccount,
                              @"provinceId":[self.dic objectForKey:@"province_id"],
                              @"cityId":[self.dic objectForKey:@"city_id"],
                              @"districtId":[dic objectForKey:@"area_id"],
                              @"areaInfo":str,
                              @"pic":acc.photo};
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFY_Personal object:@{@"type":@"modify"} userInfo:modify_dic];
        
        
        acc.provinceId = [self.dic objectForKey:@"province_id"];
        acc.cityId = [self.dic objectForKey:@"city_id"];
        acc.districtId = [dic objectForKey:@"area_id"];
        acc.areaInfo = str;
        [acc update];
        
        NSArray *arr = self.navigationController.viewControllers;
        [self.navigationController popToViewController:arr[arr.count - 4] animated:YES];
    }
    
}

- (UITableView *)table
{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
        //    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"user"];
        //    [table registerClass:[AboutMeCell class] forCellReuseIdentifier:@"aboutMeFirst"];
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
