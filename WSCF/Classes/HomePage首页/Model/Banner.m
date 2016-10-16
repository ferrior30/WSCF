//
//  Banner.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "Banner.h"

@implementation Banner
+ (instancetype)bannerWithDict:(NSDictionary *)dict {
    Banner *bL = [[Banner alloc] init];
    [bL setValuesForKeysWithDictionary:dict];
    return bL;
}
@end
