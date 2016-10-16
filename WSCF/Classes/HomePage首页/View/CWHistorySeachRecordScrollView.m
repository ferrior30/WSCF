//
//  CWHistorySeachRecordScrollView.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/4.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHistorySeachRecordScrollView.h"

/** button左右间隔 */
static CGFloat const kButtonInterMargin = 20;
/** button上下间隔 */
static CGFloat const kButtonLineMargin = 10;
/** button内部文字距边沿间隔 */
static CGFloat const kButtonTextAndEdgeMargin = 15;
/** button距屏幕边界距离 */
static CGFloat const kButtonEdgeMargin = 15;

@interface CWHistorySeachRecordScrollView ()
/** 记录所有添加的button */
@property (strong, nonatomic) NSMutableArray<UIButton *> *buttons;

@end

@implementation CWHistorySeachRecordScrollView

- (void)setHisRecoreds:(NSArray *)hisRecoreds {
    _hisRecoreds = hisRecoreds;
    
    // 1.删除所有子控件
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    // 2.添加“历史记录”buttons
    self.buttons = [NSMutableArray array];
    for (int i = 0; i < hisRecoreds.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        [btn setTitle:hisRecoreds[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn sizeToFit];
        btn.backgroundColor = CWGlobalBg;
        
        CGFloat buttonMaxW = self.bounds.size.width - 2 * kButtonEdgeMargin;
        CGFloat btnW = btn.bounds.size.width + 2 * kButtonTextAndEdgeMargin;
        btnW = (btnW < buttonMaxW) ? btnW : buttonMaxW;
        [btn setFrame:CGRectMake(0, 0, btnW, btn.bounds.size.height)];
        btn.layer.cornerRadius = 2;
        btn.layer.masksToBounds = YES;
       
        [btn addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
    
    // 3.添加【清除历史搜索】按钮
    UIButton *clearBtn = [[UIButton alloc] init];
    [clearBtn setTitle:@"清除历史搜索" forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [clearBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [clearBtn sizeToFit];
    clearBtn.frame = CGRectMake(0, 0, clearBtn.bounds.size.width + 10, clearBtn.bounds.size.height);
    clearBtn.layer.borderWidth = 1;
    clearBtn.layer.borderColor = CWGlobalBg.CGColor;
    
    [clearBtn addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
  
    clearBtn.tag = self.buttons.count;
    [self addSubview:clearBtn];
    [self.buttons addObject:clearBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i < self.buttons.count - 1; i++) {
        UIButton *btn = (UIButton *)self.buttons[i];
        if (i == 0) { // 1.第一个按钮
            btn.frame = CGRectMake(kButtonEdgeMargin, 10, btn.bounds.size.width, btn.bounds.size.height);
        }else { // 2.不是第一个按钮
            if (btn.bounds.size.width + CGRectGetMaxX(self.buttons[i - 1].frame) > self.bounds.size.width - 2 * kButtonEdgeMargin) { // 2.1超出边界
                btn.frame = CGRectMake(kButtonEdgeMargin,  CGRectGetMaxY(self.buttons[i - 1].frame) + kButtonLineMargin, btn.bounds.size.width, btn.bounds.size.height);
            }else { // 2.2没有超出边界
               btn.frame = CGRectMake(kButtonInterMargin + CGRectGetMaxX(self.buttons[i - 1].frame),  self.buttons[i - 1].frame.origin.y , btn.bounds.size.width, btn.bounds.size.height);
            }
        }
    }
    
    // 设置【清除按钮】frame
    UIButton *clearBtn = self.buttons.lastObject;
    clearBtn.center = CGPointMake(self.center.x, CGRectGetMaxY(self.buttons[self.buttons.count - 2].frame) + clearBtn.bounds.size.height * 0.5 + kButtonLineMargin);
    
}

#pragma mark - 监听方法
- (void)buttonDidClicked:(UIButton *)btn {
    NSLog(@"%ld", (long)btn.tag);
}

@end
