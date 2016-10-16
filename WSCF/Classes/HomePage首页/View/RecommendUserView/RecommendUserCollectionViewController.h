//
//  RecommendUserCollectionViewController.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendUserList;

@interface RecommendUserCollectionViewController : UICollectionViewController
@property (strong, nonatomic) NSArray<RecommendUserList *> *recommendUsers;
@end
