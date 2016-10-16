//
//  CWHomeTableViewController.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/9/21.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CWHomeCustomNavBar;

@interface CWHomeTableViewController : UITableViewController
/** 首页自定义的导航栏界面 */
@property (weak, nonatomic) CWHomeCustomNavBar *customNavBar;
@end
