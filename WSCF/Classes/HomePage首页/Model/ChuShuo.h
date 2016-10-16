//
//  ChuShuo.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    // 没有视频
    ChuShuoTpyeVideo = 3,
    // 有视频
    ChuShuoTpyeNOVideo = 1,
    
    ChuShuoTpyeNormal = 4,
}ChuShuoTpye;

/**
 "image": "6947530",
 "collectionNum": 4109,
 "title": "蒜香骨",
 "type": 3,
 "userId": 6940491,
 "likeNum": 0,
 "userImage": "6940496",
 "totalNum": "",
 "userNick": "呆小萌_",
 "sortId": 5160,
 "id": 6947605,
 "desc": "材料：肋排大蒜大蒜粉生抽老抽料酒糖油做法：首先，把肋排切成一条一条的。如"
 },
 */
@interface ChuShuo : NSObject
/** 配图 */
@property (strong, nonatomic) NSString *image;
@property (assign, nonatomic) NSInteger collectionNum;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger type;
/** 用户id */
@property (assign, nonatomic) NSInteger userId;
@property (strong, nonatomic) NSString *userImage;
@property (assign, nonatomic) NSInteger likeNum;
@property (strong, nonatomic) NSString *totalNum;
@property (strong, nonatomic) NSString *userNick;
@property (assign, nonatomic) NSInteger sortId;
@property (assign, nonatomic) NSInteger Id;
@property (strong, nonatomic) NSString *desc;

/** 辅助属性 */
@property (assign, nonatomic)  CGFloat desHeight;

+ (instancetype)chuShuoWithDict:(NSDictionary *)dict;


@end
