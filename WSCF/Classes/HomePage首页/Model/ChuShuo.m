//
//  ChuShuo.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "ChuShuo.h"

@implementation ChuShuo
+ (instancetype)chuShuoWithDict:(NSDictionary *)dict {
    ChuShuo *chuShuo = [[ChuShuo alloc] init];
    [chuShuo setValuesForKeysWithDictionary:dict];
    return chuShuo;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _Id = [value integerValue];
    }
}

- (void)setImage:(NSString *)image {
    _image = [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg", image];
}

- (void)setDesc:(NSString *)desc {
    _desc = desc;
    
    // 计算高度;
}

@end
