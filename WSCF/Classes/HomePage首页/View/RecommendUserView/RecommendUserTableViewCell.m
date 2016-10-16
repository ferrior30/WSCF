//
//  RecommendUserTableViewCell.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "RecommendUserTableViewCell.h"
#import "RecommendUserCollectionView.h"

@interface RecommendUserTableViewCell ()
@property (weak, nonatomic) RecommendUserCollectionView *recommendUserCollectionView;
@end

@implementation RecommendUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        // 添加recommendView
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.itemSize = CGSizeMake(50, 70);
        flowlayout.minimumInteritemSpacing = 10;
        flowlayout.minimumLineSpacing = 0;
        
        RecommendUserCollectionView *recommendUserView = [[RecommendUserCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowlayout];
        [self.contentView addSubview:recommendUserView];
        self.recommendUserCollectionView = recommendUserView;
    }
    
    return self;
}

- (void)setRecommendUserButtons:(NSArray *)recommendUserButtons {
    _recommendUserButtons = recommendUserButtons;
    
    self.recommendUserCollectionView.recommendUsers = self.recommendUserButtons;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.recommendUserCollectionView.frame = self.bounds;
}

@end
