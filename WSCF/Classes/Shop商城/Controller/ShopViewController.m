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
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    WKWebView *wk = [[WKWebView alloc] init];
    wk.frame = self.view.bounds;
    [self.view addSubview:wk];
    self.webView = wk;
    
    [wk loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mall.ecook.cn/category/list?f=ecook_show_mine&machine=Oe465ee7d2c21f604916deace6307de8014615245"]]];
    wk.scrollView.bounces = NO;
    wk.navigationDelegate = self;
    wk.UIDelegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {

}

- (UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id<WKPreviewActionItem>> *)previewActions {
    return self;
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {

}

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
////    if ([webView.URL.absoluteString  isEqual: @"http://mall.ecook.cn/category/list?f=ecook_show_mine&machine=Oe465ee7d2c21f604916deace6307de8014615245"] ) {
////        return;
////    }
//    UIViewController *v = [[UIViewController alloc] init];
//    WKWebView *wk = [[WKWebView alloc] init];
//    wk.frame = v.view.bounds;
//    [wk loadRequest:[NSURLRequest requestWithURL:webView.URL]];
//    [v.view addSubview:wk];
//    
//    [self.navigationController pushViewController:v animated:YES];
//}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    

//    [webView loadRequest:[NSURLRequest requestWithURL:webView.URL]];
    UIViewController *v = [[UIViewController alloc] init];
    WKWebView *wk = [[WKWebView alloc] init];
    wk.frame = v.view.bounds;
    [wk loadRequest:[NSURLRequest requestWithURL:webView.URL]];
    [v.view addSubview:wk];
    
    [self.navigationController pushViewController:v animated:YES];
}


@end
