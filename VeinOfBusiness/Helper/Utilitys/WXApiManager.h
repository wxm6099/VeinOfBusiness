//
//  WXApiManager.h
//  VeinOfBusiness
//
//  Created by sense on 16/11/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol WXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;


@end

@interface WXApiManager : NSObject<WXApiDelegate>

@property (nonatomic,assign) id<WXApiManagerDelegate>delegate;

+ (instancetype)sharedManager;

@end
