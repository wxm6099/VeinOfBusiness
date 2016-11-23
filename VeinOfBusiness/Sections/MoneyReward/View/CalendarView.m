//
//  CalendarView.m
//  Calendar
//
//  Created by Apple on 16/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "CalendarView.h"

#import "DBcommonUtils.h"

#import "DBCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"



//获取屏幕宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

//获取屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@interface CalendarView ()<UICollectionViewDataSource,UICollectionViewDelegate>

//日历控件
@property (nonatomic,strong)UICollectionView * collcetionView;


//日历控件天数
@property (nonatomic,strong)NSMutableArray * daysArray;

//时间
@property (nonatomic,strong)NSMutableString * date ;

@property (nonatomic, strong)NSArray *checkInArray;


@end

@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //计算月份天数
        NSInteger heightNum = [self setMonthDays];
        
        //创建日历列表
        [self creatCollectionView:heightNum];
        
        //初始化当前时间
        [self setDate];
        
    }
    return self;
}

#pragma mark 初始化当前时间
-(void)setDate
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString * date = [formatter stringFromDate:[NSDate date]];
    
    _date = [NSMutableString stringWithString:date];
    
    
}

#pragma mark 初始化日历
-(void)creatCollectionView:(NSInteger)num
{
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init] ;
    //设置collectionView的滑动方向
    //UICollectionViewScrollDirectionVertical 垂直滑动   默认滑动方向
    //UICollectionViewScrollDirectionHorizontal 水平滑动
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //在垂直方向  设置的是cell上下之间的最小间距 在水平方向  设置的是cell左右之间的最小间距
    flowLayout.minimumLineSpacing = 0 ;
    //在垂直方向  设置的是cell左右之间的最小间距 在水平方向  设置的是cell上下之间的最小间距
    flowLayout.minimumInteritemSpacing = 0 ;
    //设置collectionViewCell的大小
    
    flowLayout.itemSize = CGSizeMake(ScreenWidth/7, ScreenWidth/7);
    
    //设置头部视图的大小
    flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, ScreenWidth/7) ;
    
    //设置尾部视图的大小
    
    //第一个参数  位置大小
    //第二个参数  流布局对象 （UICollectionViewFlowLayout）
    
    
    _collcetionView  =[[ UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/7 * (num + 1)) collectionViewLayout:flowLayout];
    _collcetionView.backgroundColor = [UIColor whiteColor];
    
    
    [self addSubview:_collcetionView];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, DLScreenWidth, _collcetionView.frame.size.height);
    _collcetionView.delegate = self ;
    _collcetionView.dataSource =self ;
    
    //    在这个地方进行cell复用注册
    [_collcetionView registerClass:[DBCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"] ;
    
    
    
//    _collcetionView.backgroundColor = [UIColor clearColor];
    
    //在这个地方进行头部视图复用注册
    //    UICollectionElementKindSectionHeader 头部表示kind
    //    UICollectionElementKindSectionFooter 尾部表示kind
    
    [_collcetionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"] ;
    
    [_collcetionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
}

- (void)reloadCollectionViewWithArray:(NSArray *)array{
    
    self.checkInArray = [NSArray arrayWithArray:array];
    
//    
//    for (NSString *str in array) {
//        for (NSString *tempStr in self.daysArray) {
//            if ([tempStr isEqualToString:str]) {
//                
//                NSInteger index = [self.daysArray indexOfObject:tempStr];
//                
//                DBCollectionViewCell *cell = (DBCollectionViewCell *)[self.collcetionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//                
//                cell.dateLabel.backgroundColor = [UIColor redColor];
//                cell.dateLabel.layer.cornerRadius = DLScreenWidth / 7.0 / 2;
//                cell.dateLabel.layer.masksToBounds = YES;
//                
//                break;
//            }
//        }
//    }
    
    [self.collcetionView reloadData];
}


#pragma mark 计算选定月份天数
-(NSInteger)setMonthDays
{
    
    _daysArray = [NSMutableArray array];
    
    NSLog(@"%@",_date);
    
    
    NSInteger days = [DBcommonUtils totaldaysInThisMonth:[NSDate date] with:_date];
    NSInteger week  = [DBcommonUtils firstWeekdayInThisMonth:[NSDate date] with:_date];
    
    
    
    NSInteger weeks;
    if ((days + week) % 7 > 0)
    {
        weeks = (days + week)/7 + 1 ;
    }
    else
    {
        weeks = (days + week)/7 ;
    }
    
    for (int i  = 0; i < (days + week); i ++)
    {
        if ( i - week < 0)
        {
            [_daysArray addObject:@" "];
        }
        else
        {
            [_daysArray addObject:[NSString stringWithFormat:@"%ld",i+1-week]];
        }
        
        
        NSLog(@"%@",_daysArray[i]);
        
    }
    
    [_collcetionView reloadData];
    
    
    NSLog(@"这个月有%ld天 , 第一天是%ld",days,week);
    NSInteger i = 7 - week;
    NSInteger temp = days - i;
    NSInteger chu = temp / 7;
    NSInteger yu = temp % 7;
    if (yu != 0) {
        chu = chu + 1;
    }
    NSLog(@"这个月有%ld格", chu + 1);
    
    return chu + 1;
    
}
#pragma mark -- UICollectionViewDelegate 代理方法

//设置每个分组中collectionViewCell的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",_daysArray.count);
    return _daysArray.count ;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DBCollectionViewCell * cell = [_collcetionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath] ;
    
    if (cell == nil)
    {
        cell = [[DBCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/7, ScreenWidth/7)];
        
    }
    
    if (_daysArray.count > 0 )
    {
        
        if ([_daysArray[indexPath.row]integerValue]!= 0 )
        {
            NSMutableString * str = [NSMutableString stringWithString:_date];
            
            [str replaceCharactersInRange:NSMakeRange(8, 2) withString:[NSString stringWithFormat:@"%.2ld",[_daysArray[indexPath.row]integerValue]]];
            
            NSString * date = [NSString stringWithString:str];
            
            NSLog(@"%@  %@",date,[DBcommonUtils weekdayStringFromDate:nil withDateStr:date]);
            
            
            if ([[DBcommonUtils weekdayStringFromDate:nil withDateStr:date]isEqualToString:@"周六"] || [[DBcommonUtils weekdayStringFromDate:nil withDateStr:date]isEqualToString:@"周日"])
                
            {
                cell.dateLabel.textColor = [UIColor grayColor];
                
            }
            else
            {
                cell.dateLabel.textColor = [UIColor blackColor];
            }
        }
        
        
        cell.dateLabel.text = _daysArray[indexPath.row];
        
        for (NSString *tempStr in self.checkInArray) {
            if ([_daysArray[indexPath.row] isEqualToString:tempStr]) {
//                UIView *circle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DLScreenWidth / 9.0, DLScreenWidth / 9.0)];
//                circle.center = cell.center;
//                circle.backgroundColor = [UIColor redColor];
//                [cell addSubview:circle];
//                [cell sendSubviewToBack:circle];
                cell.dateLabel.layer.cornerRadius = DLScreenWidth / 14.0;
                cell.dateLabel.layer.masksToBounds = YES;
                cell.dateLabel.backgroundColor = [UIColor redColor];
            }
        }
        
        
    }
    
    return cell ;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //    判断是否是头部视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        //从复用池中去头部视图
        HeaderCollectionReusableView * headerView = [_collcetionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath] ;
        //        headerView.backgroundColor = [UIColor yellowColor] ;
        if (headerView == nil)
        {
            //footerView.dateLabel.text =[_date substringWithRange:NSMakeRange(0, 10)];
            headerView =[[HeaderCollectionReusableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/7)];
        }
        
        return headerView ;
        
        
    }
    
    
    else {
        
    }
        return nil ;
}



@end
