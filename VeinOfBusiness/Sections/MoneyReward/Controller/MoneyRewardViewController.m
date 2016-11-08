//
//  MoneyRewardViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MoneyRewardViewController.h"
#import "RewardVIew.h"
#import "RewardListViewController.h"
#import "MyIntegralViewController.h"
#import "CheckInViewController.h"
#import "AccountBalanceViewController.h"
#import "InviteViewController.h"


@interface MoneyRewardViewController ()

@property (weak, nonatomic) IBOutlet UILabel *surplusMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayIncome;
@property (weak, nonatomic) IBOutlet UILabel *historyIncome;
@property (weak, nonatomic) IBOutlet UIView *backViewTwo;
@property (weak, nonatomic) IBOutlet UIView *backViewThree;
@property (weak, nonatomic) IBOutlet UIView *topBackTempView;

@end

@implementation MoneyRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
    
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topBackViewAction:)];
    [self.topBackTempView addGestureRecognizer:topTap];
    
    UITapGestureRecognizer *backTwoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tampViewTouchAction:)];
    self.title = @"赏金";
    [self.backViewTwo addGestureRecognizer:backTwoTap];
    
    
    CGFloat tempWidth = DLScreenWidth / 2 - 1;
    
    NSArray *array = @[@[@"qiandao", @"签到", @"最高可得100元"],
                       @[@"积分兑换", @"积分兑换", @"当前积分0"],
                       @[@"邀请好友", @"邀请好友", @"邀请好友"]];
    
    
    for (int i = 0; i < 3; i++) {
        
        NSArray *temp = array[i];
        
        RewardVIew *view = [[RewardVIew alloc]initWithFrame:
        CGRectMake(i % 2 * tempWidth, i / 2 * 112, tempWidth - 1, 112)
    imageName:nil
    title:temp[1]
    detailTitle:temp[2]];
        
        view.tag = i + 1;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tampViewTouchAction:)];
        [view addGestureRecognizer:tap];
        
        [self.backViewThree addSubview:view];
        
    }
    
}

- (void)topBackViewAction:(UITapGestureRecognizer *)sender{
    AccountBalanceViewController *ac = [[AccountBalanceViewController alloc]initWithNibName:@"AccountBalanceViewController" bundle:nil];
    [self.navigationController pushViewController:ac animated:YES];
}

- (void)tampViewTouchAction:(UITapGestureRecognizer *)tap
{
    switch (tap.view.tag) {
        case 1:
        {
            CheckInViewController *check = [[CheckInViewController alloc] initWithNibName:@"CheckInViewController" bundle:nil];
            [self.navigationController pushViewController:check animated:YES];
        }
            break;
        case 2:
        {
            MyIntegralViewController *my = [[MyIntegralViewController alloc] initWithNibName:@"MyIntegralViewController" bundle:nil];
            [self.navigationController pushViewController:my animated:YES];
            
        }
            break;
        case 3:
        {
            InviteViewController *invite = [[InviteViewController alloc] initWithNibName:@"InviteViewController" bundle:nil];
            [self.navigationController pushViewController:invite animated:YES];
        }
            break;
        case 4:
        {
            RewardListViewController *reward = [[RewardListViewController alloc] initWithNibName:@"RewardListViewController" bundle:nil];
            
            [self.navigationController pushViewController:reward animated:YES];
            
        }
            break;
        default:
            break;
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
