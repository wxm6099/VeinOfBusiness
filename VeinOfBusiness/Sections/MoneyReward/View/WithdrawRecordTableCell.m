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
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end


@implementation WithdrawRecordTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabelWidth.constant = (DLScreenWidth - 2) / 3.0;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setIntegralDic:(NSDictionary *)integralDic
{
    self.timeLabel.text = [self getBrackString:integralDic[@"logTime"]];
    //1转发，2签到，3邀请，4积分兑换
    NSInteger a = [integralDic[@"type"] integerValue];
    self.stateLabel.text = a == 1 ? @"转发" : a == 2 ? @"签到" : a == 3 ? @"邀请" : @"积分兑换";
    if (a == 4) {
        self.numLabel.text = [NSString stringWithFormat:@"-%@", integralDic[@"changeData" ]];
    } else
        self.numLabel.text = integralDic[@"changeData"];
    
}

- (NSString *)getBrackString:(NSString *)str{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}

@end
