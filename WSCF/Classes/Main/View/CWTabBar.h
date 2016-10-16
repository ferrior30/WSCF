//
//  CWTabBar.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/9/20.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CWTabBar;

@protocol CWTabBarDeletgate <NSObject>

@optional
- (void)tabBar:(CWTabBar *)tabBar didSelectedBtn:(NSUInteger)index;

@end

@interface CWTabBar : UIView
/** items:UITabBarItem模型 */
@property (strong, nonatomic) NSArray *items;
@property (weak, nonatomic) id<CWTabBarDeletgate> delegate;
@end
