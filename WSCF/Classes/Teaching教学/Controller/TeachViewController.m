//
//  TeachViewController.m
//  WSCF
//
//  Created by ChenWei on 16/10/22.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "TeachViewController.h"
#import <Masonry.h>
#import "OnlineLiveTableViewController.h"
#import "DownlineLiveTableViewController.h"
#import "NetworkTool.h"
#import "OnLIneLiveCook.h"
#import <MJRefresh.h>


static CGFloat const titleViewH = 40;

@interface TeachViewController ()
@property (weak, nonatomic) UIScrollView *containerView;
@property (strong, nonatomic) NSArray<UIViewController *> *childViewControllers;
@property (weak, nonatomic) UIButton *selectedTitleBtn;
/** 在线直播模型数组 */
@property (strong, nonatomic) NSMutableArray *onlineLiveCook;
@end

@implementation TeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 2.添加UI
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.childViewControllers.firstObject viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)setupUI {
    
    // 1.添加titleButtonView
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 64, CWScreenW, titleViewH);
    [self.view addSubview:titleView];
    
    // 1.1.添加onlineButton
    UIButton *onLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [onLineBtn setTitle:@"在线直播" forState:UIControlStateNormal];
    [onLineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [onLineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    onLineBtn.frame = CGRectMake(0, 0, titleView.bounds.size.width * 0.5, titleViewH);
    [titleView addSubview:onLineBtn];
    onLineBtn.tag = 0;
    [onLineBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.selectedTitleBtn = onLineBtn;
    self.selectedTitleBtn.backgroundColor = [UIColor redColor];
    // 1.2 添加downlineButton
    UIButton *downlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downlineBtn setTitle:@"线下课程" forState:UIControlStateNormal];
    [downlineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [downlineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    downlineBtn.frame = CGRectMake(titleView.bounds.size.width * 0.5, 0, titleView.bounds.size.width * 0.5, titleViewH);
    [titleView addSubview:downlineBtn];
    downlineBtn.tag = 1;
    [downlineBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 1.2 添加分隔线
    UIView *separateLine = [[UIView alloc] init];
    separateLine.frame = CGRectMake(0, titleView.bounds.size.height - 1, CWScreenW, 1);
    separateLine.backgroundColor = [UIColor blackColor];
    [titleView addSubview:separateLine];

    
       // 2.添加containerView
    UIScrollView *containerView = [[UIScrollView alloc] init];
    containerView.frame = CGRectMake(0, titleViewH + 64, CWScreenW, CWScreenH - (64 + titleViewH) - self.tabBarController.tabBar.bounds.size.height);
    [self.view addSubview:containerView];
    self.containerView = containerView;
    self.containerView.backgroundColor = [UIColor blueColor];
    self.containerView.contentSize = CGSizeMake(self.containerView.bounds.size.width * 2, 0);
    self.containerView.pagingEnabled = YES;
    self.containerView.showsHorizontalScrollIndicator = NO;

    // 2.1 添加tableView
    UIView *v = self.childViewControllers.firstObject.view;
    v.frame = containerView.bounds;
    [containerView addSubview:v];
    
    self.childViewControllers.lastObject.view.frame = CGRectMake(self.containerView.frame.origin.x + self.containerView.bounds.size.width, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
    [self.containerView addSubview:self.childViewControllers.lastObject.view];
}

#pragma mark - 监听titleBtn点击
- (void)titleBtnClicked:(UIButton *)btn {
    if (btn.selected == YES) return;
    if (btn.tag == 0) {

        [self.containerView setContentOffset:CGPointZero animated:YES];
    }else {
        [self.containerView setContentOffset:CGPointMake(self.containerView.bounds.size.width, 0) animated:YES];
    }
    self.selectedTitleBtn.selected = NO;
    self.selectedTitleBtn.backgroundColor = [UIColor whiteColor];
    
    btn.selected = YES;
    btn.backgroundColor = [UIColor redColor];
    self.selectedTitleBtn = btn;
    
}

#pragma mark -  懒加载Property
- (NSArray<UIViewController *> *)childViewControllers {
    if (_childViewControllers == nil) {
        OnlineLiveTableViewController *online = [[OnlineLiveTableViewController alloc] init];
        DownlineLiveTableViewController *downline = [[DownlineLiveTableViewController alloc] init];

        _childViewControllers = @[online, downline];
    }
    return _childViewControllers;
}



@end
