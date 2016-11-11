//
//  UINavigationBar+DLNavigationBar.h
//  friendChains
//
//  Created by 申家 on 15/11/17.
//  Copyright © 2015年 donler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
IB_DESIGNABLE

@interface UINavigationBar (DLNavigationBar)

@property (strong, nonatomic) IBInspectable UIColor *color;

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

- (void)setNavigationBarWithColor:(UIColor *)color;
- (void)setNavigationBarWithColors:(NSArray *)colours;

@end
