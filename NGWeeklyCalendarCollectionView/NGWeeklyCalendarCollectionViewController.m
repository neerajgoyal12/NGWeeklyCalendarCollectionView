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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _onceBool = true;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (_onceBool) {
        [self.collectionView layoutIfNeeded];
        [self scrollToDate:[NSDate date]];
        _onceBool = false;
    }
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
    NSDate *date = [weeklyCollectionView dateForIndexPath:indexPath];
    [cell configureForDate:date];
    if (_dataSource && [_dataSource respondsToSelector:@selector(collectionView:cellHasEvent:forDate:)]) {
         [cell cellHasEvent:[_dataSource collectionView:weeklyCollectionView cellHasEvent:cell forDate:date]];
    }
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

-(IBAction)btnTodaysDateTapped:(UIButton *)btnTodaysDate
{
    NSDate *date = [NSDate date];
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
        NSDate* scrollDate = [date weekStartDate:[kWeekDayStart integerValue]];
        [self.collectionView scrollToDate:scrollDate atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        [self.collectionView selectDate:date animated:NO scrollPosition:UICollectionViewScrollPositionNone
         ];
        self.lastSelectedDate = date;
        [self setHeaderFooterLabelsForDate:_lastSelectedDate];
    }
}

#pragma mark - Set Header and Footer Label
-(void)setHeaderFooterLabelsForDate:(NSDate *)date
{
    _lblFooter.text = [NSString stringWithFormat:@"%i %@ %i", (int)[_lastSelectedDate getDateUnit],[[_lastSelectedDate getFullStringForMonth] capitalizedString], (int)[_lastSelectedDate getYearUnit]];
    _lblHeader.text = [NSString stringWithFormat:@"%@ %i", [[_lastSelectedDate getFullStringForMonth] capitalizedString], (int)[_lastSelectedDate getYearUnit]];
}

#pragma mark - UICollectionView Scroll Events
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"Did Scroll");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0)
{
    if(velocity.x < 0)
    { //back by one week in date
        self.lastSelectedDate =  [self.lastSelectedDate dateByAddingDays:-7];
    } else { // forward by a week
        self.lastSelectedDate =  [self.lastSelectedDate dateByAddingDays:7];
    }
    [self.collectionView selectDate:_lastSelectedDate animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self setHeaderFooterLabelsForDate:_lastSelectedDate];
    if(_delegate && [_delegate respondsToSelector:@selector(collectionView:didSelectDate:)])
        [_delegate collectionView:self.collectionView didSelectDate:_lastSelectedDate];
}
@end
