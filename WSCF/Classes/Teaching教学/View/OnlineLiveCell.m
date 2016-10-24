//
//  OnlineLiveCell.m
//  WSCF
//
//  Created by ChenWei on 16/10/23.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "OnlineLiveCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "NSString+CWNSDate.h"
#import "UIImageView+CWExtension.h"


static CGFloat const kMargin = 10;

@implementation OnlineLiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    UIImageView *himgView = [[UIImageView alloc] init];
    [self.contentView addSubview:himgView];
    himgView.clipsToBounds = YES;
    himgView.contentMode = UIViewContentModeScaleAspectFill;
    self.himageView = himgView;
    
    UIView *timeView = [[UIView alloc] init];
    [self.contentView addSubview:timeView];
    timeView.backgroundColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:0.7];
    
    
    UILabel *startTimeLabel = [[UILabel alloc] init];
    [timeView addSubview:startTimeLabel];
    self.startTimeLabel = startTimeLabel;
    startTimeLabel.textColor = [UIColor whiteColor];
    startTimeLabel.font = [UIFont systemFontOfSize:12];
    
    UILabel *leftTimeLabel = [[UILabel alloc] init];
    [timeView addSubview:leftTimeLabel];
    self.leftTimeLabel = leftTimeLabel;
    leftTimeLabel.textColor = [UIColor whiteColor];
    leftTimeLabel.font = [UIFont systemFontOfSize:12];

    // teachView
    UIView *teacherView = [[UIView alloc] init];
    [self.contentView addSubview:teacherView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [teacherView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:12];
    
    UIImageView *nicknameV = [[UIImageView alloc] init];
    [teacherView addSubview:nicknameV];
    self.nicknameImageView = nicknameV;
    
    UILabel *nicknameLabel = [[UILabel alloc] init];
    [teacherView addSubview:nicknameLabel];
    self.nicknameLabel = nicknameLabel;
    nicknameLabel.textColor = [UIColor lightGrayColor];
    nicknameLabel.font = [UIFont systemFontOfSize:10];

    UILabel *ecookCoinLabel = [[UILabel alloc] init];
    [teacherView addSubview:ecookCoinLabel];
    self.ecookCoinLabel = ecookCoinLabel;
    ecookCoinLabel.font = [UIFont systemFontOfSize:12];
    
//    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cook_collection_24x24_"]];
//    imageV.frame = CGRectMake(50, 50, 60, 60);
//    [self.contentView addSubview:imageV];
    
    // 布局
    [self.himageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
//        make.height.mas_equalTo(kHimgViewH);
    }];
    
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.mas_equalTo(self.himageView).offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.centerY.offset(0);
    }];
    
    [self.leftTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(- kMargin);
        make.centerY.offset(0);
    }];
    
    [teacherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.himageView.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kMargin);
        make.left.offset(kMargin);
    }];
    
    [self.nicknameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kMargin);
        make.bottom.offset(-kMargin);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_nicknameImageView);
        make.left.mas_equalTo(_nicknameImageView.mas_right).offset(kMargin);
    }];
    
    [self.ecookCoinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-kMargin);
        make.bottom.offset(-kMargin);
    }];
}

#pragma mark - Property
- (void)setOnlineCook:(OnLineLiveCook *)onlineCook {
//    if (_onlineCook) {
//        return;
//    }
    _onlineCook = onlineCook;
    
    // 设置himg
    [self.himageView sd_setImageWithURL:[NSURL URLWithString:onlineCook.himg] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.himageView.image = image;
    }];
    
    // startTimeLabel
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[onlineCook.startTime integerValue] / 1000.0];
    self.startTimeLabel.text = [NSString cw_stringWithDate:date];
    
    // leftTimeLabel
    
    NSTimeInterval timeInterval =  [date timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970];;
    if (timeInterval <= 0) {
        self.leftTimeLabel.text = @"回放";
    } else {
        NSInteger hour = timeInterval / 60 / 60;
        self.leftTimeLabel.text = [NSString stringWithFormat:@"%ld小时后开始", hour];
    }
    
    //
    self.titleLabel.text = onlineCook.title;
    
    //
    self.ecookCoinLabel.text = [NSString stringWithFormat:@"学费: %ld厨币", (long)onlineCook.ecookCoin];
    
    //
    self.nicknameLabel.text = onlineCook.teacher.nickname;
    
    //
    
    [self.himageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.onlineCook.himgHeight);
    }];
    
    [self.nicknameImageView cw_setCircleIconWithURL:[NSURL URLWithString:onlineCook.teacher.imageid]];
    
//    [self.nicknameImageView sd_setImageWithURL:[NSURL URLWithString:onlineCook.teacher.imageid]];
}


@end
