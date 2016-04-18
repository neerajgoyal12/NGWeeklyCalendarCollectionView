//
//  NGWeeklyCollectionView.h
//  NGWeeklyCalendarCollectionView
//
//  Created by Neeraj Goyal on 13/04/16.
//  Copyright © 2016 NeerajGoyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NGWeeklyCalendarCollectionView;
@class NGWeeklyCalendarCollectionViewCell;

extern NSString *const kNGMinusYearsToShow;
extern NSString *const kNGPlusYearsToShow;
extern NSString *const kWeekDayStart;

@interface NGWeeklyCalendarCollectionView : UICollectionView <UIScrollViewDelegate>
@property (nonatomic, strong) NSDate *calendarStartDate;
@property (nonatomic, strong) NSDate *calendarEndDate;

-(NSDate *)dateForIndexPath:(NSIndexPath *)indexPath;
-(NSIndexPath *)indexPathForDate:(NSDate *)date;
-(void)selectDate:(NSDate *)date animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition;
-(void)scrollToDate:(NSDate *)date atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
-(NGWeeklyCalendarCollectionViewCell *)cellForDate:(NSDate *)date;

@end
