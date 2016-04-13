//
//  ViewController.h
//  NGWeeklyCalendarCollectionView
//
//  Created by Neeraj Goyal on 13/04/16.
//  Copyright © 2016 NeerajGoyal. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NGWeeklyCalendarCollectionView;
@class NGWeeklyCalendarCollectionViewCell;

@protocol NGWeeklyCalendarControllerDataSource <NSObject>

@optional
-(void)collectionView:(NGWeeklyCalendarCollectionView *)collectionView addEventForDate:(NSDate *)date;
@end

@protocol NGWeeklyCalendarControllerDelegate <NSObject>

@optional
-(void)collectionView:(NGWeeklyCalendarCollectionView *)collectionView didSelectDate:(NSDate *)date;
-(void)collectionView:(NGWeeklyCalendarCollectionView *)collectionView didEndDisplayingCell:(NGWeeklyCalendarCollectionViewCell *)cell forDate:(NSDate *)date;
@end

@interface NGWeeklyCalendarCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>


@property (nonatomic, weak) id<NGWeeklyCalendarControllerDelegate> delegate;
@property (nonatomic, weak) id<NGWeeklyCalendarControllerDataSource> dataSource;

@property (nonatomic, weak) IBOutlet NGWeeklyCollectionView *collectionView;

@property (nonatomic, weak) IBOutlet UIView *vwHeader;
@property (nonatomic, weak) IBOutlet UIView *vwFooter;

@property (nonatomic, weak) IBOutlet UILabel *lblHeader;
@property (nonatomic, weak) IBOutlet UILabel *lblFooter;

@property (nonatomic, weak) IBOutlet UIButton *btnYearMinus;
@property (nonatomic, weak) IBOutlet UIButton *btnMonthMinus;

@property (nonatomic, weak) IBOutlet UIButton *btnYearPlus;
@property (nonatomic, weak) IBOutlet UIButton *btnMonthPlus;

-(IBAction)btnYearMinusTapped:(UIButton *)btnYearMinus;
-(IBAction)btnMonthMinusTapped:(UIButton *)btnMonthMinus;
-(IBAction)btnYearPlusTapped:(UIButton *)btnYearPlus;
-(IBAction)btnMonthPlusTapped:(UIButton *)btnMonthPlus;

@end

