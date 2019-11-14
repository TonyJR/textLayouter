//
//  ViewController.m
//  OpenTypeJS
//
//  Created by Tony on 19/11/3.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController (){
}
    
@property (nonatomic,strong) WKWebView *webView;
    
@end

@implementation ViewController
    
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i =0; i<10; i++) {
        WKWebView *webview = [[WKWebView alloc] init];
        [webview.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]]]];
        //    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://opentype.js.org"]]];
        CGRect rect = self.view.bounds;
        rect.origin.y = i * 100;
        rect.size.height = 100;
        webview.frame = rect;
        [self.view addSubview:webview];
    }
    
    
    
}
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
#pragma mark - Getter
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        [_webView.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    }
    return _webView;
}
    
@end
