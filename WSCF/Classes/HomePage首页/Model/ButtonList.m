//
//  ButtonList.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "ButtonList.h"

@implementation ButtonList
+ (instancetype)buttonLithWithDict:(NSDictionary *)dict {
    ButtonList *buttonList = [[ButtonList alloc] init];
    [buttonList setValuesForKeysWithDictionary:dict];
    
    return buttonList;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key  isEqual: @"id"]) {
        self.Id = [value integerValue];
    }
}

- (void)setImageId:(NSString *)imageId {
    
    _imageId = [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg", imageId];
    
}
@end
