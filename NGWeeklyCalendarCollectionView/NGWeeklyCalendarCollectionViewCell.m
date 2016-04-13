//
//  NGWeeklyCollectionViewCell.m
//  NGWeeklyCalendarCollectionView
//
//  Created by Neeraj Goyal on 13/04/16.
//  Copyright © 2016 NeerajGoyal. All rights reserved.
//

#import "NGWeeklyCalendarCollectionViewCell.h"
#import "NSDate+NGWeeklyCalendar.h"

NSString *const kNGWeeklyCalendarCollectionViewCellReId = @"NGWeeklyCalendarCollectionViewCellReId";

@interface NGWeeklyCalendarCollectionViewCell ()
@property (nonatomic, strong, readwrite) NSDate *date;
@end

@implementation NGWeeklyCalendarCollectionViewCell

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        _imgVwDateSelected.image = [UIImage imageNamed:@"big_red_dot"];
    } else {
        _imgVwDateSelected.image = nil;
    }
}

-(void)configureForDate:(NSDate *)date
{
    self.date = date;
    _lblWeekday.text = [[_date getShortStringForWeekday] uppercaseString];
    _lblDateUnit.text = [NSString stringWithFormat:@"%i", (int)[_date getDateUnit]];
    _imgVwEvent.image = [UIImage imageNamed:@"big_green_dot"];
}

@end
