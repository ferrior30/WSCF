//
//  ShopViewController.m
//  WSCHUFANG
//
//  Created by ChenWei on 16/10/13.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "ShopViewController.h"
#import <WebKit/WebKit.h>

@interface ShopViewController ()<WKNavigationDelegate, WKUIDelegate>
@property (weak, nonatomic) WKWebView *webView;
@property (assign, nonatomic) BOOL isFirstEnter;
@property (strong, nonatomic) NSURL *URL;
@end

@implementation ShopViewController

+ (instancetype)showViewControllerWithURL:(NSURL *)URL isFirstEnter:(BOOL)isFirstEnter {
    ShopViewController *vc = [[ShopViewController alloc] init];
    vc.isFirstEnter = isFirstEnter;
    vc.URL = URL;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    WKWebView *wk = [[WKWebView alloc] init];
    wk.frame = self.view.bounds;
    [self.view addSubview:wk];
    self.webView = wk;
    
    [wk loadRequest:[NSURLRequest requestWithURL:self.URL]];
    
    wk.scrollView.bounces = NO;
    wk.navigationDelegate = self;
    wk.UIDelegate = self;
    
    _isFirstEnter = YES;
    
    //
    [self setupRightNavigationBar];
}

#pragma mark - 安装导航栏右边的登陆NavigationBar
- (void)setupRightNavigationBar {
//    UINavigationItem
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_shop_mine"] style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    [self.navigationItem setRightBarButtonItem:item];
}

#pragma mark - 内部方法
/** 登陆 */
- (void)login {
    NSLog(@"%s", __func__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if (_isFirstEnter) {
        decisionHandler(WKNavigationActionPolicyAllow);
        _isFirstEnter = NO;
    }else {
    
        NSLog(@"navigationAction.request.URL.absoluteString = %@",navigationAction.request.URL.absoluteString);
        if([navigationAction.request.URL.host isEqualToString:@"mall.ecook.cn"]){
            decisionHandler(WKNavigationActionPolicyAllow);
            
            ShopViewController *pwVC = [ShopViewController showViewControllerWithURL:navigationAction.request.URL isFirstEnter:YES];
            pwVC.hidesBottomBarWhenPushed = YES;
           
            [self.navigationController pushViewController:pwVC animated:YES];
            
        }else {
            decisionHandler(WKNavigationActionPolicyCancel);
        }
    }
    
}

@end
