//
//  AboutMeViewController.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "AboutMeViewController.h"

#import "MessageViewController.h"
#import "SettingViewController.h"
#import "RankingViewController.h"
#import "DrawMoneyViewController.h"
#import "UserViewController.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"
#import "ShareUtil.h"
#import "WXApi.h"
#import "AccountBalanceViewController.h"

@interface AboutMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;

@property (nonatomic,retain) UIImageView *imageViewHead;
@property (nonatomic,retain) UILabel *labelName;


@end

@implementation AboutMeViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作
        Account *acc = [[Account findAll] objectAtIndex:0];
        
        NSDictionary *dic = @{@"customerId" : acc.customerId};
        [RestfulAPIRequestTool routeName:Personalcenter_detail_URL requestModel:dic useKeys:[dic allKeys] success:^(id json) {
            
            NSLog(@"请求结果为%@", json);
//            {
//            status:"success"，
//                data：{username：用户名,
//                    mobile：
//                    Pic：},
//            Msg:""
//            }
            
            NSString *status = [json objectForKey:@"status"];
            NSDictionary *dicData = [json objectForKey:@"data"];
            
            if (status) {
                
                if ([status isEqualToString:@"success"]) {
                    
                    if (dicData) {
                        NSString *imgUrl = [dicData objectForKey:@"pic"];
                        NSString *username = [dicData objectForKey:@"username"];
//                        NSString *mobile = [dicData objectForKey:@"mobile"];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if ([imgUrl isKindOfClass:[NSNull class]] || !imgUrl) {
//                                self.imageViewHead.image = [UIImage imageNamed:@"Message"];
                            } else {
                                [self.imageViewHead setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]]];
                            }
                            [self.labelName setText:username];
                        });
                    }
                }
            }
            
            
        } failure:^(id errorJson) {
            NSLog(@"登录结果为%@", errorJson);
        }];
        
        
        
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;    
}

- (void)viewDidDisappear:(BOOL)animated
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self createUI];
}

- (void)createUI
{
    UIView *viewa = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, 164)];
    viewa.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewa];
    
    self.imageViewHead = [[UIImageView alloc]initWithFrame:CGRectMake(18, 55, 62, 62)];
    _imageViewHead.image = [UIImage imageNamed:@"Message"];
    _imageViewHead.layer.cornerRadius = 30;
    _imageViewHead.layer.masksToBounds = YES;
    _imageViewHead.layer.borderWidth = 2;
    _imageViewHead.layer.borderColor = [UIColor redColor].CGColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
    _imageViewHead.userInteractionEnabled = YES;
    [_imageViewHead addGestureRecognizer:tap];
    [viewa addSubview:_imageViewHead];
    
    self.labelName = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, 300, 22)];
    _labelName.text = @"哎哟不错先生";
    [viewa addSubview:_labelName];
    

    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 164, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aboutMe"];
//    [table registerClass:[AboutMeCell class] forCellReuseIdentifier:@"aboutMeFirst"];
    table.scrollEnabled = NO;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arraySource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aboutMe"];
    NSDictionary *dic = [_arraySource objectAtIndex:indexPath.row];
    cell.imageView.image = [dic objectForKey:@"image"];
    cell.textLabel.text = [dic objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        DrawMoneyViewController *draw = [[DrawMoneyViewController alloc]init];
//        [self.navigationController pushViewController:draw animated:YES];
        AccountBalanceViewController *account = [[AccountBalanceViewController alloc]init];
        [self.navigationController pushViewController:account animated:YES];
    }
    if (indexPath.row == 1) {
        MessageViewController *message = [[MessageViewController alloc]init];
        [self.navigationController pushViewController:message animated:YES];
    }
    if (indexPath.row == 2) {
        RankingViewController *rank = [[RankingViewController alloc]init];
        [self.navigationController pushViewController:rank animated:YES];
    }
    if (indexPath.row == 3) {
        SettingViewController *setting = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:setting animated:YES];
    }
}

- (void)tapImage
{
    UserViewController *user = [[UserViewController alloc]init];
    [self.navigationController pushViewController:user animated:YES];
//    NSDictionary *dic = @{@"url":@"http://www.baidu.com",
//                          @"title":@"这里是分享的标题",
//                          @"description":@"这里是分享的描述",
//                          @"imgUrl":@"这里是分享的图片"};
//
//    ShareUtil *share = [[ShareUtil alloc]init];
//    if ([WXApi isWXAppInstalled]) {
//        
//        if ([WXApi isWXAppSupportApi]) {
//            
////            [share returnShareDic:^(NSDictionary *dicc) {
////                
////            }];
//            [share shareFriend:dic];
//            
//            }
//    
//        } else {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的微信版本不支持此操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alert show];
//            
//        }
    
}


- (NSMutableArray *)arraySource
{
    if (!_arraySource) {
        
//        UIImage *image0 = [UIImage imageNamed:@"DrawMoney"];
//        NSDictionary *dic0 = @{@"image":image0,
//                               @"name":@"提现"};
        
        UIImage *image1 = [UIImage imageNamed:@"DrawMoney"];
        NSDictionary *dic1 = @{@"image":image1,
                               @"name":@"提现"};
        
        UIImage *image2 = [UIImage imageNamed:@"Message"];
        NSDictionary *dic2 = @{@"image":image2,
                               @"name":@"我的消息"};
        
        UIImage *image3 = [UIImage imageNamed:@"RankList"];
        NSDictionary *dic3 = @{@"image":image3,
                               @"name":@"我的排行榜"};
        
        UIImage *image4 = [UIImage imageNamed:@"Setting"];
        NSDictionary *dic4 = @{@"image":image4,
                               @"name":@"设置"};
        _arraySource = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4, nil];
    }
    return _arraySource;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIImageView *)imageViewHead
//{
//    if (_imageViewHead) {
//        
//    }
//    return _imageViewHead;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
