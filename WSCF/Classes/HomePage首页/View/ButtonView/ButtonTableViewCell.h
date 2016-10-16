//
//  ButtonTableViewCell.h
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWCustomButton.h"
#import "ButtonList.h"

@interface ButtonTableViewCell : UITableViewCell
/** button模型数组 */
@property (strong, nonatomic) NSArray<ButtonList *> *buttons;

@property (weak, nonatomic) IBOutlet CWCustomButton *button0;
@property (weak, nonatomic) IBOutlet CWCustomButton *button1;
@property (weak, nonatomic) IBOutlet CWCustomButton *button2;
@property (weak, nonatomic) IBOutlet CWCustomButton *button3;

@end
