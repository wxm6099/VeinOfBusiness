//
//  ShareUtil.m
//  mielseno
//
//  Created by sense on 16/11/07.
//  Copyright © 2016年 sense. All rights reserved.
//

#import "ShareUtil.h"

#import "WXApiRequestHandler.h"


@implementation ShareUtil

// 分享到聊天列表 (参数: url网址, title标题, 描述, 图片)
- (void)shareWeChatSessionWithLink:(NSDictionary *)dataDic;
{
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
    
    BOOL share = [WXApiRequestHandler sendLinkURL:url
                                          TagName:nil
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
- (void)shareWeChatTimeLineWithLink:(NSDictionary *)dataDic;
{
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

    BOOL share = [WXApiRequestHandler sendLinkURL:url
                                          TagName:nil
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
