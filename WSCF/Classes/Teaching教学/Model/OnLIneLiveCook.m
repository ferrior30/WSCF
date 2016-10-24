//
//  OnLineLiveCook.m
//  WSCF
//
//  Created by ChenWei on 16/10/22.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "OnLIneLiveCook.h"

@implementation OnLineLiveCook : NSObject

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"
             };
}

- (void)setHimg:(NSString *)himg {
    _himg = [NSString stringWithFormat:@"%@%@.jpg", pictureBaseURL,himg];
}



@end
