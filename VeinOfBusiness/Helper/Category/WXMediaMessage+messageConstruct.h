//
//  WXMediaMessage+messageConstruct.h
//  mielseno
//
//  Created by sense on 16/1/13.
//  Copyright © 2016年 sense. All rights reserved.
//

#import "WXApiObject.h"

@interface WXMediaMessage (messageConstruct)

+ (WXMediaMessage *)messageWithTitle:(NSString *)title
                         Description:(NSString *)description
                              Object:(id)mediaObject
                          MessageExt:(NSString *)messageExt
                       MessageAction:(NSString *)action
                          ThumbImage:(UIImage *)thumbImage
                            MediaTag:(NSString *)tagName;

@end
