//
//  PasswordOperationViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "PasswordOperationViewController.h"
#import "RestfulAPIRequestTool.h"
#import "ComObjectMethod.h"
#import "LoginInViewController.h"


@interface PasswordOperationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfPasswordOne;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfPasswordTwo;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfCode;
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@end

@implementation PasswordOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.pageState) {
        self.title = @"注册账号";
        
        
    } else{
        self.title = @"忘记密码";
        
    }
    self.view.backgroundColor = BackColor;
    self.RegisterButton.backgroundColor = CustomColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)registerButtonAction:(id)sender {
    
    
    NSString *title;
    NSString *message;
    
    BOOL judge = NO;
    
    NSString *phone = self.textFieldOfPhone.text;
    NSString *password = self.textFieldOfPasswordOne.text;
    NSString *passwordAgain = self.textFieldOfPasswordTwo.text;
    
    if  (phone.length ==0 ||
         password.length == 0 ||
         passwordAgain.length == 0) {
        
        title = @"注册失败";
        message = @"请填写完整信息";
    } else {
        
        if ([ComObjectMethod isMobile:phone]) {
            
            if ([password isEqualToString:passwordAgain]) {
                judge = YES;
                
            } else {
                title = @"注册失败";
                message = @"两次密码不一致";
            }
            
        } else {
            title = @"注册失败";
            message = @"请填写正确的手机号码";
        }
    }
    
    if (judge) {
        
        
        
        NSDictionary *dic = @{@"mobile":phone,
                              @"sms":@"123456",
                              @"password":password,
                              @"userType":@"3",
                              @"phoneMobile": phone,
                              @"inviterCode":@"edwhu"};
        
        [RestfulAPIRequestTool routeName:@"login_register" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
            NSLog(@"注册成功结果为:%@", json);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册成功!" message:@"去登录吧!" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                LoginInViewController *loginIn = [[LoginInViewController alloc]initWithNibName:@"LoginInViewController" bundle:nil];
                [self.navigationController pushViewController:loginIn animated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
        } failure:^(id errorJson) {
            NSLog(@"注册失败结果为:%@", errorJson);
        }];
        
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

- (IBAction)geiCodeButton:(id)sender {
    
    
    NSString *str = self.textFieldOfPhone.text;
    if (![ComObjectMethod isMobile:str]) {
        return;
    }
    
    
    NSDictionary *dic = @{@"mobile":str,
                          @"type":@"1"};
    
    [RestfulAPIRequestTool routeName:@"login_regsms" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        NSLog(@"获取验证码成功!结果为%@", json);
    } failure:^(id errorJson) {
        NSLog(@"获取验证码失败,结果为%@", errorJson);
    }];
    
    
}




- (void)setPageState:(BOOL)pageState
{
    _pageState = pageState;
}



@end
