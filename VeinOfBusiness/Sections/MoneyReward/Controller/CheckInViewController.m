//
//  CheckInViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "RestfulAPIRequestTool.h"
#import "CheckInViewController.h"
#import "CalendarView.h"
#import "Account.h"
@interface CheckInViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, strong)CalendarView *dateView;
@property (nonatomic, strong)UILabel *money;

@end

@implementation CheckInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self netRequest];
    self.title = @"签到";
    self.myScrollView.contentSize = CGSizeMake(0, DLMultipleHeight(800));
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLMultipleHeight(196.0))];
    image.image = [UIImage imageNamed:@"icon_checkInPage"];
    image.backgroundColor = [UIColor grayColor];
    [self.myScrollView addSubview:image];
    
    
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0 ,image.frame.origin.y + image.frame.size.height + 10, DLScreenWidth, 50)];
    
    tempView.backgroundColor = [UIColor whiteColor];
    
    self.money = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, DLScreenWidth, 50)];
    self.money.font = [UIFont systemFontOfSize:14];
    self.money.text = @"你本月签到已获得:1545";
    [tempView addSubview:self.money];
    [self.myScrollView addSubview:tempView];
    
    
//    UIView *dateView = [[UIView alloc]initWithFrame:CGRectMake(0, tempView.frame.origin.y + tempView.frame.size.height + 10, DLScreenWidth, DLMultipleHeight(260.0))];
//    dateView.backgroundColor = [UIColor whiteColor];
    
    self.dateView = [[CalendarView alloc]initWithFrame:CGRectMake(0, tempView.frame.origin.y + tempView.frame.size.height + 10, DLScreenWidth, DLMultipleHeight(260.0))];
    
    
    [self.myScrollView addSubview:self.dateView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, self.dateView.frame.size.height + self.dateView.frame.origin.y, DLScreenWidth, 90)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"签到规则:\n1.每日签到可获得0.01-1奖励金,金额随机\n2.每日限签到一次.";
    label.numberOfLines = 0;
    [self.myScrollView addSubview:label];
    
    
}

- (void)netRequest{
    //签到
    Account *acc = [Account findAll][0];
    
    NSDictionary *dic = @{@"customerId":acc.customerId};
    [RestfulAPIRequestTool routeName:@"reward_sign" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        NSLog(@"签到结果为 %@", json);
        
        NSString *status = json[@"status"];
        
        if ([status isEqualToString:@"success"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"签到成功!" message:[NSString stringWithFormat:@"今天获取%@积分,再接再厉!", json[@"data"][@"signHistory"][@"point"]] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    } failure:^(id errorJson) {
        
    }];
    
    
    
    [RestfulAPIRequestTool routeName:@"reward_signhistory" requestModel:dic useKeys:[dic allKeys] success:^(id json) {
        NSLog(@"获取的签到历史为 %@", json);
        NSString *status = json[@"status"];
        if ([status isEqualToString:@"success"]) {
            NSArray *array = json[@"data"];
            NSInteger num = 0;
            NSMutableArray *dateArray = [NSMutableArray new];
            for (NSDictionary *tempDic in array) {
                NSInteger point = [tempDic[@"point"] integerValue];
                num += point;
                
                NSString *date = tempDic[@"signTime"];
                NSString *tempDate = [date substringFromIndex:date.length - 2];
                
                [dateArray addObject:tempDate];
            }
            
            self.money.text = [NSString stringWithFormat:@"你本月签到已获得: %ld", num];
            [self.dateView reloadCollectionViewWithArray:dateArray];
        }
    } failure:^(id errorJson) {
        
    }];
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
