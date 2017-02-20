//
//  CustomCollectionTableViewCell.m
//  RGButterfly
//
//  Created by Stuart Pineo on 7/13/15.
//  Copyright (c) 2015 Stuart Pineo. All rights reserved.
//
#import "CustomCollectionTableViewCell.h"


@interface CustomCollectionTableViewCell()

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation CustomCollectionTableViewCell

// Custom defaults
//
#define DEF_CUST_CELL_BGCOLOR    [UIColor blackColor]

CGFloat const DEF_CUST_X_OFFSET          = 0.0;
CGFloat const DEF_CUST_Y_OFFSET          = 0.0;
CGFloat const DEF_CUST_NIL_WIDTH         = 0.0;
CGFloat const DEF_CUST_NIL_HEIGHT        = 0.0;
CGFloat const DEF_CUST_TABLE_CELL_HEIGHT = 44.0;
CGFloat const DEF_CUST_FIELD_PADDING     = 5.0;
CGFloat const DEF_CUST_COLLECTVIEW_INSET = 20.0;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    // Ensure that values are set
    //
    _backgroundColor = DEF_CUST_CELL_BGCOLOR;
    _tableCellHeight = DEF_CUST_TABLE_CELL_HEIGHT;
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    [_layout setSectionInset: UIEdgeInsetsMake(DEF_CUST_COLLECTVIEW_INSET*2.0, DEF_CUST_FIELD_PADDING, DEF_CUST_COLLECTVIEW_INSET, DEF_CUST_FIELD_PADDING)];
    [_layout setMinimumInteritemSpacing:DEF_CUST_FIELD_PADDING];
    [_layout setItemSize: CGSizeMake(_tableCellHeight, _tableCellHeight)];
    [_layout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    [_layout setHeaderReferenceSize:CGSizeMake(DEF_CUST_FIELD_PADDING, DEF_CUST_FIELD_PADDING)];

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
    [self.layout setSectionInset:UIEdgeInsetsMake(DEF_CUST_X_OFFSET, DEF_CUST_Y_OFFSET, DEF_CUST_NIL_WIDTH, DEF_CUST_NIL_HEIGHT)];
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
    
    CGFloat yCrop  = (self.contentView.bounds.size.height - _tableCellHeight) / 2.0;
    CGFloat offset = DEF_CUST_FIELD_PADDING * 2.0;

    [self.imageView setFrame:CGRectMake(offset, self.contentView.bounds.origin.y + offset, _tableCellHeight, self.contentView.bounds.size.height)];
    self.imageView.bounds = CGRectInset(self.imageView.frame, DEF_CUST_NIL_WIDTH, yCrop);
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
