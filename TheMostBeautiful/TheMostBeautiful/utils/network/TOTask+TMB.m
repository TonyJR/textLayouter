//
//  TOTask+TMB.m
//  TheMostBeautiful
//
//  Created by TonyJR on 2019/11/20.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "TOTask+TMB.h"
#import "TMBHTTPHelper.h"
#import <TONetworking/TOTaskConfig.h>
#import <objc/runtime.h>

@interface TOTask()
{
    Class<TOTaskHelper> _taskHelper;
}

@end



@implementation TOTask (TMB)

- (void)setHttpTask:(NSURLSessionDataTask *)httpTask{
    objc_setAssociatedObject(self, @"TOTask_HTTPTask", httpTask, OBJC_ASSOCIATION_ASSIGN);
}

- (NSURLSessionDataTask *)httpTask{
    return objc_getAssociatedObject(self, @"TOTask_HTTPTask");
}


+ (void)initialize{
    if (!g_default_task_helper) {
        g_default_task_helper = [TMBHTTPHelper class];
    }
}

- (Class<TOTaskHelper>)taskHelper{
    if (!_taskHelper) {
        return g_default_task_helper;
    }else{
        return _taskHelper;
    }
}



- (int)resultCode{
    if ([self.responseInfo isKindOfClass:[NSDictionary class]]) {
        return [self.responseInfo[@"resultCode"] intValue];
    }else{
        return self.responseStatusCode;
    }
}

- (int)errorCode{
    if ([self.responseInfo isKindOfClass:[NSDictionary class]]) {
        return [self.responseInfo[@"errorCode"] intValue];
    }else{
        return self.responseStatusCode;
    }
}

- (NSDate *)startTime{
    return objc_getAssociatedObject(self, @selector(startTime));
}


- (void)setStartTime:(NSDate *)startTime{
    objc_setAssociatedObject(self, @selector(startTime), startTime,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSHTTPURLResponse *)response{
    return objc_getAssociatedObject(self,@selector(response));
}

- (void)setResponse:(NSHTTPURLResponse *)response{
    objc_setAssociatedObject(self, @selector(response), response,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSURLRequest *)request{
    return objc_getAssociatedObject(self,@selector(request));
}

- (void)setRequest:(NSURLRequest *)request{
    objc_setAssociatedObject(self, @selector(request), request,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)dealloc{
    
}

@end
