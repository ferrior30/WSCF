//
//  OnlineLiveCell.h
//  WSCF
//
//  Created by ChenWei on 16/10/23.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnLineLiveCook.h"

@interface OnlineLiveCell : UITableViewCell

@property (strong, nonatomic) OnLineLiveCook *onlineCook;

@property (weak, nonatomic) UIImageView *himageView;
@property (weak, nonatomic) UILabel *startTimeLabel;
@property (weak, nonatomic) UIImageView *nicknameImageView;
@property (weak, nonatomic) UILabel *nicknameLabel;
@property (weak, nonatomic) UILabel *ecookCoinLabel;
@property (weak, nonatomic) UILabel *titleLabel;
/** 剩余多久时间开始 */
@property (weak, nonatomic) UILabel *leftTimeLabel;

@end
