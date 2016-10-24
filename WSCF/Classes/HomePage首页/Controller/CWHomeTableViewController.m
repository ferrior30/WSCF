//
//  CWHomeTableViewController.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/9/21.
//  Copyright © 2016年 cw. All rights reserved.
//
// 0x600000236920 0x600000236920  0x600000238420  0x6000004361e0  0x608000436420


#import "CWHomeTableViewController.h"
#import "CWHomeCustomNavBar.h"
#import "CWHomeHeaderView.h"
#import "CWCircleView.h"
#import "HomeDataViewModal.h"
#import "RecommendUserCollectionViewController.h"
#import "ButtonTableViewCell.h"
#import "ChuShuoNormalCell.h"
#import "ChuShuoVideoCell.h"
#import "ChuShuo.h"
#import <MJRefresh.h>
#import "UserImageButton.h"

NSString *const NormalCellId = @"NormalCellId";
NSString *const RecommendUserCellId = @"RecommendUserCellId";
NSString *const ButtonTableViewCellId = @"ButtonTableViewCellId";
NSString *const ChuShuoNormalCellId = @"ChuShuoNormalCellId";
NSString *const ChuShuoVideoCellId = @"ChuShuoVideoCellId";


UIKIT_EXTERN  CGFloat kCellTopMargin;

@interface CWHomeTableViewController ()
/** home的viewModel */
@property (strong, nonatomic) HomeDataViewModal *homeDataViewModal;
/** 推荐用户控制器 */
@property (strong, nonatomic) RecommendUserCollectionViewController *recommendUserCollectionViewController;
@property (weak, nonatomic) CWCircleView *headerCircleView;

@end

@implementation CWHomeTableViewController

#pragma mark - 懒加载
- (RecommendUserCollectionViewController *)recommendUserCollectionViewController {
    if (_recommendUserCollectionViewController == nil) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowlayout.itemSize = CGSizeMake(50, 70);
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.minimumLineSpacing = 20;
        
        _recommendUserCollectionViewController = [[RecommendUserCollectionViewController alloc] initWithCollectionViewLayout:flowlayout];
    }
    return _recommendUserCollectionViewController;
}


- (HomeDataViewModal *)homeDataViewModal {
    if(_homeDataViewModal == nil) {
        _homeDataViewModal = [[HomeDataViewModal alloc] init];
    }
    return _homeDataViewModal;
}


#pragma mark - UI 处理
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lightGrayColor];

    
    // 1. 添加子控件
    [self setupUI];
    
    // 2.添加刷新控件
     __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    header.backgroundColor = [UIColor lightGrayColor];
    self.tableView.mj_header = header;
    [header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    self.tableView.mj_footer = footer;
    footer.triggerAutomaticallyRefreshPercent = 0.3;
    footer.hidden = YES;
    
    // 3.注册cell
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RecommendUserCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ButtonTableViewCell class]) bundle:nil] forCellReuseIdentifier:ButtonTableViewCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChuShuoNormalCell class]) bundle:nil] forCellReuseIdentifier:ChuShuoNormalCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChuShuoVideoCell class]) bundle:nil] forCellReuseIdentifier:ChuShuoVideoCellId];
    
}

- (void)loadNewData {
    // 2.请求数据
//    NSLog(@"-------%@", [NSDate date]);
    __weak typeof(self) weakSelf = self;

    [self.homeDataViewModal requestDifferentHomeData:^{ // 请求数据成功
        // 2.1.设置头部视图无限轮播的数据
        weakSelf.headerCircleView.imageNames = weakSelf.homeDataViewModal.bannerImageNames;
    
        // 2.2.刷新数据
        
        [weakSelf.tableView reloadData];
        
        // 隐藏刷新控件
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.tableView.mj_footer.hidden = NO;
    } error:^(NSError * _Nonnull error) {
        if ([error.domain  isEqual: @"noNewData"]) {
            NSLog(@"没有新数据");
        }
        // 隐藏刷新控件
        [weakSelf.tableView.mj_header endRefreshing];
        NSLog(@"请求失败，请检查网络 原因");
        weakSelf.tableView.mj_footer.hidden = NO;
    }];
}

