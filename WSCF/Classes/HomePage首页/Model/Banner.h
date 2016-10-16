//
//  Banner.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject
/** http://pic.ecook.cn/web/[替换成image].jpg */
@property (strong, nonatomic) NSString *image;
/** <#注释#> */
@property (strong, nonatomic) NSString *url;
+ (instancetype)bannerWithDict:(NSDictionary *)dict;
@end
