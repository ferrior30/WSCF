//
//  Teacher.m
//  WSCF
//
//  Created by ChenWei on 16/10/23.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
//    
//}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"
             };
}

- (void)setImageid:(NSString *)imageid {
    _imageid = [NSString stringWithFormat:@"%@%@.jpg", pictureBaseURL, imageid];
}

@end
