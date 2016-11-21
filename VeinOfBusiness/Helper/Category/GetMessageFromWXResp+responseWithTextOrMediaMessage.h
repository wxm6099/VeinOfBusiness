//
//  GetMessageFromWXResp+responseWithTextOrMediaMessage.h
//  VeinOfBusiness
//
//  Created by sense on 16/11/21.
//  Copyright © 2016年 Apple. All rights reserved.
//


#import "WXApiObject.h"
@interface GetMessageFromWXResp (responseWithTextOrMediaMessage)

+ (GetMessageFromWXResp *)responseWithText:(NSString *)text
                            OrMediaMessage:(WXMediaMessage *)message
                                     bText:(BOOL)bText;

@end
