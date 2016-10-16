//
//  ChuShuoVideoCell.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/11.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "ChuShuoVideoCell.h"
#import "ChuShuo.h"
#import "UserImageButton.h"
#import <UIImageView+WebCache.h>
/**
 "image": "6947530",
 "collectionNum": 4109,
 "title": "蒜香骨",
 "type": 3,
 "userId": 6940491,
 "likeNum": 0,
 "userImage": "6940496",
 "totalNum": "",
 "userNick": "呆小萌_",
 "sortId": 5160,
 "id": 6947605,
 "desc": "材料：肋排大蒜大蒜粉生抽老抽料酒糖油做法：首先，把肋排切成一条一条的。如"
 },
 */
UIKIT_EXTERN  CGFloat kCellTopMargin;

@interface ChuShuoVideoCell ()
//@property (strong, nonatomic) ChuShuo *chuShuo;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titlLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLable;
/** 收藏人数 */
@property (weak, nonatomic) IBOutlet UILabel *collectionNumLabel;
@property (weak, nonatomic) IBOutlet UserImageButton *userNickButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation ChuShuoVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
////    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (void)setHighlighted:(BOOL)highlighted {

}

- (void)setChuShuo:(ChuShuo *)chuShuo {
    if (chuShuo == nil) {
        self.imageV.image = nil;
    
        self.titlLabel.text = nil;
        self.descLable.text = nil;
        
        self.collectionNumLabel.text = nil;
        self.userNickButton.imageView.image = nil;
        self.userNickButton.titleLabel.text = nil;
        
        return;
    }
    
    _chuShuo = chuShuo;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:chuShuo.image]];
    
    self.titlLabel.text = chuShuo.title;
    
    self.descLable.text = chuShuo.desc;
    
    self.collectionNumLabel.text = [NSString stringWithFormat:@"%zd 人收藏", chuShuo.collectionNum];
    
    self.userNickButton.chuShuo = chuShuo;
    
    if (chuShuo.type == ChuShuoTpyeNOVideo) {
        self.playButton.hidden = YES;
    }else {
        self.playButton.hidden = NO;
    }
}

- (void)setFrame:(CGRect)frame {
    frame = CGRectMake(0, frame.origin.y + kCellTopMargin, frame.size.width, frame.size.height - kCellTopMargin);
    [super setFrame:frame];
}


@end
