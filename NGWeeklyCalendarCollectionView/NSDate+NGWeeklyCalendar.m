//
//  NSDate+NGWeeklyCalendar.m
//  NGWeeklyCalendarCollectionView
//
//  Created by Neeraj Goyal on 13/04/16.
//  Copyright © 2016 NeerajGoyal. All rights reserved.
//

#import "NSDate+NGWeeklyCalendar.h"

@implementation NSDate (NGWeeklyCalendar)

-(NSString *)getShortStringForWeekday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE";
    return [formatter stringFromDate:self];
}

-(NSString *)getShortStringForMonth
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMM";
    return [formatter stringFromDate:self];
}

-(NSString *)getFullStringForMonth
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM";
    return [formatter stringFromDate:self];
}

-(NSUInteger)getDateUnit
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd";
    NSInteger dateOfMonth = [[formatter stringFromDate:self] integerValue];
    return dateOfMonth;
}

-(NSUInteger)getYearUnit
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    NSInteger dateOfMonth = [[formatter stringFromDate:self] integerValue];
    return dateOfMonth;
}

-(NSDate *)dateByAddingDays:(NSInteger)days
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    dateComponents.day = dateComponents.day + days;
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    return newDate;
}

-(NSDate *)dateByAddingMonths:(NSInteger)months
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    dateComponents.month = dateComponents.month+ months;
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    return newDate;
}

-(NSDate *)dateByAddingYears:(NSInteger)years
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    dateComponents.year = dateComponents.year + years;
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    return newDate;
}

-(NSInteger)daysBetweenDate:(NSDate*)date
{
    if (!date) {
        return 7;
    }
    
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay
                startDate:&fromDate
                 interval:NULL forDate:self];
    
    [calendar rangeOfUnit:NSCalendarUnitDay
                startDate:&toDate
                 interval:NULL forDate:date];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];
    
    return [difference day];
}

-(NSDate *)dateByMakingHour:(NSUInteger)hour minute:(NSUInteger)minute seconds:(NSUInteger)seconds
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    dateComponents.day = dateComponents.day;
    dateComponents.hour   = hour;
    dateComponents.minute = minute;
    dateComponents.second = seconds;
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    return newDate;
}

@end
