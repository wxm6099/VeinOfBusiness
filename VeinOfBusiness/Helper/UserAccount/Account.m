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
             @"customerId":@"id",
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
    if ([key isEqualToString:@"customerId"] && [key isEqualToString:@"customerId"]) {
        self.customerId = value;
    }
    
    
    
    
    if ([key isEqualToString:@"pic"]) {
        self.photo = [NSString stringWithFormat:@"%@%@",URL_host,value];
    }
    if ([key isEqualToString:@"getAccount"]) {
        self.aliAccount = value;
    }
    if ([key isEqualToString:@"verifyStatus"]) {
        switch (((NSString *)value).integerValue) {
            case 0:
                self.verify = @"未提交";
                break;
            case 1:
                self.verify = @"待审核";
                break;
            case 2:
                self.verify = @"通过";
                break;
            case 3:
                self.verify = @"失败";
                break;
                
            default:
                break;
        }
    }
}


- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
    // 把字典内的<null>转化为空字符串
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:keyedValues];
    NSArray *valueArray = [dic allKeys];
    for (NSString *key in valueArray) {
        if ([[dic objectForKey:key]isEqual:[NSNull null]]) {
            [dic setObject:@"" forKey:key];
        }
    }
    [super setValuesForKeysWithDictionary:dic];
}

// 归档的实现

@end
