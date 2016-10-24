//
//  OnlineLiveTableViewController.m
//  WSCF
//
//  Created by ChenWei on 16/10/22.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "OnlineLiveTableViewController.h"
#import "OnlineLiveCell.h"
#import "NetworkTool.h"
#import <MJRefresh.h>
#import <SDWebImageDownloader.h>
#import <SDWebImageManager.h>

static NSString *OnlineLivCellId = @"OnlineLivCellId";

@interface OnlineLiveTableViewController ()

@end

@implementation OnlineLiveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[OnlineLiveCell class] forCellReuseIdentifier:OnlineLivCellId];
    
    // 加载拉刷新控件
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_header = header;
    [self loadNewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNewData {
    __weak typeof(self) weakSelf = self;
    [[NetworkTool sharManager] POST:@"http://api.ecook.cn/public/getAllOnlineTeachList.shtml" parameters:[NetworkTool sharManager].baseParasDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.OnLineLiveCooks = [OnLineLiveCook mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        OnlineLiveTableViewController *onlineLiveViewController = (OnlineLiveTableViewController *)weakSelf.childViewControllers.firstObject;
        onlineLiveViewController.OnLineLiveCooks = weakSelf.OnLineLiveCooks;
        
        // 下载图片
        [weakSelf downloadImage];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

#pragma mark - 内部方法
/** 下载图片 */
- (void)downloadImage {
    dispatch_group_t group = dispatch_group_create();
    
    for (OnLineLiveCook *cook in self.OnLineLiveCooks) {
        dispatch_group_enter(group);
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:cook.himg] options:kNilOptions progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            cook.himgHeight = ceil(CWScreenW * image.size.height / image.size.width);
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - Property

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.OnLineLiveCooks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OnlineLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:OnlineLivCellId forIndexPath:indexPath];
    
    cell.onlineCook = self.OnLineLiveCooks[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((OnLineLiveCook *)self.OnLineLiveCooks[indexPath.row]).himgHeight + 60;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ((NSInteger)indexPath.row  % 5 == 0) {
//        [SDImageCache sharedImageCache].maxMemoryCountLimit = 30;
//        
//    }else {
////        [SDImageCache sharedImageCache].maxMemoryCountLimit = 50;
//    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView reloadData];
}
@end
