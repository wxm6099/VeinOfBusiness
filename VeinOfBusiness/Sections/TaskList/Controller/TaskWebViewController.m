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

@interface TaskWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation TaskWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [button setTitle:@"分享" forState:UIControlStateNormal];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setModel:(AdvertiseModel *)model
{
    _model = model;
    
    
}




@end
