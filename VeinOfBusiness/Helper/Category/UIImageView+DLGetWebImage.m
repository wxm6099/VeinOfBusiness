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


//拼接图片地址
- (NSString *)getFinalUrlStringWithString:(NSString *)str AndSize:(CGSize)size
{
    if ([str hasPrefix:@"//"]) {
        str = [str substringFromIndex:1];
    }
    if (![str hasPrefix:@"/"]) {
        str = [NSString stringWithFormat:@"/%@", str];
    }
    NSString *route = [NSString stringWithFormat:@"%@", [ServerAddress imgServerAddress]];  //字符串拼接
    
    NSString *urlStr = [route stringByAppendingString:str];
    
    NSString *newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    newUrlStr = [newUrlStr stringByAppendingString:[NSString stringWithFormat:@"/%d/%d",Float2Int(size.width * [UIScreen screenScale]), Float2Int(size.height * [UIScreen screenScale])]];
    
    return newUrlStr;
}

// 对图片链接进行拼取
- (NSString *)getFinalUrlStringWithString:(NSString *)str
{
    if ([str hasPrefix:@"//"]) {
        str = [str substringFromIndex:1];
    }
    if (![str hasPrefix:@"/"]) {
        str = [NSString stringWithFormat:@"/%@", str];
    }
    NSString *route = [NSString stringWithFormat:@"%@", [ServerAddress imgServerAddress]];  //字符串拼接
    NSString *urlStr = [route stringByAppendingString:str];
    NSString *newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return newUrlStr;
}

@end
