//
//  DrawMoneyViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DrawMoneyViewController.h"

@interface DrawMoneyViewController ()

@end

@implementation DrawMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"提现";
    self.view.backgroundColor = BackColor;
    
    [self createUI];
}

- (void)createUI
{
    UIView *viewa = [[UIView alloc]initWithFrame:CGRectMake(90, 100, DLScreenWidth - 90*2, DLScreenWidth - 90*2)];
    viewa.layer.cornerRadius = (DLScreenWidth - 90*2)/2;
    viewa.layer.borderColor = [UIColor redColor].CGColor;
    viewa.layer.borderWidth = 10;
    viewa.layer.masksToBounds = YES;
    viewa.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewa];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 70, 40)];
    label.text = @"当前余额";
    [viewa addSubview:label];
    
    UILabel *labelMoney = [[UILabel alloc]initWithFrame:CGRectMake(50, 70, 80, 70)];
    labelMoney.textAlignment = NSTextAlignmentCenter;
    labelMoney.font = [UIFont systemFontOfSize:30];
    labelMoney.text = @"500";
    [viewa addSubview:labelMoney];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 450, 200, 50)];
    [button addTarget:self action:@selector(getMoney) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提现到支付宝" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:button];

}

- (void)getMoney
{
    
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
