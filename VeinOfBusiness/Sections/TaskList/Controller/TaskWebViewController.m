//
//  TaskWebViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "AdvertiseModel.h"
#import "TaskWebViewController.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"
#import "ShareUtil.h"



@interface TaskWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation TaskWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [button setTitle:@"分享" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    NSURL* url = [NSURL URLWithString:self.model.link];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.myWebView loadRequest:request];
    
    NSDictionary *dic = @{@"adId": self.model.adId};
    [RestfulAPIRequestTool routeName:@"ad_open" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        
        NSLog(@"反馈数据为%@", json);
        
    } failure:^(id errorJson) {
        
    }];
    
}

- (void)shareButtonAction:(UIButton *)sender
{
    ShareUtil * share = [ShareUtil new];
    [share shareWeChatTimeLineWithLink:@{@"url":self.model.link, @"title":@"我在商脉发现了这个,来看看吧!", @"description":@"it is the description of balabala"}];
    NSLog(@"分享!");
    
    Account *acc = [Account findAll][0];
    NSDictionary *dic = @{@"customerId": acc.customerId,@"adId": self.model.adId};
    [RestfulAPIRequestTool routeName:@"ad_forward" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        
        NSLog(@"转发结果为 %@", json);
        
        
    } failure:^(id errorJson) {
        
    }];
    
    
    
    
    
}
- (void)setModel:(AdvertiseModel *)model
{
    _model = model;
    
    
}




@end
