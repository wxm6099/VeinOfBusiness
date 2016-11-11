//
//  WithdrawRecordTableCell.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "WithdrawRecordTableCell.h"

@interface WithdrawRecordTableCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelWidth;

@end


@implementation WithdrawRecordTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabelWidth.constant = (DLScreenWidth - 2) / 3.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
