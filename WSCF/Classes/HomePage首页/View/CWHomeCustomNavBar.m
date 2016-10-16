//
//  CWHomeCustomNavBar.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/9/21.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWHomeCustomNavBar.h"
#import "CWSearchViewController.h"

@interface CWHomeCustomNavBar ()
@property (weak, nonatomic) UIButton *addBtn;
@property (weak, nonatomic) UIButton *basketBtn;


@end

@implementation CWHomeCustomNavBar

- (instancetype)init {
    if (self = [super init]) {
        // 添加子控件
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"Icon_Add_Recipe_21x21_"] forState:UIControlStateNormal];
    [self addSubview:addBtn];
    self.addBtn = addBtn;
    
    UIButton *basketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [basketBtn setImage:[UIImage imageNamed:@"recipe_basket_21x20_"] forState:UIControlStateNormal];
    [self addSubview:basketBtn];
    self.basketBtn = basketBtn;
    
//    UISearchBar *searchbar = [[UISearchBar alloc] init];
////    searchbar.barTintColor = [UIColor redColor];
////     searchbar.tintColor = [UIColor yellowColor];
//    searchbar.layer.cornerRadius = 2;
//    searchbar.clipsToBounds = YES;
//    [searchbar setSearchFieldBackgroundImage:[UIImage imageNamed:@"activity_end_52x27_"] forState:UIControlStateNormal];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
    [searchBtn setImage:[UIImage imageNamed:@"sososo_16x16_"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"菜名/食材/厨友" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    searchBtn.layer.cornerRadius = 2;
    [searchBtn addTarget:self action:@selector(searchBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:searchBtn];
    self.searchBtn = searchBtn;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnWidth = 50;
    self.addBtn.frame = CGRectMake(0, 0, btnWidth, self.bounds.size.height);
    self.basketBtn.frame = CGRectMake(self.bounds.size.width - btnWidth, 0, btnWidth, self.bounds.size.height);
    
    self.searchBtn.frame = CGRectMake(btnWidth, (self.bounds.size.height - 28) * 0.5, self.bounds.size.width - 2 * btnWidth, 28);
}

#pragma mark - 监听searchBtn按钮点击
- (void)searchBtnDidClicked {
    CWSearchViewController *vc = [[CWSearchViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
