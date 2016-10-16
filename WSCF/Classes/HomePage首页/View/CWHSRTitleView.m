//
//  CWHSRTitleView.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/4.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHSRTitleView.h"

static CGFloat const KMargin = 15;

@implementation CWHSRTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_history_14x14_"]];
        [self addSubview:image];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"历史搜索";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        [label sizeToFit];
        [self addSubview:label];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat centerY = self.bounds.size.height * 0.5;
    self.subviews.firstObject.center = CGPointMake(KMargin + self.subviews.firstObject.bounds.size.width * 0.5, centerY);
    
    self.subviews.lastObject.center = CGPointMake(CGRectGetMaxX(self.subviews.firstObject.frame) + 5 + self.subviews.lastObject.bounds.size.width * 0.5, centerY);
    
}

@end
