//
//  TipManager.m
//  Test2
//
//  Created by David on 15/7/29.
//  Copyright (c) 2015年 Jovision. All rights reserved.
//

#import "TipManager.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation TipManager{
    MBProgressHUD * _progressTip;
    RACDisposable * dispose;
    NSString * lastTip;
}

static TipManager * _sharedManager;



+(instancetype)sharedManager{
    if (!_sharedManager) {
        _sharedManager = [[TipManager alloc] init];
    }
    return _sharedManager;
}

-(void)showProgress:(NSString *) progressMessage{
    
    lastTip = progressMessage;
    
    [self showProgressThread:progressMessage];
}

-(void)showProgressThread:(NSString *) progressMessage{
    if ([NSThread isMainThread]) {
        [self showProgressMainThread:progressMessage];
    }else{
        [self performSelectorOnMainThread:@selector(showProgressMainThread:) withObject:progressMessage waitUntilDone:YES];
    }
}

-(void)showProgressMainThread:(NSString *)progressMessage{
    if (dispose) {
        [dispose dispose];
        dispose = nil;
    }
    
    if ([progressMessage isEqual:[NSNull null]]) {
        progressMessage = nil;
    }
    
    
    if (!progressMessage) {
        progressMessage = self.forceTip;
    }
    
    if (progressMessage) {
        self.progressTip.label.text = progressMessage;
        [[UIApplication sharedApplication].keyWindow addSubview:self.progressTip];
        [self.progressTip showAnimated:NO];
        [(UIImageView *)self.progressTip.customView startAnimating];
    }else{
         dispose = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
             
             [subscriber sendCompleted];
             return nil;
            

        }] delay:0.1] subscribeCompleted:^{
            [self.progressTip hideAnimated:NO];
        }];
        [(UIImageView *)self.progressTip.customView stopAnimating];

    }
}

+(void)showTip:(NSString *)tipMessage{
    [[self sharedManager] performSelectorOnMainThread:@selector(showTipThread:) withObject:tipMessage waitUntilDone:NO];
}

-(void)showTipThread:(NSString *)tipMessage{
    
    
    if (!tipMessage || tipMessage.length == 0) {
        return;
    }
    
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    

    
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.offset = CGPointMake(0, window.frame.size.height/2 - 100);
    
    HUD.label.text = tipMessage;
    HUD.label.numberOfLines = 3;
    HUD.dimBackground = NO;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.userInteractionEnabled = NO;
    HUD.animationType = MBProgressHUDAnimationZoom;
    [window addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:3];
}

+(void)debugTip:(NSString *) tipMessage{
    //[self showTip:tipMessage];
}

-(MBProgressHUD *)progressTip{
    if (!_progressTip) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        
        if (window) {
            _progressTip = [[MBProgressHUD alloc] initWithView:window];
            _progressTip.label.text = @"正在加载";
            _progressTip.mode = MBProgressHUDModeCustomView;
            
//            NSArray *images = @[
//                                [UIImage imageNamed:@"loading1"],
//                                [UIImage imageNamed:@"loading2"],
//                                [UIImage imageNamed:@"loading3"],
//                                [UIImage imageNamed:@"loading4"],
//                                [UIImage imageNamed:@"loading5"],
//                                [UIImage imageNamed:@"loading6"],
//                                
//                                ];
//            UIImageView *imgView = [[UIImageView alloc] initWithImage:images.firstObject];
//            [imgView setAnimationImages:images];
//            [imgView setAnimationDuration:1];
//            [imgView startAnimating];
//            _progressTip.customView = imgView;
            _progressTip.removeFromSuperViewOnHide = YES;
            _progressTip.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
            _progressTip.label.textColor = [UIColor darkGrayColor];
            _progressTip.bezelView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
            [window addSubview:_progressTip];
        }
    }
    
    return _progressTip;
}

-(void)setForceTip:(NSString *)forceTip{
    _forceTip = forceTip;
    if (forceTip) {
        [self showProgressThread:forceTip];
    }else{
        [self showProgressThread:lastTip];
    }
}

@end
