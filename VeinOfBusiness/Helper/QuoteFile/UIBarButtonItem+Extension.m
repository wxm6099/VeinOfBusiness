//
// UIBarButtonItem+Extension.m
//  DLDemo
//
//  Created by jason on 15/7/13.
//  Copyright (c) 2015年 jason. All rights reserved.
//


#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *  
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
//    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = CGSizeMake(44, 44);
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(12, -20, 12, 0);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
