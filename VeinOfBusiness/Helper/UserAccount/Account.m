//
//  Account.m
//  friendChains
//
//  Created by tom on 15/12/2.
//  Copyright © 2015年 donler. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"userToken":@"token",
             @"userId":@"id",
             @"easemobId":@"id",
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"avatar_url"]) {
        self.photo = value;
    }
    if ([key isEqualToString:@"user_phone"]) {
        self.phone = value;
    }
    if ([key isEqualToString:@"user_id"] && [key isEqualToString:@"userid"]) {
        self.userId = value;
    }
    
}

// 归档的实现

@end
