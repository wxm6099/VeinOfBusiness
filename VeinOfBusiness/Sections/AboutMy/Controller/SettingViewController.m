//
//  SettingViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"设置";
    
    [self createUI];
}

- (void)createUI
{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting"];
    
    NSArray *array = [_arraySource objectAtIndex:indexPath.section];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"name"];
    if (indexPath.row == 2) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        DrawMoneyViewController *draw = [[DrawMoneyViewController alloc]init];
//        [self.navigationController pushViewController:draw animated:YES];
    }
    if (indexPath.row == 1) {
//        MessageViewController *message = [[MessageViewController alloc]init];
//        [self.navigationController pushViewController:message animated:YES];
    }
    if (indexPath.row == 2) {
//        RankingViewController *rank = [[RankingViewController alloc]init];
//        [self.navigationController pushViewController:rank animated:YES];
    }
    if (indexPath.row == 3) {
//        SettingViewController *setting = [[SettingViewController alloc]init];
//        [self.navigationController pushViewController:setting animated:YES];
    }
}

- (NSMutableArray *)arraySource
{
    if (!_arraySource) {
        
        //        UIImage *image0 = [UIImage imageNamed:@"DrawMoney"];
        //        NSDictionary *dic0 = @{@"image":image0,
        //                               @"name":@"提现"};
        
        
        NSDictionary *dic1 = @{@"name":@"登录密码"};
        NSDictionary *dic2 = @{@"name":@"缓存清理"};
        NSDictionary *dic3 = @{@"name":@"退出登录"};
        
        NSArray *arr1 = [NSArray arrayWithObjects:dic1,dic2, nil];
        NSArray *arr2 = [NSArray arrayWithObject:dic3];
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
