//
//  RankingViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RankingViewController.h"
#import "RankingCell.h"

@interface RankingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"排行";
    
    [self createUI];
    
}

- (void)createUI
{
    UILabel *labelNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, DLScreenWidth, 33)];
    labelNum.backgroundColor = [UIColor grayColor];
    labelNum.font = [UIFont systemFontOfSize:14];
    labelNum.textColor = [UIColor blackColor];
    labelNum.text = @"总人数:7,386,389";
    labelNum.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelNum];
    
//    UIView *viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 97, DLScreenWidth, 218)];
//    [self.view addSubview:viewHeader];
    
    UIImageView *imageViewSecond = [[UIImageView alloc]initWithFrame:CGRectMake(31, 160, 72, 72)];
    imageViewSecond.image = [UIImage imageNamed:@"Message"];
    imageViewSecond.layer.cornerRadius = 36;
    imageViewSecond.layer.masksToBounds = YES;
    imageViewSecond.layer.borderWidth = 2;
    imageViewSecond.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:imageViewSecond];
    
    UILabel *labelNameSecond = [[UILabel alloc]initWithFrame:CGRectMake(31, 261, 72, 20)];
    labelNameSecond.textAlignment = NSTextAlignmentCenter;
    labelNameSecond.font = [UIFont systemFontOfSize:14];
    labelNameSecond.text = @"那夜很美";
    [self.view addSubview:labelNameSecond];
    
    UILabel *labelMoneySecond = [[UILabel alloc]initWithFrame:CGRectMake(31, 287, 72, 16)];
    labelMoneySecond.textAlignment = NSTextAlignmentCenter;
    labelMoneySecond.font = [UIFont systemFontOfSize:11];
    labelMoneySecond.text = @"537.2元";
    [self.view addSubview:labelMoneySecond];
    
    
    UIImageView *imageViewFirst = [[UIImageView alloc]initWithFrame:CGRectMake(134, 121, 112, 112)];
    imageViewFirst.image = [UIImage imageNamed:@"Message"];
    imageViewFirst.layer.cornerRadius = 56;
    imageViewFirst.layer.masksToBounds = YES;
    imageViewFirst.layer.borderWidth = 2;
    imageViewFirst.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:imageViewFirst];
    
    UILabel *labelNameFirst = [[UILabel alloc]initWithFrame:CGRectMake(134, 260, 112, 22)];
    labelNameFirst.textAlignment = NSTextAlignmentCenter;
    labelNameFirst.font = [UIFont systemFontOfSize:16];
    labelNameFirst.text = @"哎哟不错先生";
    [self.view addSubview:labelNameFirst];
    
    UILabel *labelMoneyFirst = [[UILabel alloc]initWithFrame:CGRectMake(134, 286, 112, 17)];
    labelMoneyFirst.textAlignment = NSTextAlignmentCenter;
    labelMoneyFirst.font = [UIFont systemFontOfSize:12];
    labelMoneyFirst.text = @"2699元";
    [self.view addSubview:labelMoneyFirst];
    
    
    UIImageView *imageViewThird = [[UIImageView alloc]initWithFrame:CGRectMake(276, 165, 66, 66)];
    imageViewThird.image = [UIImage imageNamed:@"Message"];
    imageViewThird.layer.cornerRadius = 33;
    imageViewThird.layer.masksToBounds = YES;
    imageViewThird.layer.borderWidth = 2;
    imageViewThird.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:imageViewThird];
    
    UILabel *labelNameThird = [[UILabel alloc]initWithFrame:CGRectMake(276, 261, 66, 20)];
    labelNameThird.textAlignment = NSTextAlignmentCenter;
    labelNameThird.font = [UIFont systemFontOfSize:14];
    labelNameThird.text = @"无名之火";
    [self.view addSubview:labelNameThird];
    
    UILabel *labelMoneyThird = [[UILabel alloc]initWithFrame:CGRectMake(276, 287, 66, 16)];
    labelMoneyThird.textAlignment = NSTextAlignmentCenter;
    labelMoneyThird.font = [UIFont systemFontOfSize:11];
    labelMoneyThird.text = @"142元";
    [self.view addSubview:labelMoneyThird];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 325, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
//    [table registerClass:[RankingCell class] forCellReuseIdentifier:@"ranking"];
    //    [table registerClass:[AboutMeCell class] forCellReuseIdentifier:@"aboutMeFirst"];
    table.scrollEnabled = YES;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
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
    cell.imageView.image = [UIImage imageNamed:@"Message"];
    cell.textLabel.text = [dic objectForKey:@"name"];
    cell.detailTextLabel.text = [dic objectForKey:@"detail"];
    cell.labelMoney.text = @"85元";
    
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

- (NSMutableArray *)arraySource
{
    if (!_arraySource) {
        
        //        UIImage *image0 = [UIImage imageNamed:@"DrawMoney"];
        //        NSDictionary *dic0 = @{@"image":image0,
        //                               @"name":@"提现"};
        
        
        NSDictionary *dic1_1 = @{@"name":@"昵称",
                                 @"detail":@"哎哟不错先生"};
        
        NSDictionary *dic1_2 = @{@"name":@"性别",
                                 @"detail":@"男"};
        
        NSDictionary *dic1_3 = @{@"name":@"我的排行榜",
                                 @"detail":@"1990-08-08"};
        
        NSDictionary *dic1_4 = @{@"name":@"所在地区",
                                 @"detail":@"未设置"};
//        NSArray *arr1 = [NSArray arrayWithObjects:dic1_1,dic1_2,dic1_3,dic1_4, nil];
        
        _arraySource = [NSMutableArray arrayWithObjects:dic1_1,dic1_2,dic1_3,dic1_4, nil];
    }
    return _arraySource;
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
