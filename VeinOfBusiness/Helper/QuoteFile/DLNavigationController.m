//
//  DLNavigationController.m
//  中航国际
//
//  Created by 太阳 on 16/4/3.
//  Copyright © 2016年 太阳. All rights reserved.
//

#import "DLNavigationController.h"

@interface DLNavigationController ()

@end

@implementation DLNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置title颜色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    //设置背景颜色
    [self.navigationBar setBarTintColor:CustomColor];
    //设置返回键颜色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;

    [super pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
