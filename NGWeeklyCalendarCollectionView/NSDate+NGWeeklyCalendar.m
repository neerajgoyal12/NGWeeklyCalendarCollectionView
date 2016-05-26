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

-(NSDate *)dateByAddingOneDay
{
    NSTimeInterval time = [self timeIntervalSince1970];
    time += 24*60*60;
    return [NSDate dateWithTimeIntervalSince1970:time];
}
-(NSInteger)daysBetweenDate:(NSDate*)date
{    
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
                                                options:NSCalendarWrapComponents];
    
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

-(NSDate *)weekStartDate: (NSInteger)weekStartIndex
{
    int weekDay = [[self weekDay] intValue];
    
    NSInteger gap = (weekStartIndex <=  weekDay) ?  weekDay  : ( 7 + weekDay );
    NSInteger day = weekStartIndex - gap;
    
    return [self dateByAddingDays:day];
}

-(NSNumber *)weekDay
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:self];
    return [NSNumber numberWithInteger:([comps weekday] - 1)];
}

-(NSDate *)dateInLocalTimeZone
{
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    NSDate *dateInLocalTimezone = [self dateByAddingTimeInterval:timeZoneSeconds];
    return dateInLocalTimezone;
}

+(NSDate *)getTommrowsDateInLocalTimeZone
{
    NSDate *date = [NSDate date];
    date = [date dateByAddingDays:1];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    NSDate *dateInLocalTimezone = [date dateByAddingTimeInterval:timeZoneSeconds];
    return dateInLocalTimezone;
}

+(NSDate *)getTodaysDateInLocalTimeZone
{
    NSDate *date = [NSDate date];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    NSDate *dateInLocalTimezone = [date dateByAddingTimeInterval:timeZoneSeconds];
    return dateInLocalTimezone;
}

-(NSDate *)dateAt12AMForLocalTimeZone
{
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    double seconds = fmod(timeZoneSeconds, 60);
    double minutes = fmod(timeZoneSeconds - seconds, 60*60);
    double hour = (timeZoneSeconds - minutes - seconds)/(60.0*60.0);
    
    NSDate *newDate = [self dateByMakingHour:hour minute:minutes/60.0 seconds:seconds];
    return newDate;
}

@end
