//
//  AccountBalanceViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "AccountBalanceViewController.h"
#import "WithdrawRecordViewController.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"



@interface AccountBalanceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *withdraw;

@end

@implementation AccountBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myMoneyLabel.text = self.myMoney;
}


- (IBAction)withdrawRecordAction:(id)sender {
    WithdrawRecordViewController *with = [[WithdrawRecordViewController alloc]initWithNibName:@"WithdrawRecordViewController" bundle:nil];
    [self.navigationController pushViewController:with animated:YES];
}

- (IBAction)withDrawButtonAction:(id)sender {
    
    NSInteger drawMoney = [self.withdraw.text integerValue];
    
    NSInteger money = [self.myMoney integerValue];
    
    __block NSString *alertTitle;
    __block NSString *alertMessage;
    
    if (drawMoney > money) {
        
        alertTitle = @"请求失败!";
        alertMessage = @"超出可提现的最大金额";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        Account *acc = [Account findAll][0];
        NSDictionary *dic = @{@"customerId": acc.customerId, @"costMoney":self.withdraw.text};
        [RestfulAPIRequestTool routeName:@"reward_withdraw" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
            NSLog(@"提现结果为 %@", json);;
            
            if ([json[@"status"] isEqualToString:@"success"]) {
                self.myMoneyLabel.text = [NSString stringWithFormat:@"%ld", money - drawMoney];
                self.withdraw.text = @"";
                self.myMoney = [NSString stringWithFormat:@"%ld", money - drawMoney];
                alertTitle = @"提现请求发送成功!";
                alertMessage = @"我们将会在1~3天内处理您的提现请求!";
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshUserRewardMoneyData" object:nil];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [alert show];
                
                
            }
            
        } failure:^(id errorJson) {
            
        }];
    }
    
    
    
    
}

- (void)setMyMoney:(NSString *)myMoney
{
    _myMoney = myMoney;
}


@end
