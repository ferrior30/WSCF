//
//  RecommendUserCollectionView.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendUserList.h"

@interface RecommendUserCollectionView : UICollectionView
@property (strong, nonatomic) NSArray<RecommendUserList *> *recommendUsers;
@end
