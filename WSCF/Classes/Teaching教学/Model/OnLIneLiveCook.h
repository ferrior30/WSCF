//
//  OnLIneLiveCook.h
//  WSCF
//
//  Created by ChenWei on 16/10/22.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "Teacher.h"


/**
 ecookCoin = 1;
 endTime = 1477386000000;
 himg = 234643989;
 id = 1036;
 live = "rtmp://live.ecook.cn/live/1036";
 paytype = kc;
 price = 1;
 push = "rtmp://push.ecook.cn/live/1036";
 startTime = 1477382400000;
 status = 8;
 teacher =     {
 id = 24069838;
 imageid = 223325685;
 nickname = "\U7a9d\U5c0f\U82bd";
 };
 title = "\U5b9d\U5b9d\U7248\U8425\U517b\U5065\U5eb7\U54aa\U54aa\U867e\U6761";
 vedio = "";
 vimg = "";
 
 
 */



@interface OnLineLiveCook: NSObject
@property (assign, nonatomic) NSInteger ecookCoin;
@property (strong, nonatomic) NSString *himg;
@property (strong, nonatomic) NSString *push;
@property (strong, nonatomic) Teacher *teacher;
@property (strong, nonatomic) NSString *vedio;
@property (assign, nonatomic) NSInteger price;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *vimg;
@property (strong, nonatomic) NSString *endTime;
@property (assign, nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString *paytype;
@property (strong, nonatomic) NSString *live;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger himgHeight;

@end








