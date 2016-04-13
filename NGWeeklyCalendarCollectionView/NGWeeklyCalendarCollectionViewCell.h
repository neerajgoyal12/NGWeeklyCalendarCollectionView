//
//  NGWeeklyCollectionViewCell.h
//  NGWeeklyCalendarCollectionView
//
//  Created by Neeraj Goyal on 13/04/16.
//  Copyright © 2016 NeerajGoyal. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kNGWeeklyCalendarCollectionViewReId;

@interface NGWeeklyCalendarCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel *lblWeekday;
@property (nonatomic, weak) IBOutlet UILabel *lblDateUnit;
@property (nonatomic, weak) IBOutlet UIImageView *imgVwDateSelected;
@property (nonatomic, weak) IBOutlet UIImageView *imgVwEvent;
@property (nonatomic, strong, readonly) NSDate *date;
-(void)configureForDate:(NSDate *)date;
@end
