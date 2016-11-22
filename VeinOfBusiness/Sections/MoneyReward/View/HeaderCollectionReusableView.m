//
//  HeaderCollectionReusableView.m
//  UICollectionView
//
//  Created by smith on 15/12/10.
//  Copyright © 2015年 smith. All rights reserved.
//

#import "HeaderCollectionReusableView.h"




//获取屏幕宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

//获取屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



@implementation HeaderCollectionReusableView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIView *  priceView = [[UIView alloc]initWithFrame:frame];
        
        
        NSArray * weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
        
        for (int i = 0; i < 7; i++)
            
        {
            
            UILabel * weekView= [[UILabel alloc]initWithFrame:CGRectMake(i * ScreenWidth/7, 0, ScreenWidth/7, ScreenWidth/7)];
            weekView.textAlignment = 1;
            weekView.text = weekArray[i];
            weekView.backgroundColor =[UIColor colorWithRed:0.94 green:0.97 blue:1 alpha:1];
            weekView.font = [UIFont systemFontOfSize:12];
            [priceView addSubview:weekView];
        }
        
        [self addSubview:priceView];

    }

   
    return self;
}

@end
