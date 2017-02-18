//
//  CustomCollectionTableViewCell.m
//  RGButterfly
//
//  Created by Stuart Pineo on 7/13/15.
//  Copyright (c) 2015 Stuart Pineo. All rights reserved.
//
#import "CustomCollectionTableViewCell.h"
#import "GlobalSettings.h"

@interface CustomCollectionTableViewCell()

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation CustomCollectionTableViewCell

// Set defaults
//
#define DEF_CUST_CELL_BGCOLOR    [UIColor blackColor]


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    // Ensure that values are set
    //
    if (! _backgroundColor)
        _backgroundColor = DEF_CUST_CELL_BGCOLOR;
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    [_layout setSectionInset: UIEdgeInsetsMake(DEF_COLLECTVIEW_INSET*2.0, DEF_FIELD_PADDING, DEF_COLLECTVIEW_INSET, DEF_FIELD_PADDING)];
    [_layout setMinimumInteritemSpacing:DEF_FIELD_PADDING];
    [_layout setItemSize: CGSizeMake(DEF_TABLE_CELL_HEIGHT, DEF_TABLE_CELL_HEIGHT)];
    [_layout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    [_layout setHeaderReferenceSize:CGSizeMake(DEF_FIELD_PADDING, DEF_FIELD_PADDING)];

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    [self.collectionView setBackgroundColor:_backgroundColor];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];

    [self.contentView addSubview:self.collectionView];
    
    return self;
}

- (void)addLabel:(UILabel *)label {
    [self.contentView addSubview:label];
}

- (void)setNoLabelLayout {
    [self.layout setSectionInset:UIEdgeInsetsMake(DEF_X_OFFSET, DEF_Y_OFFSET, DEF_NIL_WIDTH, DEF_NIL_HEIGHT)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (! _xOffset) {
        _xOffset = self.contentView.bounds.origin.x;
    }

    [self.collectionView setFrame:CGRectMake(_xOffset, self.contentView.bounds.origin.y, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    
    CGFloat yCrop  = (self.contentView.bounds.size.height - DEF_TABLE_CELL_HEIGHT) / 2.0;
    CGFloat offset = DEF_FIELD_PADDING * 2.0;

    [self.imageView setFrame:CGRectMake(offset, self.contentView.bounds.origin.y + offset, DEF_TABLE_CELL_HEIGHT, self.contentView.bounds.size.height)];
    self.imageView.bounds = CGRectInset(self.imageView.frame, DEF_NIL_WIDTH, yCrop);
}

// TableView controller will handle the Collection methods
//
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index {
    [self.collectionView setDataSource:dataSourceDelegate];
    [self.collectionView setDelegate:dataSourceDelegate];
    [self.collectionView setTag:index];
    
    [self.collectionView reloadData];
}


@end
