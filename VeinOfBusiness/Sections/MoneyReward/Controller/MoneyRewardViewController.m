//
//  MoneyRewardViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "Account.h"
#import "MoneyRewardViewController.h"
#import "RewardVIew.h"
#import "RewardListViewController.h"
#import "MyIntegralViewController.h"
#import "CheckInViewController.h"
#import "AccountBalanceViewController.h"
#import "InviteViewController.h"
#import "RestfulAPIRequestTool.h"
#import "IntegralModel.h"
@interface MoneyRewardViewController ()

@property (weak, nonatomic) IBOutlet UILabel *surplusMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayIncome;
@property (weak, nonatomic) IBOutlet UILabel *historyIncome;
@property (weak, nonatomic) IBOutlet UIView *backViewTwo;
@property (weak, nonatomic) IBOutlet UIView *backViewThree;
@property (weak, nonatomic) IBOutlet UIView *topBackTempView;
@property (weak, nonatomic) IBOutlet UILabel *currentNum;
@property (nonatomic, strong)IntegralModel *model;
@end

@implementation MoneyRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self netRequest];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netRequest) name:@"RefreshUserRewardMoneyData" object:nil];
    
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topBackViewAction:)];
    [self.topBackTempView addGestureRecognizer:topTap];
    
    UITapGestureRecognizer *backTwoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tampViewTouchAction:)];
    self.title = @"赏金";
    [self.backViewTwo addGestureRecognizer:backTwoTap];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.frame = CGRectMake(0, 0, 44, 44);
    
    [button addTarget:self action:@selector(refreshButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    CGFloat tempWidth = DLScreenWidth / 2 - 1;
    
    NSArray *array = @[@[@"icon_checkIn", @"签到", @"最高可得1元"],
                       @[@"icon_integral", @"积分兑换", @"当前积分0"],
                       @[@"icon_invite", @"邀请好友", @"邀请好友"]];
    
    for (int i = 0; i < 3; i++) {
        
        NSArray *temp = array[i];
        
        RewardVIew *view = [[RewardVIew alloc]initWithFrame:
        CGRectMake(i % 2 * tempWidth, i / 2 * 112, tempWidth - 1, 112)
    imageName:temp[0]
    title:temp[1]
    detailTitle:temp[2]];
        
        view.tag = i + 1;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tampViewTouchAction:)];
        [view addGestureRecognizer:tap];
        
        [self.backViewThree addSubview:view];
            }
    NSArray *modelArray = [IntegralModel findAll];
    if (modelArray.count > 0) {
        self.model = modelArray[0];
        [self reloadInterfaceViewWithModel:self.model];
    }
    
    
}


- (void)refreshButtonAction:(UIButton *)sender{
    [self netRequest];
}

- (void)netRequest{
    
    Account *acc = [Account findAll][0];
    
    NSDictionary *dic = @{@"customerId": acc.customerId};
    
    [RestfulAPIRequestTool routeName:@"reward_index" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        
        NSLog(@"取得的积分页面数据为 %@", json);
        
        NSDictionary *dic = json[@"data"];
        //先清一下表
        [IntegralModel clearTable];
        
        IntegralModel *model = [IntegralModel new];
        [model setValuesForKeysWithDictionary:dic];
        [model save];
        //刷新界面
        [self reloadInterfaceViewWithModel:model];
        
    } failure:^(id errorJson) {
        
        
    }];
    
}

- (void)reloadInterfaceViewWithModel: (IntegralModel *)model{
    
    self.surplusMoneyLabel.text = model.curMoney;
    self.todayIncome.text = [NSString stringWithFormat:@"今日收益(积分)\n\n%@", model.todayPoint];
    self.historyIncome.text = [NSString stringWithFormat:@"累计收益(积分)\n\n%@", model.curPoint];
    
    self.currentNum.text = [NSString stringWithFormat:@"当前任务 %@", model.sumReward];
    
}



- (void)topBackViewAction:(UITapGestureRecognizer *)sender{
    AccountBalanceViewController *ac = [[AccountBalanceViewController alloc]initWithNibName:@"AccountBalanceViewController" bundle:nil];
    ac.myMoney = self.model.curMoney;
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
            my.myIntegral = self.model.curPoint;
            
            [self.navigationController pushViewController:my animated:YES];
            
        }
            break;
        case 3:
        {
            InviteViewController *invite = [[InviteViewController alloc] initWithNibName:@"InviteViewController" bundle:nil];
            invite.inviteCode = self.model.inviteCode;
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
