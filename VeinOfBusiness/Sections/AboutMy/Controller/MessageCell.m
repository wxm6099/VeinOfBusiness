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
//        self.labelTitle.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.labelTitle];
        
//        self.labelNew = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 50, 30)];
//        self.labelNew.backgroundColor = [UIColor redColor];
//        self.labelNew.text = @"NEW";
//        self.labelNew.textAlignment = NSTextAlignmentCenter;
//        self.labelNew.textColor = [UIColor whiteColor];
//        self.labelNew.layer.cornerRadius = 15;
//        self.labelNew.layer.masksToBounds = YES;
//        [self.contentView addSubview:self.labelNew];
        
        
        self.labelTime = [[UILabel alloc]initWithFrame:CGRectMake(DLScreenWidth - 250, 5, 230, 30)];
//        self.labelTime.backgroundColor = [UIColor greenColor];
        self.labelTime.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.labelTime];
        
        self.labelContent = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, DLScreenWidth - 10, 100)];
//        self.labelContent.backgroundColor = [UIColor yellowColor];
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
