//
//  TaskListTableCell.m
//  VeinOfBusiness
//
//  Created by Apple on 16/11/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RewardListTableCell.h"

@interface RewardListTableCell()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;

@end


@implementation RewardListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.title.text = @"央企中央集团战略,注册";
    
    self.detail.text = @"发布时间:2016/12/23\n剩余次数:45457次\n任务单价:\n0.58元一次";
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
