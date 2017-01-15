//
//  CLAnimationView.m
//  弹出视图
//
//  Created by 李 红宝 on 16/1/16.
//  Copyright © 2016年 陈林. All rights reserved.
//

#import "CLAnimationView.h"
#import "CLView.h"



#define  HH  130
#define SCREENWIDTH      [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT    [UIScreen mainScreen].bounds.size.height


@interface CLAnimationView ()<UIScrollViewDelegate>
{
    UIPageControl *pageShow ;
}
@property (nonatomic,strong) UIView *largeView;
@property (nonatomic) CGFloat count;
@property (nonatomic,strong) UIButton *chooseBtn;


@end



@implementation CLAnimationView


- (id)initWithTitleArray:(NSMutableArray *)titlearray picarray:(NSMutableArray *)picarray
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.largeView = [[UIView alloc]init];
        [_largeView  setFrame:CGRectMake(0, SCREENHEIGHT ,SCREENWIDTH,HH)];
        [_largeView setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
        [self addSubview:_largeView];
        
        __weak typeof (self) selfBlock = self;
        
        _chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HH - 40, SCREENWIDTH, 40)];
        [_chooseBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_chooseBtn setBackgroundColor:[UIColor whiteColor]];
        [_chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.largeView addSubview:_chooseBtn];
        
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 90)];
        scroll.contentSize = CGSizeMake((titlearray.count +3)/4*SCREENWIDTH, 0);
        scroll.bounces = NO;
        scroll.pagingEnabled = YES;
        scroll.delegate = self;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        [_largeView addSubview:scroll];
        
        
        pageShow = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        pageShow.currentPageIndicatorTintColor = [UIColor grayColor];
        pageShow.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageShow.numberOfPages = (titlearray.count +3)/4;
        pageShow.center = CGPointMake(SCREENWIDTH/2, 80);
        [_largeView addSubview:pageShow];
        
        
        
        for (int i = 0; i < titlearray.count; i ++) {
            CLView *rr = [[CLView alloc]initWithFrame:CGRectMake(i *(SCREENWIDTH / 4), 40, SCREENWIDTH/4, 90)];
            rr.tag = 10 + i;
            rr.sheetBtn.tag = i + 1;
            [rr.sheetBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",picarray[i]]] forState:UIControlStateNormal];
            [rr.sheetLab setText:[NSString stringWithFormat:@"%@",titlearray[i]]];
            
            [rr selectedIndex:^(NSInteger index, UILabel *sheetLab,id shareType) {
                [self dismiss];
                self.block(index,shareType);
                
            }];
            
            [scroll addSubview:rr];
        }
        
        
        
        
        
        
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:selfBlock action:@selector(dismiss)];
        [selfBlock addGestureRecognizer:dismissTap];
    }
    return self;
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageShow.currentPage = scrollView.contentOffset.x/SCREENWIDTH;
    
}


- (void)selectedWithIndex:(CLBlock)block
{
    self.block = block;
}





- (void)CLBtnBlock:(CLBtnBlock)block
{
    self.btnBlock = block;
}


- (void)chooseBtnClick:(UIButton *)sender
{
    self.btnBlock(sender);
    [self dismiss];
}

-(void)show
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        _largeView.transform = CGAffineTransformMakeTranslation(0, -HH);
        for (int i = 0; i < 6; i ++) {
        
            CGPoint CLCenterPoint = CGPointMake(SCREENWIDTH/4* i  + (SCREENWIDTH/8), 45);
            
            
            CLView *rr =  (CLView *)[self viewWithTag:10 + i];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    rr.center = CLCenterPoint;
                } completion:nil];
                
            });
        }
        
    } completion:^(BOOL finished) {
        
        NSLog(@"所有动画之行完毕");
    }];
    
}

- (void)tap:(UITapGestureRecognizer *)tapG {
    [self dismiss];
}


- (void)dismiss {
    [UIView animateWithDuration:0 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        _largeView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
