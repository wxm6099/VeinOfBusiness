//
//  DBcommonUtilscommonUtils.h
//  FoodLibrary
//
//  Created by 段博 on 16/1/6.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^checknetblock)(NSInteger index);
@interface DBcommonUtils : NSObject


@property (nonatomic,copy)checknetblock checkNetBlock;


//输入date 输出星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate withDateStr:(NSString*)dateStr;

//比较时间前后
+(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;

//计算日期提前或延后
+(NSString*)dateWithDays:(NSInteger)days;


+(NSString*)dateWithDays:(NSInteger)days frome:(NSString*)date;

//计算给定月份天数

+ (NSInteger)totaldaysInThisMonth:(NSDate *)date with:(NSString*)datestr;


//计算给定月份第一天周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date with:(NSString*)datestr;

@end
