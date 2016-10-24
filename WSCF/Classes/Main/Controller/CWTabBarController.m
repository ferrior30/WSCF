//
//  CWTabBarController.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/9/20.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWTabBarController.h"
#import "CWTabBar.h"
#import "CWTabBarButton.h"
#import "CWHomeTableViewController.h"
#import "CWHomeCustomNavBar.h"
#import "ShopViewController.h"
#import "TeachViewController.h"

@interface CWTabBarController ()<CWTabBarDeletgate>
/** items:UITabBarItems模型 */
@property (strong, nonatomic) NSMutableArray *items;
@end

@implementation CWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 添加子控制器
    [self setupChildsVc];
    
    // 自定义tabBar
    [self setupTabBar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 移除系统上自动添加的tabBarButton
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[CWTabBar class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)setupTabBar {
    CWTabBar *tabBar = [[CWTabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.items = self.items;
    tabBar.delegate = self;
    
     [self.tabBar addSubview:tabBar];
}

- (void)setupChildsVc {
    // 1.首页
    CWHomeTableViewController *homeVc = [[CWHomeTableViewController alloc] init];
    [self setupOneChildVcWithRootViewController:homeVc title:@"首页" imageName:@"tab_home_22x23_" selectedImageName:@"tab_home_this_22x23_"];
    // 添加首页自定义导航界面
    CWHomeCustomNavBar *customNavBar = [[CWHomeCustomNavBar alloc] init];
    homeVc.customNavBar = customNavBar;
    customNavBar.frame = homeVc.navigationController.navigationBar.bounds;
    customNavBar.backgroundColor = [UIColor whiteColor];
    [homeVc.navigationController.navigationBar addSubview:customNavBar];
 
    
    // 2.商城
    NSURL *URL = [NSURL URLWithString:@"http://mall.ecook.cn/category/list?f=ecook_show_mine&machine=Oe465ee7d2c21f604916deace6307de8014615245"];
    ShopViewController *shopVc = [ShopViewController showViewControllerWithURL:URL isFirstEnter:YES];
    
    shopVc.title = @"商城";
    [self setupOneChildVcWithRootViewController:shopVc title:@"商城" imageName:@"tab_shop_24x20_" selectedImageName:@"tab_shop_24x20_"];
    
    // 3.教学
    TeachViewController *teachingVc = [[TeachViewController alloc] init];
    teachingVc.title = @"教学";
    [self setupOneChildVcWithRootViewController:teachingVc title:@"教学" imageName:@"tab_teach_22x19_" selectedImageName:@"tab_teach_this_22x19_"];
    
    // 4.厨说
    UITableViewController *chuShuoVc = [[UITableViewController alloc] init];
    chuShuoVc.view.backgroundColor = [UIColor yellowColor];
    chuShuoVc.title = @"厨说";
    [self setupOneChildVcWithRootViewController:chuShuoVc title:@"厨说" imageName:@"tab_circle_21x21_" selectedImageName:@"tab_circle_this_21x21_"];
    
    // 5.我的
    UITableViewController *myVc = [[UITableViewController alloc] init];
    myVc.view.backgroundColor = [UIColor blueColor];
    
    myVc.title = @"我的";
    [self setupOneChildVcWithRootViewController:myVc title:@"我的" imageName:@"tab_me_22x21_" selectedImageName:@"tab_me_this_22x21_"];
    
}

- (void)setupOneChildVcWithRootViewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedName {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    nav.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedName];
    
    [self addChildViewController:nav];
    [self.items addObject:nav.tabBarItem];
}

#pragma mark - CWTabBarDeletgate
/** 点击tabBar上的按钮时调用 */
- (void)tabBar:(CWTabBar *)tabBar didSelectedBtn:(NSUInteger)index {
    self.selectedIndex = index;
}

#pragma mark - Properties
/** items模型数组懒加载 */
- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end
