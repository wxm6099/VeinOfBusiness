//
//  CommonViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/12/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CommonViewController.h"
#import "MBProgressHUD.h"
@interface CommonViewController ()<UIWebViewDelegate>
@property (nonatomic,retain) MBProgressHUD *HUD;


@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.HUD.label.text = @"loading";
    
    [self createUI];
}

- (void)createUI{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight)];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.HUD hideAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self.HUD hideAnimated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self.HUD hideAnimated:YES];
    return YES;
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
