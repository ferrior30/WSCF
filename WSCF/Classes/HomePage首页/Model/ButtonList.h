//
//  ButtonList.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ButtonList : NSObject
@property (strong, nonatomic) NSString *imageId;
@property (assign, nonatomic)  NSInteger num;

/** json数据中key为id */
@property (assign, nonatomic)  NSInteger Id;
@property (assign, nonatomic)  NSInteger state;
@property (strong, nonatomic)  NSString *title;
@property (assign, nonatomic)  NSInteger url;

+ (instancetype)buttonLithWithDict:(NSDictionary *)dict;

@end
