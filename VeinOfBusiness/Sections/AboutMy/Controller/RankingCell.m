//
//  RankingCell.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RankingCell.h"

@implementation RankingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.imageViewHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 50, 50)];
//        [self.contentView addSubview:self.imageViewHead];
        
        self.labelName = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 50, 20)];
        [self.contentView addSubview:self.labelName];
        
        self.labelRank = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 50, 20)];
        [self.contentView addSubview:self.labelRank];
        
        self.labelMoney = [[UILabel alloc]initWithFrame:CGRectMake(DLScreenWidth - 100, 15, 50, 30)];
        [self.contentView addSubview:self.labelMoney];

    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
