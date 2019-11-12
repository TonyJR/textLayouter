//
//  ViewController.m
//  OpenTypeJS
//
//  Created by Tony on 19/11/3.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "ViewController.h"


@interface ViewController (){
}
    
@property (nonatomic,strong) UIWebView *webView;
    
@end

@implementation ViewController
    
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]]]];
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
}
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
#pragma mark - Getter
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}
    
@end
