//
//  NSDate+NGWeeklyCalendar.h
//  NGWeeklyCalendarCollectionView
//
//  Created by Neeraj Goyal on 13/04/16.
//  Copyright © 2016 NeerajGoyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NGWeeklyCalendar)
-(NSString *)getShortStringForWeekday;
-(NSString *)getShortStringForMonth;
-(NSString *)getFullStringForMonth;
-(NSUInteger)getDateUnit;
-(NSUInteger)getYearUnit;
-(NSDate *)dateByAddingDays:(NSInteger)days;
-(NSDate *)dateByAddingMonths:(NSInteger)months;
-(NSDate *)dateByAddingYears:(NSInteger)years;
-(NSInteger)daysBetweenDate:(NSDate*)date;
-(NSDate *)weekStartDate: (NSInteger)weekStartIndex;
-(NSNumber *)weekDay;
@end
