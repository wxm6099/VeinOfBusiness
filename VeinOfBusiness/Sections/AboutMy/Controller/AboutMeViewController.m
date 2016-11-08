//
//  AboutMeViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "AboutMeViewController.h"

#import "MessageViewController.h"
#import "SettingViewController.h"
#import "RankingViewController.h"
#import "DrawMoneyViewController.h"
#import "UserViewController.h"

@interface AboutMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;


@end

@implementation AboutMeViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self createUI];
}

- (void)createUI
{
    UIView *viewa = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, 164)];
    viewa.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewa];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 55, 62, 62)];
    imageView.image = [UIImage imageNamed:@"Message"];
    imageView.layer.cornerRadius = 30;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 2;
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    
    [viewa addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, 96, 22)];
    label.text = @"哎哟不错先生";
    [viewa addSubview:label];
    

    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 164, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aboutMe"];
//    [table registerClass:[AboutMeCell class] forCellReuseIdentifier:@"aboutMeFirst"];
    table.scrollEnabled = NO;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aboutMe"];
    NSDictionary *dic = [_arraySource objectAtIndex:indexPath.row];
    cell.imageView.image = [dic objectForKey:@"image"];
    cell.textLabel.text = [dic objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DrawMoneyViewController *draw = [[DrawMoneyViewController alloc]init];
        [self.navigationController pushViewController:draw animated:YES];
    }
    if (indexPath.row == 1) {
        MessageViewController *message = [[MessageViewController alloc]init];
        [self.navigationController pushViewController:message animated:YES];
    }
    if (indexPath.row == 2) {
        RankingViewController *rank = [[RankingViewController alloc]init];
        [self.navigationController pushViewController:rank animated:YES];
    }
    if (indexPath.row == 3) {
        SettingViewController *setting = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:setting animated:YES];
    }
}

- (void)tapImage
{
    UserViewController *user = [[UserViewController alloc]init];
    [self.navigationController pushViewController:user animated:YES];
}


- (NSMutableArray *)arraySource
{
    if (!_arraySource) {
        
//        UIImage *image0 = [UIImage imageNamed:@"DrawMoney"];
//        NSDictionary *dic0 = @{@"image":image0,
//                               @"name":@"提现"};
        
        UIImage *image1 = [UIImage imageNamed:@"DrawMoney"];
        NSDictionary *dic1 = @{@"image":image1,
                               @"name":@"提现"};
        
        UIImage *image2 = [UIImage imageNamed:@"Message"];
        NSDictionary *dic2 = @{@"image":image2,
                               @"name":@"我的消息"};
        
        UIImage *image3 = [UIImage imageNamed:@"RankList"];
        NSDictionary *dic3 = @{@"image":image3,
                               @"name":@"我的排行榜"};
        
        UIImage *image4 = [UIImage imageNamed:@"Setting"];
        NSDictionary *dic4 = @{@"image":image4,
                               @"name":@"设置"};
        _arraySource = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4, nil];
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
