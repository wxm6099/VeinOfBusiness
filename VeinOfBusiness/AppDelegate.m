//
//  AppDelegate.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "AboutMeViewController.h"
#import "MoneyRewardViewController.h"
#import "TaskListViewController.h"
#import "LoginInViewController.h"
#import "DLNavigationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //这儿是商脉APP的第一行代码
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginInSucceed) name:@"WindowChangeRoot" object:nil];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        
        
        LoginInViewController *loginIn = [[LoginInViewController alloc] initWithNibName:@"LoginInViewController" bundle:nil];
        DLNavigationController *nav = [[DLNavigationController alloc]initWithRootViewController:loginIn];
        [_window setRootViewController:nav];
        
        
    }
    return _window;
}

//登陆成功
- (void)loginInSucceed{
    
    
    UITabBarController *tab = [[UITabBarController alloc]init];
    UITabBar *tabBar = [tab tabBar];
    [tabBar setTintColor:[UIColor whiteColor]];
    tabBar.barTintColor = CustomColor;
    
    
//    [tabBar setSelectedImageTintColor:[UIColor orangeColor]];
    //任务列表view
    TaskListViewController *taskListView = [[TaskListViewController alloc]initWithNibName:@"TaskListViewController" bundle:nil];
    DLNavigationController *navOne = [[DLNavigationController alloc]initWithRootViewController:taskListView];
    taskListView.tabBarItem.title = @"任务";
    
    //赏金列表
    MoneyRewardViewController * moneyReward= [[MoneyRewardViewController alloc] initWithNibName:@"MoneyRewardViewController" bundle:nil];
    DLNavigationController *navTwo = [[DLNavigationController alloc]initWithRootViewController:moneyReward];
    moneyReward.tabBarItem.title = @"赏金";
    
    //个人页面
    AboutMeViewController *me = [[AboutMeViewController alloc] initWithNibName:@"AboutMeViewController" bundle:nil];
    DLNavigationController *navThree = [[DLNavigationController alloc]initWithRootViewController:me];
    me.tabBarItem.title = @"我的";
    
    [tab addChildViewController:navOne];
    [tab addChildViewController:navTwo];
    [tab addChildViewController:navThree];
    
    [_window setRootViewController:tab];
    
}







@end
