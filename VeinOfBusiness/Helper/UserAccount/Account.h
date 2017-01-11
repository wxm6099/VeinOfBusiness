//
//  Account.h
//  friendChains
//
//  Created by tom on 15/12/2.
//  Copyright © 2015年 donler. All rights reserved.
//

#import "JKDBModel.h"
#import <Foundation/Foundation.h>
@interface Account : JKDBModel

@property (nonatomic, copy)NSString* customerId;

@property (nonatomic, copy)NSString* phone;

@property (nonatomic, copy)NSString *name;


@property (nonatomic, copy)NSString* password;


/**
 * 头像URL
 */
@property (nonatomic, copy)NSString *photo;

// sense add
@property (nonatomic,copy) NSString *username;  // 昵称 用这个字段
@property (nonatomic,copy) NSString *provinceId;
@property (nonatomic,copy) NSString *cityId;
@property (nonatomic,copy) NSString *districtId;
@property (nonatomic,copy) NSString *aliAccount;
@property (nonatomic,copy) NSString *areaInfo;

@property (nonatomic,copy) NSString *verify;

// sense over


@end
