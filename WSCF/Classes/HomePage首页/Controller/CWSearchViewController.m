//
//  CWSearchViewController.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/9/22.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWSearchViewController.h"
#import "CWHistorySeachRecordScrollView.h"
#import "CWHSRTitleView.h"



NSString  *const SearchVCCollectionCellReuseID = @"SearchVCCollectionCellReuseID";
NSString  *const SectionHeaderReuseID = @"SectionHeaderReuseID";
NSString  *const SectionFooterReuseID = @"SectionFooterReuseID";
/** 历史搜索view的高度 */
CGFloat const kHistoryViewH = 40;


@interface CWSearchViewController ()<UISearchBarDelegate>
/** 第一次进入界面 */
@property (assign, nonatomic)  BOOL isFirstIn;
/** 搜索历史数据 */
@property (strong, nonatomic) NSArray *hisRecoreds;
@end

@implementation CWSearchViewController

#pragma mark - 懒加载
- (NSArray *)hisRecoreds {
    if (_hisRecoreds == nil) {
        _hisRecoreds = @[@"一一一", @"二二二]", @"三三三", @"四四四四", @"四四",  @"夺地", @"雅兴中国", @"5在中一中国的天下", @"在城城", @"夺一本要不",@"人2四"];
    }
    return _hisRecoreds;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1.添加子控件
    [self setupUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置导航栏
    [self setupNav];
    
    _isFirstIn = YES;
    
}

- (void)setupUI {
    // 1.添加"历史搜索"按钮
    CWHSRTitleView *historyView = [[CWHSRTitleView alloc] init];
    historyView.frame = CGRectMake(0, 20 + 44, [UIScreen mainScreen].bounds.size.width, kHistoryViewH);
    [self.view addSubview:historyView];
    
    // 2. 添加展示“历史搜索button”的scrollView
    CWHistorySeachRecordScrollView *scrollView = [[CWHistorySeachRecordScrollView alloc] init];
    [self.view insertSubview:scrollView atIndex:0];
    scrollView.frame = CGRectMake(0, CGRectGetMaxY(historyView.frame), historyView.frame.size.width, self.view.bounds.size.height - CGRectGetMaxY(historyView.frame));
    
    scrollView.alwaysBounceVertical = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    
    // 2.1传递数据
    scrollView.hisRecoreds = self.hisRecoreds;
}

- (void)setupNav {
    // 1.添加导航栏右边取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.navigationController.navigationBar addSubview:cancelBtn];
    [cancelBtn sizeToFit];
    cancelBtn.frame = CGRectMake(self.navigationController.navigationBar.bounds.size.width - 10 - cancelBtn.bounds.size.width, (self.navigationController.navigationBar.bounds.size.height - cancelBtn.bounds.size.height) * 0.5, cancelBtn.bounds.size.width, cancelBtn.bounds.size.height);
    
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    // 2.添加导航栏左边搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜菜名/食材/厨友";
    searchBar.searchTextPositionAdjustment = UIOffsetMake(5, 0);
    
    searchBar.frame = CGRectMake(20, (self.navigationController.navigationBar.bounds.size.height - 30) * 0.5, self.navigationController.navigationBar.bounds.size.width - 20 - 10 - 10 - cancelBtn.bounds.size.width, 30);
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"activity_end_52x27_"] forState:UIControlStateNormal];
    
    // 默认一进来就处于编辑状态
    for (UIView *subView in searchBar.subviews[0].subviews) {
        if ([[subView class] isSubclassOfClass:[UITextField class]]) {
            [subView becomeFirstResponder];
        }
    }
    // 2.1 设置代理
    searchBar.delegate = self;
    
    [self.navigationController.navigationBar addSubview:searchBar];
}

- (void)cancel {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

@end
