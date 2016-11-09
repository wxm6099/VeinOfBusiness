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

- (void)shareWeChatList:(NSDictionary *)dataDic;
- (void)shareFriend:(NSDictionary *)dataDic;


- (void)returnShareDic:(SHARE_INFO)block;

@end
