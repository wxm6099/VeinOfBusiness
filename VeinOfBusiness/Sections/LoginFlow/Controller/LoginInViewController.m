//
//  LoginInViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LoginInViewController.h"

#import "PasswordOperationViewController.h"


@interface LoginInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;


@property (weak, nonatomic) IBOutlet UIButton *loginInButton;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;

@end

@implementation LoginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(JumpAction)]];
    
    self.loginInButton.backgroundColor = CustomColor;
    
    [self.registerButton setTitleColor:CustomColor forState:UIControlStateNormal];
    
    [self.forgetPasswordButton setTitleColor:CustomColor forState:UIControlStateNormal];
    
    
    
    
}

//登录
- (IBAction)loginButtonAction:(id)sender {
    
    [self JumpAction];
    
}

//注册
- (IBAction)registerButtonAcction:(id)sender {
    
    PasswordOperationViewController *password = [[PasswordOperationViewController alloc]initWithNibName:@"PasswordOperationViewController" bundle:nil];
    password.pageState = YES;
    [self.navigationController pushViewController:password animated:YES];
    
}
//忘记密码
- (IBAction)forgetPasswordAction:(id)sender {
    
    PasswordOperationViewController *password = [[PasswordOperationViewController alloc]initWithNibName:@"PasswordOperationViewController" bundle:nil];
    
    [self.navigationController pushViewController:password animated:YES];
    
}


//登陆成功跳转页面
- (void)JumpAction{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"WindowChangeRoot" object:nil];
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
