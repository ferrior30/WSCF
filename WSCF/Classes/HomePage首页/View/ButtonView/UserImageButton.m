//
//  UserImageButton.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "UserImageButton.h"
#import <UIButton+WebCache.h>
#import "ChuShuo.h"
#import "UIImage+CWCircleImage.h"
#import <UIImageView+WebCache.h>

@implementation UserImageButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:10];
}

- (void)setHighlighted:(BOOL)highlighted {
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, 50, 50);
    
    self.titleLabel.frame = CGRectMake(0, self.imageView.bounds.size.height, self.bounds.size.width, self.bounds.size.height - self.imageView.bounds.size.height);
}

- (void)setChuShuo:(ChuShuo *)chuShuo {
    _chuShuo = chuShuo;
    
     [self setTitle:chuShuo.userNick forState:UIControlStateNormal];
    
//    if (chuShuo.image == nil) {
//        return;
//    }
    
    NSString *url = [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg",chuShuo.userImage];

    
    
        [self sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:nil completed:^( UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
//             UIImage *circleImage = [image circleImage];
//            [self setImage:circleImage forState:UIControlStateNormal];
            
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *circleImage = [image circleImage];
                
//                dispatch_async(dispatch_get_main_queue(), ^{
                
                    [self setImage:circleImage forState:UIControlStateNormal];
                    
//                });
//            });
            
        }];
}


@end
