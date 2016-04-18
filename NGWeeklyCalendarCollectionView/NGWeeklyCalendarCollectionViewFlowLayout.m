//
//  NGWeeklyCollectionViewFlowLayout.m
//  NGWeeklyCalendarCollectionView
//
//  Created by Neeraj Goyal on 13/04/16.
//  Copyright © 2016 NeerajGoyal. All rights reserved.
//

#import "NGWeeklyCalendarCollectionViewFlowLayout.h"

@interface NGWeeklyCalendarCollectionViewFlowLayout ()
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) NSUInteger nbColumns;
@end

@implementation NGWeeklyCalendarCollectionViewFlowLayout
static const NSInteger kDefaultColumsRequired = 7;
static const double kMinimumInteritemSpacing = 1.0;
static const double kminimumLineSpacing = 1.0;

- (instancetype)init{
    self = [super init];
    if(self){
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumInteritemSpacing = kMinimumInteritemSpacing;
        self.minimumLineSpacing = kminimumLineSpacing;
        self.nbColumns = kDefaultColumsRequired;
    }
    return self;
}

-(void)prepareLayout
{
    //don't forget to call super here
    _width = self.collectionView.bounds.size.width;
    _height = self.collectionView.bounds.size.height;
    CGFloat width = ((_width - ((_nbColumns-1) * self.minimumInteritemSpacing))/_nbColumns);
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.itemSize = CGSizeMake(width, _height);
    [super prepareLayout];
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(_width * [self.collectionView numberOfItemsInSection:0]/7, _height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [super layoutAttributesForElementsInRect:rect];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetHeight(newBounds) != CGRectGetHeight(oldBounds)) {
        return YES;
    }
    return NO;
}
@end
