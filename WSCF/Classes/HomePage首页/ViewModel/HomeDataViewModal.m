//
//  HomeDataViewModal.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "HomeDataViewModal.h"
#import "NetworkTool.h"
#import "Banner.h"
#import "ButtonList.h"
#import "RecommendUserList.h"
#import "ChuShuo.h"
#import <SDWebImageDownloader.h>

@interface HomeDataViewModal ()
/** 存储上拉返回的所有下拉的帖子id */
@property (copy, nonatomic) NSArray *idList;
//* 记录最后一次下拉请求的ids string 
//@property (copy, nonatomic) NSString *currentIdsString;
/** 请求长贴子的起始index */
@property (assign, nonatomic) NSInteger idFromIndex;
@property (assign, nonatomic) NSInteger tempIndex;

/** 上拉请求参数 */
@property (copy, nonatomic) NSMutableDictionary *pullUpParas;

@end

/**
 * device	iPhone8,1
 * machine	Oe465ee7d2c21f604916deace6307de8014615245
 * version	12.8.0.7
 */
@implementation HomeDataViewModal

#pragma mark - 懒加载
- (NSMutableDictionary *)pullUpParas{
    if (_pullUpParas == nil) {
        
        _pullUpParas = [NSMutableDictionary dictionary];
        [_pullUpParas setValuesForKeysWithDictionary:@{@"device": @"iPhone8,1",
                                                         @"machine": @"Oe465ee7d2c21f604916deace6307de8014615245",
                                                         @"version": @"12.8.2.1",
                                                         }];
    }
    return _pullUpParas;
}

- (void)requestDifferentHomeData:(nullable void (^)())filishBack error:(nullable void (^)(NSError * _Nonnull error))errorBack {
    // 第一次进入app的请求的参数
    NSDictionary *paras = @{@"device": @"iPhone8,1",
                            @"machine": @"Oe465ee7d2c21f604916deace6307de8014615245",
                            @"version": @"12.8.2.1"};
    
    NSString *URL = @"http://api.ecook.cn/public/getDifferentHomedata.shtml";

    __weak typeof(self) weakSelf = self;
    
    [[NetworkTool sharManager] POST:URL parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 1.无限轮播banner数据
        NSMutableArray *bannerArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"][@"bannerList"]) {
            Banner *banner =   [Banner bannerWithDict:dict];
            
            [bannerArray addObject:banner];
        }
        
        weakSelf.bannerArray = bannerArray;
        
        // 2.buttonList数据
        NSMutableArray *buttonArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"][@"buttonList"]) {
            ButtonList *btnList = [ButtonList buttonLithWithDict:dict];
            [buttonArray addObject:btnList];
        }
        weakSelf.buttonArray = buttonArray;
        
        // 3.recommendUserList数据
        NSMutableArray *recommendUserArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"][@"recommendUserList"]) {
            RecommendUserList *recommendUser = [RecommendUserList recommandUserListWithDict:dict];
            [recommendUserArray addObject:recommendUser];
        }
        weakSelf.recommendUserArray = recommendUserArray;
        
        // 4.存储ids数据,并请求chuShuo数据 isPullDown : YES 表示下拉请求
        NSArray *array = responseObject[@"data"][@"idList"];
        if ([array.firstObject integerValue] >= [weakSelf.idList.firstObject integerValue]) {
            // 有新chushuo数据,发请求
//            weakSelf.chuShuos = nil;
            
            // 存储最新的ids
            weakSelf.idList = responseObject[@"data"][@"idList"];
            
            // 请求Differentdata
            weakSelf.idFromIndex = 0;
            [weakSelf requestDifferentdataFilishBack:^(BOOL isSuccess) {
                if (isSuccess) { //请求到了最新chushuo数据
                    
                    filishBack();
                }else { // 没有请求到最新chushuo数据
                    NSString *errorString = @"请求最新chuShuo失败";
                    NSErrorDomain domain = errorString;
                    NSError *errorB = [NSError errorWithDomain:domain  code:2 userInfo:nil];
                    errorBack(errorB);
                }
            } isPullDown:YES];
        }else { // 没有更新数据,返回错误信息并return
            NSString *errorString = @"noNewData";
            NSErrorDomain domain = errorString;
            NSError *errorA = [NSError errorWithDomain:domain  code:1 userInfo:nil];
            errorBack(errorA);
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { // 请求HomeDifferentData失败
        errorBack(error);
    }];
}

- (void)requestDifferentdataFilishBack:(nonnull void (^)(BOOL isSuccess))filishBack isPullDown:(BOOL)isPullDown {
    __weak typeof(self) weakSelf = self;
    
    // 设置ids参数
    [weakSelf.pullUpParas setValue:[self idsString] forKey:@"ids"];
    
    [[NetworkTool sharManager] POST:@"http://api.ecook.cn/public/getDifferentdataList.shtml" parameters:self.pullUpParas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *chushuos = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            ChuShuo *chuShuo = [ChuShuo chuShuoWithDict:dict];
            [chushuos addObject:chuShuo];
        }
        if (isPullDown) {
            // 下拉请求,直接接收最新的,以前的不要了.
            weakSelf.chuShuos = chushuos;
        }else {
            [weakSelf.chuShuos addObjectsFromArray:chushuos];
        }
        filishBack(YES);
        
        weakSelf.idFromIndex = self.tempIndex + 1;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        filishBack(NO);
    }];
}

#pragma mark - 计算ids
- (NSString *)idsString {
    __weak typeof(self) weakSelf = self;
    NSMutableString *idsString = [NSMutableString string];
    weakSelf.tempIndex = weakSelf.idFromIndex;;
    for (NSInteger i = weakSelf.idFromIndex; i <= weakSelf.idFromIndex + 9;i++) {
        if (i == weakSelf.idFromIndex) {
            idsString = [NSMutableString stringWithFormat:@"%zd", [weakSelf.idList[i] integerValue]];
        }else {
            if (weakSelf.idList[i] != nil) {
                [idsString appendString:[NSString stringWithFormat:@",%zd", [self.idList[i] integerValue]]];
                weakSelf.tempIndex = i;
            }else return idsString;
        }
    }
    return idsString;
}

- (void)setBannerArray:(NSArray *)bannerArray {
    _bannerArray= bannerArray;
    
    NSMutableArray *imageNames = [NSMutableArray array];
    for (Banner *banner in bannerArray) {
        NSString *url = [NSString  stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg", banner.image];
        [imageNames addObject:url];
    }
    self.bannerImageNames = imageNames;
}
@end
