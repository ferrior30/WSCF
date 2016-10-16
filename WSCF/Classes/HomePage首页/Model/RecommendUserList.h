//
//  RecommendUserList.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 uid	:	226099357
 
 imageid	:	226099585
 
 profile	:	我感动地幻想，二十九岁我们一起到北欧去。
 
 title	:	阮阮
 
 */
@interface RecommendUserList : NSObject

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *imageid;
@property (strong, nonatomic) NSString *profile;
@property (strong, nonatomic) NSString *title;
+ (instancetype)recommandUserListWithDict:(NSDictionary *)dict;
@end
