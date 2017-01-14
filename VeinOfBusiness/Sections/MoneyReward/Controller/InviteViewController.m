//
//  InviteViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/8.
//  Copyright © 2016年 Apple. All rights reserved.
//做个截图

#import "InviteViewController.h"
#import "ShareUtil.h"


@interface InviteViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewBottom;
@property (weak, nonatomic) IBOutlet UIButton *inviteButton;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.backViewWidth.constant = DLScreenWidth;
    self.backViewBottom.constant = DLScreenHeight - 353;
}
- (IBAction)inviteAction:(id)sender {
    ShareUtil * share = [ShareUtil new];
    
    NSDictionary *dic = @{@"url":@"url",
                          @"title":[NSString stringWithFormat:@"我的邀请码:%@",self.inviteCode],
                          @"description":@"我在金脉,分享就能赚钱,快来加入吧!"};
    [share shareWeChatTimeLineWithLink:dic];
    NSLog(@"分享!");
    
//    Account *acc = [Account findAll][0];
//    NSDictionary *dic = @{@"customerId": acc.customerId,@"adId": self.model.adId};
//    [RestfulAPIRequestTool routeName:@"ad_forward" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
//        
//        NSLog(@"转发结果为 %@", json);
//        
//        
//    } failure:^(id errorJson) {
//        
//    }];
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
