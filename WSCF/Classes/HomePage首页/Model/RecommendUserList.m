//
//  RecommendUserList.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "RecommendUserList.h"


@implementation RecommendUserList
+ (instancetype)recommandUserListWithDict:(NSDictionary *)dict {
    RecommendUserList *rUL = [[RecommendUserList alloc] init];
    [rUL setValuesForKeysWithDictionary:dict];
    
    return rUL;
}

- (void)setImageid:(NSString *)imageid {
    _imageid = [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg", imageid];
}

@end
