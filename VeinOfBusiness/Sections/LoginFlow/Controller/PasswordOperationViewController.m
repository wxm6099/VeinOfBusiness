//
//  PasswordOperationViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "PasswordOperationViewController.h"

@interface PasswordOperationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfPasswordOne;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfPasswordTwo;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfCode;
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;

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







- (void)setPageState:(BOOL)pageState
{
    _pageState = pageState;
}



@end
