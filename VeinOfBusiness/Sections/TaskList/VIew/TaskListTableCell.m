//
//  TaskListTableCell.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TaskListTableCell.h"
#import "AdvertiseModel.h"
#import "UIImageView+DLGetWebImage.h"
@interface TaskListTableCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *sendDate;
@property (weak, nonatomic) IBOutlet UILabel *lockNum;
@property (weak, nonatomic) IBOutlet UIImageView *imageTitle;

@end


@implementation TaskListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellModel:(AdvertiseModel *)cellModel
{
    _cellModel = cellModel;
    self.titleLabel.text = cellModel.title;
    [self.imageTitle dlGetSpecialSizedWebImageWithString:cellModel.pic placeholderImage:nil];
    self.lockNum.text = [NSString stringWithFormat:@"浏览:%@", cellModel.openTimes];
    
}

@end
