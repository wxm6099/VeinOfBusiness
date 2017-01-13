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

@interface AboutMeViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
    
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadView)];
    viewa.userInteractionEnabled = YES;
    [viewa addGestureRecognizer:tap0];
    
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
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *str = [NSString stringWithFormat:@"%@将会访问您的图库或相机",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    NSString *message = NSLocalizedString(str, nil);
    NSString *cameraTitle = NSLocalizedString(@"相机", nil);
    NSString *photoTitle = NSLocalizedString(@"图库", nil);
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 相机 按钮
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:cameraTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *caPicker = [[UIImagePickerController alloc]init];
        caPicker.delegate = self;
        caPicker.allowsEditing = YES;
        caPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:caPicker animated:YES completion:nil];
    }];
    
    // 图库 按钮
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:photoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    // 取消 按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
        
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [alertController addAction:cameraAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)tapHeadView
{
    UserViewController *user = [[UserViewController alloc]init];
    [self.navigationController pushViewController:user animated:YES];
}

// 当得到照片或者视频后，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //    NSLog(@"选中图片");
    //    NSLog(@"%@",info);
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    // 判断获取类型 : 图片
    if ([type isEqualToString:@""]) {
//        self.selectImage = [UIImage imageNamed:@"3"];
        // 判断, 图片是否允许修改
        if ([picker allowsEditing]) {
            // 获取用户编辑过后的图片
//            self.selectImage = [info objectForKey:UIImagePickerControllerEditedImage];
//            [self.headImage setImage:self.selectImage forState:UIControlStateNormal];
            
        } else {
            // 获取编辑前的图片
//            self.headImage.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
//            [self.headImage setImage:self.selectImage forState:UIControlStateNormal];
        }
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消选中");
    [picker dismissViewControllerAnimated:YES completion:nil];
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
