//
//  IntegralModel.h
//  VeinOfBusiness
//
//  Created by 太阳 on 2016/11/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "JKDBModel.h"

@interface IntegralModel : JKDBModel

/**
 * 当前余额
 */
@property (nonatomic, copy)NSString *curMoney;// = 0;
/**
 * 累计积分
 */
@property (nonatomic, copy)NSString *curPoint;// = 43245329;
/**
 * 邀请码
 */
@property (nonatomic, copy)NSString *inviteCode;// = 1;
/**
 * 累计钱数
 */
@property (nonatomic, copy)NSString *sumMoney;// = 0;
/**
 * 当前积分
 */
@property (nonatomic, copy)NSString *sumPoint;// = 43245329;
/**
 * 赏金任务数
 */
@property (nonatomic, copy)NSString *sumReward;// = 0;
/**
 * 今日积分
 */
@property (nonatomic, copy)NSString *todayPoint;// = "<null>";

@end
