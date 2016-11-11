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

@property (nonatomic, copy)NSString* userId;
@property (nonatomic, copy)NSString* phone;

@property (nonatomic, copy)NSString *name;


@property (nonatomic, copy)NSString* password;


/**
 * 头像URL
 */
@property (nonatomic, copy)NSString *photo;

@end
