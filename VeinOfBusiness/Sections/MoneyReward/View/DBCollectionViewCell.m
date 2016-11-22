//
//  CollectionViewCell.m
//  GJCAR.COM
//
//  Created by 段博 on 16/5/26.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBCollectionViewCell.h"

//获取屏幕宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

//获取屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@implementation DBCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        [self createUI];
    }
    
    return self;
}


-(void)createUI
{
//    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0 , 0 , ScreenWidth/7, 0.5)];
//    line.backgroundColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1];
//    [self addSubview:line];
    
//    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/7, 0, 0.5, ScreenWidth/7)];
//    line2.backgroundColor =[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1] ;
//    [self addSubview:line2];
//    
//    
//    UIView * line3 = [[UIView alloc]initWithFrame:CGRectMake(0 , ScreenWidth/7 , ScreenWidth/7, 0.5)];
//    line3.backgroundColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1];
//    [self addSubview:line3];

    
    
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/7, ScreenWidth/7)];
    self.dateLabel.textAlignment= 1 ;
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.dateLabel];
    
    
}

@end
