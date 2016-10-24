//
//  ChuShuoNormalCell.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "ChuShuoNormalCell.h"
#import "UserImageButton.h"
#import <UIButton+WebCache.h>
#import "ChuShuo.h"
#import "UIImage+CWCircleImage.h"
#import <UIImageView+WebCache.h>

CGFloat kCellTopMargin = 10;

@interface ChuShuoNormalCell ()
@property (weak, nonatomic) IBOutlet UserImageButton *userImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *lickNumLabel;

@end

@implementation ChuShuoNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
//- (void)setHighlighted:(BOOL)highlighted{
//    
//}


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
////    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (void)setChuShuo:(ChuShuo *)chuShuo {
    if (chuShuo == nil) {
        self.imageV.image = nil;
        self.userImageButton.imageView.image = nil;
        self.lickNumLabel.text = nil;
        self.descLabel.text = nil;
        
        return;
    }
    _chuShuo = chuShuo;
    
    self.userImageButton.chuShuo = chuShuo;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:chuShuo.image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageV.image = image;
    }];
    
    self.lickNumLabel.text = [NSString stringWithFormat:@"%zd 人点赞", chuShuo.likeNum];
    
    self.descLabel.text = chuShuo.desc;
    
}

- (void)setFrame:(CGRect)frame {
    frame = CGRectMake(0, frame.origin.y + kCellTopMargin, frame.size.width, frame.size.height - kCellTopMargin);
    [super setFrame:frame];
}


@end
