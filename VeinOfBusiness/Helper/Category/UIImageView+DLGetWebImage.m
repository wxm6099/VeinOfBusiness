//
//  UIImageView+DLGetWebImage.m
//  app
//
//  Created by 申家 on 15/7/30.
//  Copyright (c) 2015年 Donler. All rights reserved.
//

#import "UIImageView+DLGetWebImage.h"
#import "UIScreen+Extension.h"
#import "ServerAddress.h"

#define Float2Int(float) ((int)(float))

@implementation UIImageView (DLGetWebImage)

- (void)dlGetSpecialSizedWebImageWithString:(NSString *)str placeholderImage:(UIImage *)image
{
    NSString* finalStr = [self getFinalUrlStringWithString:str];
    [self yy_setImageWithURL:[NSURL URLWithString:finalStr] placeholder:image options:YYWebImageOptionProgressiveBlur completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
    }];
}



// 对图片链接进行拼取
- (NSString *)getFinalUrlStringWithString:(NSString *)str
{
    
    NSString *route = [NSString stringWithFormat:@"%@", [ServerAddress imgServerAddress]];  //字符串拼接
    NSString *urlStr = [route stringByAppendingString:str];
    NSString *newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return newUrlStr;
}

@end
