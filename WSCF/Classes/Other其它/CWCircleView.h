//
//  CWCircleView.h
//
//  Created by ChenWei on 16/10/5.
//  Copyright © 2016年 cw. All rights reserved.
//
/** 
 * 利用4张imageView来实现能同时看到3张图片的轮播效果
 */

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface CWCircleView : UIView
/** 占位图片 */
@property (strong, nonatomic) NSString *placeholdImageName;
/** 图片size 默认值为(300,150) */
@property (assign, nonatomic) CGSize imageViewSize;
/** 图片间距 默认值为10*/
@property (assign, nonatomic) CGFloat imageViewMargin;
/** 图片数组 */
@property (strong, nonatomic) NSArray *imageNames;
/** 自动轮播间隔 默认值为3S*/
@property (assign, nonatomic) CGFloat autoTime;
/** 是否有指示器 */
//@property (assign, nonatomic) BOOL hasIndicater;
/** 图片被点击后调用的block */
@property (copy, nonatomic) void (^handlePictureClickedBlock) (NSInteger index);
//- (void)setImageNames:(NSArray *)imageNames
/** 是否设置指示器: YES 添加指示器并显示 NO:隐藏指示器,若无指示器也不添加 */
- (void)showIndicater:(BOOL)isShow;
- (void)startTimer;
- (void)stopTimer;
@end
