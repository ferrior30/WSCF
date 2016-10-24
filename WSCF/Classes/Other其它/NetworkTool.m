//
//  NetworkTool.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool
+ (instancetype)sharManager {
    static NetworkTool *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetworkTool alloc] init];
    });
    return manager;
}

- (NSDictionary *)baseParasDict {
    if (_baseParasDict == nil) {
        _baseParasDict = @{@"device": @"iPhone8,1",
                           @"machine": @"Oe465ee7d2c21f604916deace6307de8014615245",
                           @"version": @"12.8.2.1",
                           };
    }
    return _baseParasDict;
}
@end
