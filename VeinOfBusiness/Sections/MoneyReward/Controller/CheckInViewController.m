//
//  CheckInViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CheckInViewController.h"

@interface CheckInViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation CheckInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myScrollView.contentSize = CGSizeMake(0, DLMultipleHeight(800));
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLMultipleHeight(196.0))];
    image.backgroundColor = [UIColor grayColor];
    [self.myScrollView addSubview:image];
    
    
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0 ,image.frame.origin.y + image.frame.size.height + 10, DLScreenWidth, 50)];
    
    tempView.backgroundColor = [UIColor whiteColor];
    
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, DLScreenWidth, 50)];
    money.font = [UIFont systemFontOfSize:14];
    money.text = @"你本月签到已获得:1545";
    [tempView addSubview:money];
    [self.myScrollView addSubview:tempView];
    
    
    UIView *dateView = [[UIView alloc]initWithFrame:CGRectMake(0, tempView.frame.origin.y + tempView.frame.size.height + 10, DLScreenWidth, DLMultipleHeight(260.0))];
    dateView.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview:dateView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, dateView.frame.size.height + dateView.frame.origin.y, DLScreenWidth, 90)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"签到规则:\n1.每日签到可获得0.01-1奖励金,金额随机\n2.每日限签到一次.";
    label.numberOfLines = 0;
    [self.myScrollView addSubview:label];
    
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
