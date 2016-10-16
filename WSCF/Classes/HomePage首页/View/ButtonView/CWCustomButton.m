//
//  CWCustomButton.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWCustomButton.h"
#import "ButtonList.h"
#import <UIButton+WebCache.h>

@implementation CWCustomButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (void)setHighlighted:(BOOL)highlighted {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake((self.bounds.size.width - 50) * 0.5, 10, 50, 50);
    
    self.titleLabel.frame = CGRectMake(0, self.imageView.bounds.size.height, self.bounds.size.width, self.bounds.size.height - self.imageView.bounds.size.height);
}

- (void)setButtonList:(ButtonList *)buttonList {
    _buttonList = buttonList;
    
    [self sd_setImageWithURL:[NSURL URLWithString:buttonList.imageId] forState:UIControlStateNormal];
    
    [self setTitle:buttonList.title forState:UIControlStateNormal];
}

@end
