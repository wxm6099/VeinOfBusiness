//
//  MessageCell.m
//  VeinOfBusiness
//
//  Created by sense on 16/11/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 50, 30)];
        self.labelTitle.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.labelTitle];
        
        self.labelTime = [[UILabel alloc]initWithFrame:CGRectMake(DLScreenWidth - 100, 5, 50, 30)];
        self.labelTime.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.labelTime];
        
        self.labelContent = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, DLScreenWidth - 10, 100)];
        self.labelContent.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.labelContent];
        
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
