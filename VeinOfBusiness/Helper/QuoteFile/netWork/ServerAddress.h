//
//  ServerAddress.h
//  friendChains
//
//  Created by tom on 15/11/12.
//  Copyright © 2015年 donler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerAddress : NSObject
//获取服务器地址
+ (NSString*)serverAddress;
//获取图片服务器地址
+ (NSString*)imgServerAddress;
@end