- (void)loadMoreData {
    __weak typeof(self) weakSelf = self;
    [self.homeDataViewModal requestDifferentdataFilishBack:^(BOOL isSuccess) {
        if (isSuccess) {

            [self.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        
    } isPullDown:NO];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.customNavBar.hidden = NO;
    
    [SDImageCache sharedImageCache].maxMemoryCountLimit = 25;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.customNavBar.hidden = YES;
    
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - 添加子控件
- (void)setupUI {
    // 1.添加无限滚动为headerView
    CGFloat margin = 10;
    CGFloat leftRightMargin = 30;
    CGFloat imageViewWith = [UIScreen mainScreen].bounds.size.width - leftRightMargin * 2 - margin;
    CGFloat imageViewHeight = floor(imageViewWith * (608 / 1080.0));
    CGSize imageViewSize = CGSizeMake(imageViewWith, imageViewHeight);
    
    // circle的容量视图的frame
    CGRect frame = CGRectMake(0, 64, CWScreenW, imageViewHeight+ 20);
    UIView *heaerView = [[UIView alloc] initWithFrame:frame];
    CWCircleView *circleView = [[CWCircleView alloc] initWithFrame:CGRectInset(heaerView.bounds, 0, margin)];
    self.headerCircleView = circleView;
    [circleView showIndicater:YES];
    circleView.imageViewSize = imageViewSize;
    [heaerView addSubview:circleView];
    
    heaerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = heaerView;
    
    // 处理点击事件block
    self.headerCircleView.handlePictureClickedBlock = ^(NSInteger index) {
        NSLog(@"第%zd张图片被点击了", index);
    };
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 + self.homeDataViewModal.chuShuos.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) { // button
        ButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ButtonTableViewCellId];

        // 传递数据
        cell.buttons = self.homeDataViewModal.buttonArray;
//        NSLog(@"%p",cell);

        return cell;
    }else if (indexPath.row == 1) { // recommand
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendUserCellId];
        
        self.recommendUserCollectionViewController.view.frame = CGRectMake(0, kCellTopMargin, cell.bounds.size.width, cell.bounds.size.height - kCellTopMargin);
        cell.backgroundColor = [UIColor lightGrayColor];
        
        [cell addSubview:self.recommendUserCollectionViewController.view];
        
        // 传递数据
        self.recommendUserCollectionViewController.recommendUsers = self.homeDataViewModal.recommendUserArray;
        return cell;
    }else {
        
        ChuShuo *chuShuo;
        chuShuo = self.homeDataViewModal.chuShuos[indexPath.row - 2];
        
        if (chuShuo.type == ChuShuoTpyeNormal) {
            ChuShuoNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:ChuShuoNormalCellId];
            return cell;
        }else {
            ChuShuoVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ChuShuoVideoCellId];

            return cell;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ChuShuoNormalCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 1) {
        cell.chuShuo = self.homeDataViewModal.chuShuos[indexPath.row - 2];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 100 + kCellTopMargin;
    }else if (indexPath.row == 1) {
        return 90 +kCellTopMargin;
    }else {
        // 没有数据
        if (self.homeDataViewModal.chuShuos.count <= 0) return 0;
        
        ChuShuo  *chuShuo = self.homeDataViewModal.chuShuos[indexPath.row - 2];
        if (chuShuo.type == ChuShuoTpyeNormal) {
            return 160 + kCellTopMargin;
        }else {
            if (chuShuo.desc.length <= 0) {
                return 250 + kCellTopMargin;
            }else return 285 + kCellTopMargin;
        }
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"第二页";
    vc.view.backgroundColor = [UIColor redColor];
    
    [self.navigationController pushViewController:vc animated:YES];

    [tableView reloadData];
}

/** 定时器别停了 */
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.headerCircleView stopTimer];
//}


@end
