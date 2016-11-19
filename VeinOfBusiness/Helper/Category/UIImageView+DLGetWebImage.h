//
//  UIImageView+DLGetWebImage.h
//  app
//
//  Created by 申家 on 15/7/30.
//  Copyright (c) 2015年 Donler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage.h>
@interface UIImageView (DLGetWebImage)

/**
 * 请求指定大小的图
 */
- (void)dlGetSpecialSizedWebImageWithString:(NSString *)str placeholderImage:(UIImage *)image;


@end
