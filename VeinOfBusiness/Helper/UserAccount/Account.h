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
@property (nonatomic,copy) NSString *gender;    //性别
@property (nonatomic,copy) NSString *birthday;  // 出身年月
@property (nonatomic,copy) NSString *address;   //所在地区
@property (nonatomic,copy) NSString *IDcode;    // 身份证
@property (nonatomic,copy) NSString *major;    // 行业    **
@property (nonatomic,copy) NSString *username;  // 昵称
@property (nonatomic,copy) NSString *money;     //月收入   **
@property (nonatomic,copy) NSString *education; //学历    **
@property (nonatomic,copy) NSString *interest; //兴趣    **

// sense over


@end
