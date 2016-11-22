//
//  CollectionViewCell.h
//  GJCAR.COM
//
//  Created by 段博 on 16/5/26.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBCollectionViewCell : UICollectionViewCell


@property (nonatomic,strong)UIImageView * saleImage;


@property (nonatomic,strong)UILabel * dateLabel;

@property (nonatomic,strong)UILabel * priceLable ;



-(instancetype)initWithFrame:(CGRect)frame;
@end
