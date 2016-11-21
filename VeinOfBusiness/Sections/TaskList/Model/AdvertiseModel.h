//
//  AdvertiseModel.h
//  VeinOfBusiness
//
//  Created by 太阳 on 2016/11/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "JKDBModel.h"

@interface AdvertiseModel : JKDBModel

/*
 forwardTimes = 0;
 isComplete = 0;
 link = "https://www.zhihu.com/question/19568396/answer/16245159";
 openTimes = 0;
 perEarn = 1211;
 pic = "statics/uploadedpic/306bc3c83bd4b310cc66975f9fc8f301.jpg";
 title = "\U4f60\U5389\U5bb3\U5728\U54ea";
 */

@property (nonatomic, copy)NSString *adId;
/**
 * 转发次数
 */
@property (nonatomic, copy)NSString *forwardTimes;
/**
 * 是否完成
 */
@property (nonatomic, copy)NSString *isComplete;
/**
 * 链接
 */
@property (nonatomic, copy)NSString *link;
/**
 * 打开次数
 */
@property (nonatomic, copy)NSString *openTimes;
/**
 * 转发积分
 */
@property (nonatomic, copy)NSString *perEarn;
/**
 * 图片
 */
@property (nonatomic, copy)NSString *pic;
/**
 * 标题
 */
@property (nonatomic, copy)NSString *title;
/**
 * 添加时间
 */
@property (nonatomic, copy)NSString *addTime;
@end
