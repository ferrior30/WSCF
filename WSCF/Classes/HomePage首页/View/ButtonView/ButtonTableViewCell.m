//
//  ButtonTableViewCell.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "ButtonTableViewCell.h"

UIKIT_EXTERN CGFloat kCellTopMargin;

@implementation ButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setButtons:(NSArray<ButtonList *> *)buttons {
    self.button0.buttonList = buttons[0];
    self.button1.buttonList = buttons[1];
    self.button2.buttonList = buttons[2];
    self.button3.buttonList = buttons[3];

}
- (IBAction)buttonClick:(CWCustomButton *)button {
    NSLog(@"%ld", (long)button.tag);
}

- (void)setFrame:(CGRect)frame {
    frame = CGRectMake(0, frame.origin.y + kCellTopMargin, frame.size.width, frame.size.height- kCellTopMargin);
    [super setFrame:frame];
}


@end
