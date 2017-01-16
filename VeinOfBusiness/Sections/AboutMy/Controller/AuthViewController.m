//
//  AuthViewController.m
//  VeinOfBusiness
//
//  Created by sense on 17/1/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "AuthViewController.h"
#import <AFNetworking.h>
#import "RestfulAPIRequestTool.h"
#import "Account.h"

@interface AuthViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,retain) UIImageView *imageViewFront;
@property (nonatomic,retain) UIImageView *imageViewBack;
@property (nonatomic,retain) NSString *frontOrBack;
@property (nonatomic,retain) NSString *frontImageUrl;
@property (nonatomic,retain) NSString *backImageUrl;

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"身份验证";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(commit)];
    
    
    UITapGestureRecognizer *frontTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageFront:)];
    UILabel *labelFront = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 30)];
    labelFront.text = @"请上传身份证正面:";
    [self.view addSubview:labelFront];
    self.imageViewFront = [[UIImageView alloc]initWithFrame:CGRectMake(50, 150, 200, 200)];
    self.imageViewFront.tag = 1;
    self.imageViewFront.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.imageViewFront.userInteractionEnabled = YES;
    [self.imageViewFront addGestureRecognizer:frontTap];
    [self.view addSubview:self.imageViewFront];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageBack:)];
    UILabel *labelBack = [[UILabel alloc]initWithFrame:CGRectMake(50, 380, 200, 30)];
    labelBack.text = @"请上传身份证反面:";
    [self.view addSubview:labelBack];
    self.imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(50, 430, 200, 200)];
    self.imageViewBack.tag = 2;
    self.imageViewBack.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.imageViewBack.userInteractionEnabled = YES;
    [self.imageViewBack addGestureRecognizer:backTap];
    [self.view addSubview:self.imageViewBack];
    
    
}

- (void)tapImageFront:(id)sender
{
    self.frontOrBack = @"front";
    [self tapImage];
}

- (void)tapImageBack:(id)sender
{
    self.frontOrBack = @"back";
    [self tapImage];
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


// 当得到照片或者视频后，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //    NSLog(@"选中图片");
    //    NSLog(@"%@",info);
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    // 判断获取类型 : 图片  public.image
    if ([type isEqualToString:@"public.image"]) {
//        _imageViewHead.image = [info objectForKey:UIImagePickerControllerEditedImage];
//        [self uploadImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if ([self.frontOrBack isEqualToString:@"front"]) {
            self.imageViewFront.image = image;
            [self uploadImage:image];
        }else{
            self.imageViewBack.image = image;
            [self uploadImage:image];
        }
        
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
    NSString *url = @"http://222.186.45.63/personal/vupload";
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"1"
                                fileName:@"image.jpg"
                                mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress:%@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传图片成功");
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        NSString *status = [dic objectForKey:@"status"];
        NSDictionary *dicData = [dic objectForKey:@"data"];
        
        if ([status isEqualToString:@"success"]) {
            if (dicData) {
                NSString *imgUrl = [dicData objectForKey:@"pic"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (imgUrl) {
//                        NSString *pic_url = [NSString stringWithFormat:@"%@%@",URL_host,imgUrl];
                        if ([self.frontOrBack isEqualToString:@"front"]) {
                            self.frontImageUrl = imgUrl;
                        }else{
                            self.backImageUrl = imgUrl;
                        }
                    }
                    
                });
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传图片失败");
    }];
    
}

- (void)commit
{
    Account *acc = [[Account findAll] objectAtIndex:0];
    NSDictionary *dic = @{@"customerId" : acc.customerId,
                          @"front":self.frontImageUrl,
                          @"back":self.backImageUrl,
                          @"handle":@""};
    [RestfulAPIRequestTool routeName:Personal_verify requestModel:dic useKeys:nil success:^(id json) {
        
        NSLog(@"请求结果为%@", json);
        NSString *status = [json objectForKey:@"status"];
        if ([status isEqualToString:@"success"]) {
            // TO DO 显示修改成功
            acc.verify = @"待审核";
            [acc update];
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else{
            // TO DO 显示修改失败
            
        }
        
        
    } failure:^(id errorJson) {
        NSLog(@"登录结果为%@", errorJson);
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
