//
//  GetMessageFromWXResp+responseWithTextOrMediaMessage.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GetMessageFromWXResp+responseWithTextOrMediaMessage.h"

@implementation GetMessageFromWXResp (responseWithTextOrMediaMessage)

+ (GetMessageFromWXResp *)responseWithText:(NSString *)text
                            OrMediaMessage:(WXMediaMessage *)message
                                     bText:(BOOL)bText {
    GetMessageFromWXResp *resp = [[GetMessageFromWXResp alloc] init];
    resp.bText = bText;
    if (bText)
        resp.text = text;
    else
        resp.message = message;
    return resp;
}


@end
