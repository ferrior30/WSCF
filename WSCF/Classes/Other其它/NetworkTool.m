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

@end
