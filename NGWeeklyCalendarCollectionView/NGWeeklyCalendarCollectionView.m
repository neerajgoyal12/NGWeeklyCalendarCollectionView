//
//  NGWeeklyCollectionView.m
//  NGWeeklyCalendarCollectionView
//
//  Created by Neeraj Goyal on 13/04/16.
//  Copyright © 2016 NeerajGoyal. All rights reserved.
//

#import "NGWeeklyCalendarCollectionView.h"
#import "NSDate+NGWeeklyCalendar.h"
#import "NGWeeklyCalendarCollectionViewFlowLayout.h"
#import "NGWeeklyCalendarCollectionViewCell.h"


NSString *const kNGMinusYearsToShow = @"-3";
NSString *const kNGPlusYearsToShow = @"3";

@implementation NGWeeklyCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self defaults];
    }
    return self;
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaults];
    }
    return self;
}

-(void)defaults
{
    self.calendarStartDate = [[NSDate date] dateByAddingYears:[kNGMinusYearsToShow integerValue]];
    self.calendarEndDate = [[NSDate date] dateByAddingYears:[kNGPlusYearsToShow integerValue]];
    NGWeeklyCalendarCollectionViewFlowLayout *layout = [[NGWeeklyCalendarCollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    layout.itemSize = CGSizeMake(50, 80);
    self.collectionViewLayout = layout;
}

-(NSDate *)dateForIndexPath:(NSIndexPath *)indexPath
{
    NSInteger days = indexPath.item;
    return [_calendarStartDate dateByAddingDays:days];
}

-(NSIndexPath *)indexPathForDate:(NSDate *)date
{
    NSInteger days = [self.calendarStartDate daysBetweenDate:date];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:days inSection:0];

    return indexPath;
}

- (void)selectDate:(NSDate *)date animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition
{
    
    [super selectItemAtIndexPath:[self indexPathForDate:date] animated:animated scrollPosition:scrollPosition];
}

- (void)scrollToDate:(NSDate *)date atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    [super scrollToItemAtIndexPath:[self indexPathForDate:date] atScrollPosition:scrollPosition animated:animated];
}

-(NGWeeklyCalendarCollectionViewCell *)cellForDate:(NSDate *)date
{
    return (NGWeeklyCalendarCollectionViewCell *)[super cellForItemAtIndexPath:[self indexPathForDate:date]];
}

@end
