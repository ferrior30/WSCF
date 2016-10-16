//
//  CWHomeCustomNavBar.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/9/21.
//  Copyright © 2016年 cw. All rights reserved.
//
/** 
 * 首页根控制器的导航栏上添加的含有搜索框的界面
 * 当push到下一个时隐藏此添加的界面
 */

#import <UIKit/UIKit.h>

@interface CWHomeCustomNavBar : UIView
/** 探索框 */
@property (weak, nonatomic) UIButton *searchBtn;
@end
