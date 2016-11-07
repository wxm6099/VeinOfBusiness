//
//  ShareUtil.m
//  mielseno
//
//  Created by sense on 16/11/07.
//  Copyright © 2016年 sense. All rights reserved.
//

#import "ShareUtil.h"

#import "WXApi.h"
#import "requsetHandler.h"

//#import "WeiboSDK.h"

//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import "LoginViewController.h"
//#import "MainViewController.h"

@implementation ShareUtil

// 分享到聊天列表 (参数: url网址, title标题, 描述, 图片)
- (void)shareWeChatList:(NSDictionary *)dataDic;
{
    //    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    //    req.text = @"sense 在微信";
    //    req.bText = YES;
    //    req.scene = WXSceneSession;
    //    [WXApi sendReq:req];
    
    // 给会话列表 发文字
    //    [requsetHandler sendText:@"sense 在微信" InScene:WXSceneSession];
    
    //给会话列表 发照片
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"];
    //    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    //    UIImage *image = [UIImage imageNamed:@"3"];
    //    [requsetHandler sendImageData:imageData TagName:@"这是什么" MessageExt:@"这是什么2" Action:@"这是什么" ThumbImage:image InScene:WXSceneSession];
    
    //给会话列表 发链接
    NSString *url = [dataDic objectForKey:@"url"];
//    NSString *tagName = [dataDic objectForKey:@"tagName"];
    NSString *title = [dataDic objectForKey:@"title"];
    NSString *descr = [dataDic objectForKey:@"description"];
    NSString *imgUrl = [dataDic objectForKey:@"imgUrl"];
    
//    if ([CommonUtil getByteOfString:title] > 512) {
//        title = [CommonUtil getShareString:title];
//    }
//    if ([CommonUtil getByteOfString:descr] > 1024) {
//        descr = [CommonUtil getShareString:descr];
//    }
    
    BOOL share = [requsetHandler sendLinkURL:[NSString stringWithFormat:@"%@",url]
                        TagName:@""
                          Title:title
                    Description:descr
                     ThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]]
                        InScene:WXSceneSession];
    
    NSLog(@"share = %u",share);
    if (!share) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"调起微信失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        if (self.share_info != nil) {
            self.share_info(@{@"result":@"0"});
        }
    }
}

// 分享到朋友圈
- (void)shareFriend:(NSDictionary *)dataDic;
{
    //向微信注册
//    [WXApi registerApp:WXAppID withDescription:@"蜜豆"];
    // 给会话列表 发文字
    //    [requsetHandler sendText:@"sense 在微信" InScene:WXSceneSession];
    
    //给会话列表 发照片
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"];
    //    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    //    UIImage *image = [UIImage imageNamed:@"3"];
    //    [requsetHandler sendImageData:imageData TagName:@"这是什么" MessageExt:@"这是什么2" Action:@"这是什么" ThumbImage:image InScene:WXSceneSession];
    
    //给会话列表 发链接
    NSString *url = [dataDic objectForKey:@"url"];
//    NSString *tagName = [dataDic objectForKey:@"tagName"];
    NSString *title = [dataDic objectForKey:@"title"];
    NSString *descr = [dataDic objectForKey:@"description"];
    NSString *imgUrl = [dataDic objectForKey:@"imgUrl"];
    
//    if ([CommonUtil getByteOfString:title] > 512) {
//        title = [CommonUtil getShareString:title];
//    }
//    if ([CommonUtil getByteOfString:descr] > 1024) {
//        descr = [CommonUtil getShareString:descr];
//    }

    BOOL share = [requsetHandler sendLinkURL:[NSString stringWithFormat:@"%@",url]
                            TagName:@""
                              Title:title
                        Description:descr
                         ThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]]
                            InScene:WXSceneTimeline];
    NSLog(@"share = %u",share);
    if (!share) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"调起微信失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        if (self.share_info != nil) {
            self.share_info(@{@"result":@"0"});
        }
    }
}

- (void)returnShareDic:(SHARE_INFO)block
{
    self.share_info = block;
}

@end
