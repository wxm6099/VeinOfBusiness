//
//  commonUtils.m
//  FoodLibrary
//
//  Created by 段博 on 16/1/6.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBcommonUtils.h"

#import <Foundation/NSObject.h>

@implementation DBcommonUtils



//输入日期date 输出星期

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate withDateStr:(NSString*)dateStr{
    
    if (dateStr != nil)
    {
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        
        inputDate = [formatter dateFromString:dateStr];

    }
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}



//比较日期大小
+(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    
    NSComparisonResult result = [dateA compare:dateB];
//    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}


//距离当前时间 N天的日期
+(NSString*)dateWithDays:(NSInteger)days
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];

    [adcomps setDay:days];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:newdate];

    return dateString ;
}


//距离给定日期 N天后的日期
+(NSString*)dateWithDays:(NSInteger)days frome:(NSString*)dateTime
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    
    [adcomps setDay:days];
    

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSDate *dateA =  [calendar dateByAddingComponents:adcomps toDate:[formatter dateFromString:dateTime] options:0];

    
    NSString *dateString = [formatter stringFromDate:dateA];
    
    return dateString ;
}



//计算给定月份天数

+ (NSInteger)totaldaysInThisMonth:(NSDate *)date with:(NSString*)datestr
{
    if (datestr != nil)
    {
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        date = [formatter dateFromString:datestr];
    }
    
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}


//计算给定月份第一天是星期几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date with:(NSString*)datestr {
    
    
    if (datestr != nil)
    {
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        date = [formatter dateFromString:datestr];
    }

    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}


@end
