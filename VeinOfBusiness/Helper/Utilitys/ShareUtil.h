//
//  ShareUtil.h
//  mielseno
//
//  Created by sense on 16/11/07.
//  Copyright © 2016年 sense. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SHARE_INFO)(NSDictionary *dicc);
@interface ShareUtil : NSObject


@property (nonatomic,copy) SHARE_INFO share_info;
/** 分享到微信朋友 */
- (void)shareWeChatSessionWithLink:(NSDictionary *)dataDic;

/** 分享到微信朋友圈 */
- (void)shareWeChatTimeLineWithLink:(NSDictionary *)dataDic;


- (void)returnShareDic:(SHARE_INFO)block;

@end
