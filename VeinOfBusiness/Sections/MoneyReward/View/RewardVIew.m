//
//  RewardVIew.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RewardVIew.h"

@implementation RewardVIew




- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)image title:(NSString *)title detailTitle:(NSString *)detail{
    
    self = [super initWithFrame:frame];
    
    if (!self) {
        
    }
    
    CGFloat top = (frame.size.height - 25) / 2.0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, top, 25, 25)];
    imageView.image = [UIImage imageNamed:image];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, top - 10, 100, 21)];
    [titleLabel setTextColor:RGBACOLOR(57, 57, 57, 1)];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [titleLabel setText:title];
    [self addSubview:titleLabel];
    
    
    UILabel *detailTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, top + 10, 100, 21)];
    [detailTitleLabel setTextColor:RGBACOLOR(57, 57, 57, 1)];
    [detailTitleLabel setFont:[UIFont systemFontOfSize:12]];
    [detailTitleLabel setText:detail];
    [self addSubview:detailTitleLabel];
    
    
    UIImageView *imageviewRight = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 19, top, 7, 25)];
    
    imageviewRight.backgroundColor = [UIColor lightGrayColor];
    imageviewRight.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageviewRight];
    
    
    return self;
}





@end
