//
//  CWTabBarButton.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/9/20.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWTabBarButton.h"

@implementation CWTabBarButton
- (void)setHighlighted:(BOOL)highlighted {
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 如果没有调整title和imageView
    if (self.imageView.center.x != self.frame.size.width * 0.5) {
        CGPoint center = self.imageView.center;
        center.x = self.bounds.size.width * 0.5;
        center.y = self.imageView.frame.size.height * 0.5 + 8;
        self.imageView.center = center;
    
        self.titleLabel.center = CGPointMake(self.bounds.size.width * 0.5, CGRectGetMaxY(self.imageView.frame) + (self.frame.size.height - CGRectGetMaxY(self.imageView.frame)) * 0.5);
    }
}

@end
