//
//  UserViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *arraySource;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"基本资料";
    
    [self createUI];
}

- (void)createUI
{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
//    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"user"];
    //    [table registerClass:[AboutMeCell class] forCellReuseIdentifier:@"aboutMeFirst"];
    table.scrollEnabled = NO;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
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
    
    NSArray *array = [_arraySource objectAtIndex:indexPath.section];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"name"];
    cell.detailTextLabel.text = [dic objectForKey:@"detail"];
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
        
        
        NSDictionary *dic1_1 = @{@"name":@"昵称",
                               @"detail":@"哎哟不错先生"};

        NSDictionary *dic1_2 = @{@"name":@"性别",
                               @"detail":@"男"};
        
        NSDictionary *dic1_3 = @{@"name":@"我的排行榜",
                               @"detail":@"1990-08-08"};
        
        NSDictionary *dic1_4 = @{@"name":@"所在地区",
                               @"detail":@"未设置"};
        NSArray *arr1 = [NSArray arrayWithObjects:dic1_1,dic1_2,dic1_3,dic1_4, nil];
        
        NSDictionary *dic2_1 = @{@"name":@"所属行业",
                                 @"detail":@"未设置"};
        
        NSDictionary *dic2_2 = @{@"name":@"月收入",
                                 @"detail":@"未设置"};
        
        NSDictionary *dic2_3 = @{@"name":@"学历",
                                 @"detail":@"本科"};
        
        NSDictionary *dic2_4 = @{@"name":@"兴趣爱好",
                                 @"detail":@"未设置"};
        NSArray *arr2 = [NSArray arrayWithObjects:dic2_1,dic2_2,dic2_3,dic2_4,nil];
        
        _arraySource = [NSMutableArray arrayWithObjects:arr1,arr2, nil];
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
