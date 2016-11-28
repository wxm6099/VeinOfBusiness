//
//  SettingViewController.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *arraySource;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"设置";
    
    [self createUI];
}

- (void)createUI
{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
    //    [table registerClass:[AboutMeCell class] forCellReuseIdentifier:@"aboutMeFirst"];
    table.scrollEnabled = NO;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arraySource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.arraySource objectAtIndex:section];
    return array.count;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting"];
    
    NSArray *array = [_arraySource objectAtIndex:indexPath.section];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"name"];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 清理缓存
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                
                NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                NSLog(@"files :%lu",[files count]);
                for (NSString *p in files) {
                    NSError *error;
                    NSString *path = [cachPath stringByAppendingPathComponent:p];
                    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                    }
                }
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"清理缓存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                
            });
        }
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            // 退出登录
        }
    }
    
}

- (NSMutableArray *)arraySource
{
    if (!_arraySource) {
        
        //        UIImage *image0 = [UIImage imageNamed:@"DrawMoney"];
        //        NSDictionary *dic0 = @{@"image":image0,
        //                               @"name":@"提现"};

        NSDictionary *dic2 = @{@"name":@"缓存清理"};
        NSDictionary *dic3 = @{@"name":@"退出登录"};
        
        NSArray *arr1 = [NSArray arrayWithObjects:dic2, nil];
        NSArray *arr2 = [NSArray arrayWithObject:dic3];
        _arraySource = [NSMutableArray arrayWithObjects:arr1,arr2, nil];
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
