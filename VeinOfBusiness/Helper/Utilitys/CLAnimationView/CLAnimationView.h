//
//  CLAnimationView.h
//  弹出视图
//
//  Created by 李 红宝 on 16/1/16.
//  Copyright © 2016年 陈林. All rights reserved.
//

#import <UIKit/UIKit.h>

//选择位置
typedef void (^CLBlock)(NSInteger index,id shareType);

//选择按钮
typedef void(^CLBtnBlock)(UIButton *btn);


@interface CLAnimationView : UIView


@property (nonatomic,copy) CLBlock block;

@property (nonatomic,copy) CLBtnBlock btnBlock;
/**
 *  初始化动画视图
 *
 *  @param titlearray title数组
 ＊ @param picarray    图标数组
 */


- (id)initWithTitleArray:(NSMutableArray *)titlearray picarray:(NSMutableArray *)picarray;


/*
 *  视图展示
 */
- (void)show;

/*
 * 选中的index
 */

- (void)selectedWithIndex:(CLBlock)block;

/*
 *  按钮block
 */

- (void)CLBtnBlock:(CLBtnBlock)block;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com