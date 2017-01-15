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
#import "CLAnimationView.h"





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
    NSDictionary *dic_share = @{@"url":self.model.link,
                          @"title":[NSString stringWithFormat:@"我的邀请码:%@",@"1"],
                          @"description":@"我在金脉,分享就能赚钱,快来加入吧!"};
    ShareUtil *share = [[ShareUtil alloc]init];
    NSLog(@"分享!");
    
    NSMutableArray *titarray = [NSMutableArray arrayWithObjects:@"微信好友",@"朋友圈", nil];
    NSMutableArray *picarray = [NSMutableArray arrayWithObjects:@"WeChatSession",@"WeChatTimeLine", nil];
    CLAnimationView *animationView = [[CLAnimationView alloc]initWithTitleArray:titarray picarray:picarray];
    [animationView selectedWithIndex:^(NSInteger index,id shareType) {
        
        switch (index) {
            case 1:
                [share shareWeChatSessionWithLink:dic_share];
                break;
            case 2:
                [share shareWeChatTimeLineWithLink:dic_share];
                break;
            default:
                break;
        }
    }];
    
    [animationView show];
    
    
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
