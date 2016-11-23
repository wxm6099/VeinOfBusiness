//
//  MyIntegralViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "IntegralExchangeViewController.h"
#import "IntegralExchangeHistoryView.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"


@interface MyIntegralViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myIntegralLabel;
@property (weak, nonatomic) IBOutlet UITextField *exchangeNumTextField;

@end

@implementation MyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的积分";
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    [button setTitle:@"积分历史" forState:UIControlStateNormal];
    [button.titleLabel setTextAlignment:NSTextAlignmentRight];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [button addTarget:self action:@selector(integralButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.myIntegralLabel.text = self.myIntegral;
}


- (IBAction)integralExchange:(id)sender {
    
    //取消跳跃界面
    
//    IntegralExchangeViewController *inter = [[IntegralExchangeViewController alloc] initWithNibName:@"IntegralExchangeViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:inter animated:YES];
    
    NSInteger num = [self.exchangeNumTextField.text integerValue];
    NSInteger allNum = [self.myIntegral integerValue];
    
    
    if (num  < 1000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"兑换失败" message:@"最少兑换1000积分" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        
    } else if (num > allNum) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"兑换失败" message:@"超出积分额度" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
         [alert show];
        
    } else {
        
        NSInteger money = num / 1000;
        NSInteger lastMoney = num % 1000;
        NSString *str;
        if ((num % 1000) != 0) {
            str = [NSString stringWithFormat:@"您可以兑换%ld元,多余的积分将返回您的账户,确认兑换吗?", money];
        } else
        {
            str = [NSString stringWithFormat:@"您可以兑换%ld元,确认兑换吗?", num];
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"兑换积分" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            Account * acc = [Account findAll][0];
            
            NSDictionary *dic = @{@"customerId": acc.customerId, @"costPoint":[NSString stringWithFormat:@"%ld", num / 1000 * 1000], @"getMoney":[NSString stringWithFormat:@"%ld", money]};
            /*
             customerId:
             costPoint：消耗积分
             getMoney:兑换
             */
            [RestfulAPIRequestTool routeName:@"reward_change" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
                
                NSLog(@"兑换数据为 %@", json);
                
                NSString *state = json[@"status"];
                if ([state isEqualToString:@"success"]) {
                    
                    NSInteger nowIntegral = [self.myIntegralLabel.text integerValue];
                    self.myIntegralLabel.text = [NSString stringWithFormat:@"%ld", nowIntegral - money * 1000];
                    self.exchangeNumTextField.text = @"";
                    
                    UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"兑换成功!" message:@"去提现吧" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                    [successAlert show];
                    
                }
            } failure:^(id errorJson) {
                
            }];
            
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
    /*if ((num % 1000) != 0) {
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"兑换失败" message:@"您最少兑换一元" preferredStyle:UIAlertControllerStyleAlert];
     [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
     self.exchangeNumTextField.text = [NSString stringWithFormat:@"%ld", num / 1000 * 1000];
     }]];
     [self presentViewController:alert animated:YES completion:nil];
     }*/
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)integralButtonAction:(UIButton *)sender
{
    IntegralExchangeHistoryView *exchange = [[IntegralExchangeHistoryView alloc]initWithNibName:@"IntegralExchangeHistoryView" bundle:nil];
    [self.navigationController pushViewController:exchange animated:YES];
    
}


- (void)setMyIntegral:(NSString *)myIntegral
{
    _myIntegral = myIntegral;
    
    
    
}

@end
