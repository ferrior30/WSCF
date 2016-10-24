//
//  RecommendUserCell.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/10.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "RecommendUserCell.h"
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
#import "UIImage+CWCircleImage.h"
#import "UIImageView+CWExtension.h"
#import <UIImageView+WebCache.h>

@interface RecommendUserCell ()
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *label;
@end

@implementation RecommendUserCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加子控件
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
    
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(0, imageView.bounds.size.height, imageView.bounds.size.width, self.bounds.size.height - imageView.bounds.size.height);
    
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setRecommendUserList:(RecommendUserList *)recommendUserList {
    _recommendUserList = recommendUserList;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:recommendUserList.imageid] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            UIImage *circleImage = [image circleImage];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.imageView.image = circleImage;
//            });
//        });
//        
//    }];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:recommendUserList.imageid] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
                    UIImage *circleImage = [image circleImage];
        
                        self.imageView.image = circleImage;

                
        }];
    
    

    self.label.text = recommendUserList.title;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end
