//
//  ViewController.m
//  NGWeeklyCalendarCollectionView
//
//  Created by Neeraj Goyal on 13/04/16.
//  Copyright © 2016 NeerajGoyal. All rights reserved.
//

#import "NGWeeklyCalendarCollectionViewController.h"
#import "NGWeeklyCalendarCollectionView.h"
#import "NSDate+NGWeeklyCalendar.h"
#import "NGWeeklyCalendarCollectionViewCell.h"

@interface NGWeeklyCalendarCollectionViewController ()
@property (nonatomic, strong) NSDate *lastSelectedDate;
@property (nonatomic) BOOL onceBool;
@property (nonatomic) NSInteger yearMinus;
@property (nonatomic) NSInteger yearPlus;
@end

@implementation NGWeeklyCalendarCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _onceBool = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    static BOOL once = true;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (once) {
            [self.collectionView layoutIfNeeded];
            [self scrollToDate:[NSDate date]];
        }
        once = false;
    });
//    if (_onceBool) {
//        [self.collectionView layoutIfNeeded];
//        [self scrollToDate:[NSDate date]];
//        _onceBool = false;
//    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (![collectionView isKindOfClass:[NGWeeklyCalendarCollectionView class]]) return 0;
    return [self.collectionView.calendarStartDate daysBetweenDate:self.collectionView.calendarEndDate];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (![collectionView isKindOfClass:[NGWeeklyCalendarCollectionView class]]) return nil;
    
    NGWeeklyCalendarCollectionView *weeklyCollectionView = (NGWeeklyCalendarCollectionView *)collectionView;
    NGWeeklyCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNGWeeklyCalendarCollectionViewCellReId forIndexPath:indexPath];
    [cell configureForDate:[weeklyCollectionView dateForIndexPath:indexPath]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (![collectionView isKindOfClass:[NGWeeklyCalendarCollectionView class]]) return 0;
    return 1;
}

#pragma mark -  UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (![collectionView isKindOfClass:[NGWeeklyCalendarCollectionView class]]) return ;
    
    NGWeeklyCalendarCollectionView *weeklyCollectionView = (NGWeeklyCalendarCollectionView *)collectionView;
    self.lastSelectedDate = [weeklyCollectionView.calendarStartDate dateByAddingDays:indexPath.item];
    [self setHeaderFooterLabelsForDate:_lastSelectedDate];
    if(_delegate && [_delegate respondsToSelector:@selector(collectionView:didSelectDate:)])
        [_delegate collectionView:weeklyCollectionView didSelectDate:_lastSelectedDate];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:didEndDisplayingCell:forDate:)]) {
        [_delegate collectionView:self.collectionView didEndDisplayingCell:(NGWeeklyCalendarCollectionViewCell *)cell forDate:[self.collectionView dateForIndexPath:indexPath]];
    }
}

#pragma mark - IBActions
-(IBAction)btnYearMinusTapped:(UIButton *)btnYearMinus
{
    NSDate *date = _lastSelectedDate;
    date = [date dateByAddingYears:-1];
    [self scrollToDate:date];
}

-(IBAction)btnMonthMinusTapped:(UIButton *)btnMonthMinus
{
    NSDate *date = _lastSelectedDate;
    date = [date dateByAddingMonths:-1];
    [self scrollToDate:date];
}

-(IBAction)btnYearPlusTapped:(UIButton *)btnYearPlus
{
    NSDate *date = _lastSelectedDate;
    date = [date dateByAddingYears:1];
    [self scrollToDate:date];
}

-(IBAction)btnMonthPlusTapped:(UIButton *)btnMonthPlus
{
    NSDate *date = _lastSelectedDate;
    date = [date dateByAddingMonths:1];
    [self scrollToDate:date];
}


#pragma mark - Date Scrolling And Selection
-(BOOL)isDateValid:(NSDate *)date
{
    if ([date compare:_collectionView.calendarStartDate] == NSOrderedAscending || [date compare:_collectionView.calendarEndDate] == NSOrderedDescending) {
        return NO;
    } else return YES;
}

-(UICollectionViewScrollPosition)getScrollPositionForDate:(NSDate *)date
{
    NSInteger daysFromCalendarStartDate = [_collectionView.calendarStartDate daysBetweenDate:date];
    NSInteger daysFromCalendarEndDate = [_collectionView.calendarEndDate daysBetweenDate:date];
    
    if (daysFromCalendarEndDate <=-3 && daysFromCalendarStartDate >=3) {
        return UICollectionViewScrollPositionCenteredHorizontally;
    } else return UICollectionViewScrollPositionNone;
}

-(void)scrollToDate:(NSDate *)date
{
    if ([self isDateValid:date]) {
        
        [self.collectionView scrollToDate:date atScrollPosition:[self getScrollPositionForDate:date] animated:YES];
        [self.collectionView selectDate:date animated:YES scrollPosition:UICollectionViewScrollPositionNone
         ];
        self.lastSelectedDate = date;
        [self setHeaderFooterLabelsForDate:_lastSelectedDate];
    }
}

#pragma mark - RequestEventsForVisibleCells
-(void)requestEventsForVisibleCells
{
    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        NSDate *date = [self.collectionView dateForIndexPath:indexPath];
        if (_dataSource && [_dataSource respondsToSelector:@selector(collectionView:addEventForDate:)]) {
            [_dataSource collectionView:self.collectionView addEventForDate:date];
        }
    }
}

#pragma mark - Set Header and Footer Label
-(void)setHeaderFooterLabelsForDate:(NSDate *)date
{
    _lblFooter.text = [NSString stringWithFormat:@"%i %@ %i", (int)[_lastSelectedDate getDateUnit],[[_lastSelectedDate getFullStringForMonth] capitalizedString], (int)[_lastSelectedDate getYearUnit]];
    _lblHeader.text = [NSString stringWithFormat:@"%@ %i", [[_lastSelectedDate getFullStringForMonth] capitalizedString], (int)[_lastSelectedDate getYearUnit]];
}
@end
