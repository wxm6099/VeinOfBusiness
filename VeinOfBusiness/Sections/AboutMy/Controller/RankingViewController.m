//
//  RankingViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RankingViewController.h"
#import "RankingCell.h"
#import "RestfulAPIRequestTool.h"
#import "MBProgressHUD.h"

@interface RankingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;
@property (nonatomic,retain) UITableView *table;

@property (nonatomic,retain) MBProgressHUD *HUD;

@end

@implementation RankingViewController

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作
//        Account *acc = [[Account findAll] objectAtIndex:0];
        
        NSDictionary *dic = @{@"index" : @"25"};
        [RestfulAPIRequestTool routeName:Personal_rank_URL requestModel:dic useKeys:[dic allKeys] success:^(id json) {
            
            NSLog(@"请求结果为%@", json);
            
            NSString *status = [json objectForKey:@"status"];
            if ([status isEqualToString:@"success"]) {
                
                
                NSArray *arrData = [json objectForKey:@"data"];
                self.arraySource = [NSMutableArray arrayWithArray:arrData];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.table reloadData];
                    [self.HUD hideAnimated:YES];
                    if (self.arraySource.count == 0) {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有更多排行榜数据" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alert show];
                    }
                });
            }
            
        } failure:^(id errorJson) {
            NSLog(@"登录结果为%@", errorJson);
        }];
        
        
        
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.HUD.label.text = @"loading";
    
    self.navigationItem.title = @"排行";
    self.arraySource = [NSMutableArray array];
    [self createUI];
    
}

- (void)createUI
{
//    UILabel *labelNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, 33)];
//    labelNum.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
//    labelNum.font = [UIFont systemFontOfSize:14];
//    labelNum.textColor = [UIColor blackColor];
//    labelNum.text = @"总人数:7,386,389";
//    labelNum.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:labelNum];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
//    self.table.tableHeaderView = labelNum;
//    [table registerClass:[RankingCell class] forCellReuseIdentifier:@"ranking"];
    //    [table registerClass:[AboutMeCell class] forCellReuseIdentifier:@"aboutMeFirst"];
    _table.scrollEnabled = YES;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    static NSString *ident = @"ranking";
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[RankingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    NSDictionary *dic = [self.arraySource objectAtIndex:indexPath.row];
    NSString *imgUrl = [dic objectForKey:@"pic"];
    if (imgUrl&&![imgUrl isEqual:[NSNull null]]) {
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_host,imgUrl]]]];
        image = [self cutImage:image];
        cell.imageView.image = image;
//        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_host,imgUrl]]]];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"head"];
    }
    cell.textLabel.text = [dic objectForKey:@"username"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"第%ld名",indexPath.row + 1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labelMoney.text = [NSString stringWithFormat:@"%@积分",[dic objectForKey:@"sumPoint"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
        }
        if (indexPath.row == 1) {
            
        }
        if (indexPath.row == 2) {
            
        }
        if (indexPath.row == 3) {
            
        }
    }
    
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (50 / 50)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * 50 / 50;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * 50 / 50;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
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
