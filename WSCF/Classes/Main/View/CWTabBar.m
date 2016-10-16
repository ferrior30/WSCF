//
//  CWTabBar.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/9/20.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWTabBar.h"
#import "CWTabBarButton.h"

@interface CWTabBar ()
@property (weak, nonatomic) CWTabBarButton *selectBtn;
@end

@implementation CWTabBar

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setItems:(NSArray *)items {
    _items = items;
    
    // 添加tabBarButton
    for (UITabBarItem *item in items) {
        CWTabBarButton *tabBarButton = [CWTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // title
        [tabBarButton setTitle:item.title forState:UIControlStateNormal];
        [tabBarButton setTitle:item.title forState:UIControlStateSelected];
        tabBarButton.titleLabel.font = [UIFont systemFontOfSize:10];
        
        [tabBarButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tabBarButton setTitleColor:[UIColor colorWithRed:253/255.0 green:191/255.0 blue:45/255.0 alpha:1] forState:UIControlStateSelected];
        
        // image
        [tabBarButton setImage:item.image forState:UIControlStateNormal];
        [tabBarButton setImage:item.selectedImage forState:UIControlStateSelected];
        
        // 添加点击事件
        [tabBarButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
       
        // 设置tag
        tabBarButton.tag = self.subviews.count;
        
        // 初始化选中第一个按钮
        if (self.subviews.count == 0) {
            [self buttonClick:tabBarButton];
        }
        
        [self addSubview:tabBarButton];
    }
}

- (void)buttonClick:(CWTabBarButton *)button {
    if (_selectBtn != button) {
        _selectBtn.selected = NO;
        _selectBtn = button;
        button.selected = YES;
    }
    
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(tabBar: didSelectedBtn:)]) {
        [self.delegate tabBar:self didSelectedBtn:button.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 按钮的宽度和高度
    CGFloat width = self.frame.size.width / self.subviews.count;
    CGFloat height = self.frame.size.height;
    CGFloat x = 0;
    
    
    for (int i = 0; i < self.subviews.count; i++) {
        x = width * i;
        
        self.subviews[i].frame = CGRectMake(x, 0, width, height);
    }
}

@end
