//
//  NetworkTool.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkTool : AFHTTPSessionManager
+ (instancetype _Nonnull)sharManager;
//+ (void)POST:(NSString * _Nullable )url parameters:(id _Nullable)parameters success:(void (^_Nullable)(id _Nullable responseObject))successBlock failure:(void(^ _Nullable)(NSError * _Nullable error))failureBlock;
//
//+ (void)GET:(nonnull NSString *)url parameters:(nullable id)parameters success:(void (^_Nonnull)(id _Nullable responseObject))successBlock failure:(void ( ^_Nonnull)(NSError * _Nullable error))failureBlock;
@end
