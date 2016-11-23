//
//  DLNavigationController.m
//  中航国际
//
//  Created by 太阳 on 16/4/3.
//  Copyright © 2016年 太阳. All rights reserved.
//

#import "DLNavigationController.h"
#import "UINavigationBar+DLNavigationBar.h"
#import "UIBarButtonItem+Extension.h"
#import "UIViewController+DismissKeyboard.h"

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
    
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        NSArray* filterControllers = @[@"AboutMeViewController",@"MoneyRewardViewController", @"TaskListViewController"];
        for (NSString* vcName in filterControllers) {
            if ([viewController isKindOfClass:NSClassFromString(vcName)]) {
                viewController.hidesBottomBarWhenPushed = NO;
            }
        }
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"return2" highImage:@""];
    }
    
    
    //所有得页面都进行键盘隐藏事件的监听
    [viewController setupForDismissKeyboard];
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:49526]) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:49526] removeFromSuperview];
        [[[UIApplication sharedApplication].keyWindow viewWithTag:49527] removeFromSuperview];
    }
    
    [super pushViewController:viewController animated:YES];
    
}
- (void)back
{

    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
