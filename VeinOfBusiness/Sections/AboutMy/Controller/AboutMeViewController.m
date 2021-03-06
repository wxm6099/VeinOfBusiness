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

#import "UserViewController.h"
#import "RestfulAPIRequestTool.h"
#import "Account.h"
#import "ShareUtil.h"
#import "WXApi.h"
#import "AccountBalanceViewController.h"

#import <AFNetworking.h>
#import "MBProgressHUD.h"



#define COLOR_AboutMe    [UIColor colorWithRed:42/255.0f green:135/255.0f blue:255/255.0f alpha:1.0]

@interface AboutMeViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,retain) NSMutableArray *arraySource;

@property (nonatomic,retain) UIImageView *imageViewHead;
@property (nonatomic,retain) UILabel *labelName;

@property (nonatomic,retain) MBProgressHUD *HUD;

@end

@implementation AboutMeViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    Account *acc = [[Account findAll] objectAtIndex:0];
    _labelName.text = acc.username;
    _imageViewHead.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",acc.photo]]]];
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notify:) name:NOTIFY_Personal object:nil];
    
    [self createUI];
    [self getPersonDetail];
    
}

- (void)getPersonDetail{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作
        Account *acc = [[Account findAll] objectAtIndex:0];
        
        NSDictionary *dic = @{@"customerId" : acc.customerId};
        [RestfulAPIRequestTool routeName:Personal_detail_URL requestModel:dic useKeys:[dic allKeys] success:^(id json) {
            
            NSLog(@"请求结果为%@", json);
            NSString *status = [json objectForKey:@"status"];
            NSDictionary *dicData = [json objectForKey:@"data"];
            if ([status isEqualToString:@"success"]) {
                
                if (dicData) {
                    NSString *imgUrl = [dicData objectForKey:@"pic"];
                    NSString *username = [dicData objectForKey:@"username"];
                    
                    [acc setValuesForKeysWithDictionary:dicData];
                    [acc update];
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.imageViewHead setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_host,imgUrl]]]]];
                        [self.labelName setText:username];
                    });
                }
            }

        } failure:^(id errorJson) {
            NSLog(@"登录结果为%@", errorJson);
        }];
        
    });
}



- (void)createUI
{
    UIView *viewa = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth, 164)];
    viewa.frame = [self adaptFrame:viewa.frame];
    viewa.backgroundColor = COLOR_AboutMe;
    [self.view addSubview:viewa];
    
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadView)];
    viewa.userInteractionEnabled = YES;
    [viewa addGestureRecognizer:tap0];
    
    self.imageViewHead = [[UIImageView alloc]initWithFrame:CGRectMake(18, 55, 60, 60)];
    _imageViewHead.layer.cornerRadius = 30;
    _imageViewHead.layer.masksToBounds = YES;
    _imageViewHead.layer.borderWidth = 2;
    _imageViewHead.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
    _imageViewHead.userInteractionEnabled = YES;
    [_imageViewHead addGestureRecognizer:tap];
    [viewa addSubview:_imageViewHead];
    
    self.labelName = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, 300, 22)];
    [viewa addSubview:_labelName];
    
    UIImageView *imageViewArrow = [[UIImageView alloc]initWithFrame:CGRectMake(DLScreenWidth - 26, 80, 10, 14)];
    imageViewArrow.image = [UIImage imageNamed:@"Arrow"];
    [viewa addSubview:imageViewArrow];
    

    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 164, DLScreenWidth, DLScreenHeight) style:UITableViewStyleGrouped];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aboutMe"];
    table.scrollEnabled = NO;
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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aboutMe"];
    
    NSDictionary *dic = [self.arraySource objectAtIndex:indexPath.row];
    
    cell.imageView.image = [dic objectForKey:@"image"];
    cell.textLabel.text = [dic objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
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

// 点击用户头像
- (void)tapHeadView
{
    UserViewController *user = [[UserViewController alloc]init];
    [self.navigationController pushViewController:user animated:YES];
}

// 当得到照片或者视频后，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    // 判断获取类型 : 图片  public.image
    if ([type isEqualToString:@"public.image"]) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        self.HUD.label.text = @"loading";
        _imageViewHead.image = [info objectForKey:UIImagePickerControllerEditedImage];
        [self uploadImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        
    } else {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择图片" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消选中");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 上传图片
- (void)uploadImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    NSLog(@"image:%@",image);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 允许 https , 并且不验证主机域名
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = @"http://222.186.45.63/personal/upload";
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"1"
                                fileName:@"image.jpg"
                                mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress:%@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传图片成功");
        [self.HUD hideAnimated:YES];
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);

        NSString *status = [dic objectForKey:@"status"];
        NSDictionary *dicData = [dic objectForKey:@"data"];
        
            if ([status isEqualToString:@"success"]) {
                if (dicData) {
                    NSString *imgUrl = [dicData objectForKey:@"pic"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (imgUrl) {
                            NSString *pic_url = [NSString stringWithFormat:@"%@%@",URL_host,imgUrl];
                            [self.imageViewHead setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pic_url]]]];
                            
                            Account *acc = [[Account findAll] objectAtIndex:0];
                            acc.photo = pic_url;
                            [acc update];

                            [self modifyUserDetail:acc];
                        }
                        
                    });
                }
            }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传图片失败");
        [self.HUD hideAnimated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"上传图片失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];

}

- (NSMutableArray *)arraySource
{
    if (!_arraySource) {

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

// 通知方法
- (void)notify:(NSNotification *)sender
{
    if ([[sender.userInfo objectForKey:@"type"]isEqualToString:@"modify"]) {
        [self modifyUserDetail:sender.object];
    }
}

// 变更资料
- (void)modifyUserDetail:(Account *)acc{
    
    NSString *str = [acc.photo stringByReplacingOccurrencesOfString:URL_host withString:@""];
    
    NSDictionary *dic = @{@"customerId":acc.customerId,
                          @"username":acc.username,
                          @"getAccount":acc.aliAccount,
                          @"provinceId":acc.provinceId,
                          @"cityId":acc.cityId,
                          @"districtId":acc.districtId,
                          @"areaInfo":acc.areaInfo,
                          @"pic":str};
    
    
    [RestfulAPIRequestTool routeName:Personal_modify_URL requestModel:dic useKeys:nil success:^(id json) {
        
        NSLog(@"请求结果为%@", json);
        NSLog(@"%@",[json objectForKey:@"msg"]);
        NSString *status = [json objectForKey:@"status"];
        if ([status isEqualToString:@"success"]) {
            // TO DO 显示修改成功
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改资料成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
        
    } failure:^(id errorJson) {
        NSLog(@"登录结果为%@", errorJson);
        
    }];
}

// 对控件 自适应屏幕
- (CGRect)adaptFrame:(CGRect)control
{
    return CGRectMake(control.origin.x * DLScreenWidth / 375, control.origin.y * DLScreenHeight / 667, control.size.width * DLScreenWidth / 375, control.size.height * DLScreenHeight / 667);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
