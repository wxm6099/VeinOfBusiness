//
//  MyIntegralViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "IntegralExchangeViewController.h"


@interface MyIntegralViewController ()

@end

@implementation MyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的积分";
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    [button setTitle:@"近期积分" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [button addTarget:self action:@selector(integralButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


- (IBAction)integralExchange:(id)sender {
    IntegralExchangeViewController *inter = [[IntegralExchangeViewController alloc] initWithNibName:@"IntegralExchangeViewController" bundle:nil];
    
    [self.navigationController pushViewController:inter animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)integralButtonAction:(UIButton *)sender
{
    
    
}

@end
