//
//  WithdrawRecordTableCell.h
//  VeinOfBusiness
//
//  Created by Apple on 16/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawRecordTableCell : UITableViewCell


/**
 * 积分字典 用来显示积分记录
 */
@property (nonatomic, strong)NSDictionary *integralDic;

/**
 * 提现字典 用来显示提现记录
 */
@property (nonatomic, strong)NSDictionary *withdrawDic;

@end
