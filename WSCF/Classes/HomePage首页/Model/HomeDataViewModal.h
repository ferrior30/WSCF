//
//  HomeDataViewModal.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChuShuo;

@interface HomeDataViewModal : NSObject


@property (strong, nonatomic) NSArray *bannerArray;
/** 存放无限轮播的图片url数组 */
@property (strong, nonatomic) NSArray *bannerImageNames;
@property (strong, nonatomic) NSArray *recommendUserArray;
@property (strong, nonatomic) NSArray *buttonArray;
@property (strong, nonatomic) NSMutableArray<ChuShuo *> *chuShuos;

/** 请求头部的数据及请求Differentdata所需的的参数 */
- (void)requestDifferentHomeData:(nullable void (^)())filishBack error:(nullable void (^)( NSError * _Nonnull error))errorBack;
/** 请求Differentdata */
- (void)requestDifferentdataFilishBack:(nonnull void (^)(BOOL isSuccess))filishBack isPullDown:(BOOL)isPullDown;
@end
