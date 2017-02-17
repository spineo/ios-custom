//
//  CustomCollectionTableViewCell.h
//  RGButterfly
//
//  Created by Stuart Pineo on 7/13/15.
//  Copyright (c) 2015 Stuart Pineo. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";

@interface CustomCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) CGFloat xOffset;
@property (nonatomic, strong) UIColor *backgroundColor;

- (void)addLabel:(UILabel *)label;
- (void)setNoLabelLayout;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index;

@end
