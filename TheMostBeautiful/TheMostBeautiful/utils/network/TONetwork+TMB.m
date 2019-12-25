//
//  TONetwork+TMB.m
//  TheMostBeautiful
//
//  Created by TonyJR on 2019/11/20.
//  Copyright © 2019年 Tony. All rights reserved.
//
#import "TONetwork+TMB.h"
#import <TouchJSON/CJSONDeserializer.h>
#import <objc/runtime.h>
//#import <DDLogger.h>
#import "TipManager.h"

@implementation TONetwork (SQ)

- (void)setStartTime:(NSDate *)date{
    objc_setAssociatedObject(self, "startTime", date, OBJC_ASSOCIATION_COPY);
}

- (NSDate *)startTime{
    return objc_getAssociatedObject(self, "startTime");
}



//类别中扩展属性
//如需在请求时特殊处理，请使用类别覆盖下面三个方法
//返回值将决定是否通知owner
-(BOOL)afterTask:(TOTask *) task
{
    
    task.responseInfo = nil;

    [self.threadTasks removeObject:task];
    if (task.responseStatusCode == 200) {
        
        NSError *error = nil;
        
        NSDictionary *responseDic = [[CJSONDeserializer deserializer] deserialize:task.responseData error:&error];
        
        
        if (!responseDic || (![responseDic isKindOfClass:[NSDictionary class]])) {
            
            if (task.needTip) {
                [TipManager showTip:@"请求失败"];
            }
            if ([task.path rangeOfString:@"login"].location == NSNotFound) {
//                DDLogWarn(@"\n---数据解析失败---\n请求时间%f \n%@\n请求参数>>>\n%@\n<<<\n返回结果>>>\n%@\n<<<",[[self startTime] timeIntervalSinceNow],task.path,task.parames,task.responseString);
            }
            task.responseInfo = @{};
            task.error = error;
            return NO;
            
        }
        
        task.responseInfo = responseDic;
        
        if ([task.path rangeOfString:@"login"].location == NSNotFound) {
//            DDLogInfo(@"\n---请求成功---\n请求时间%f\n%@\n请求参数>>>\n%@\n<<<\n返回结果>>>\n%@\n<<<",[[self startTime] timeIntervalSinceNow],task.path,task.parames,task.responseInfo);
        }
        int resultCode = [task.responseInfo[@"state"] intValue];
        
        if (resultCode == 0) {
            return YES;
        }else{
            NSString *errorMessage = task.responseInfo[@"message"];
            if ([errorMessage length] > 0) {
                task.error = [NSError errorWithDomain:NSNetServicesErrorCode code:resultCode userInfo:task.responseInfo];
                if (task.needTip) {
                    [TipManager showTip:errorMessage];
                }
            }else{
                if (task.needTip) {
                    [TipManager showTip:@"服务器错误"];
                }
            }
            
            return NO;
        }
        
    }else {
        
        NSError * error = nil;
        
        NSDictionary *responseDic = [[CJSONDeserializer deserializer] deserialize:task.responseData error:&error];
        
        if (responseDic) {
            task.responseInfo = responseDic;
            NSString *errorMessage = task.responseInfo[@"message"];
            if ([errorMessage length] > 0) {
                if (task.needTip) {
                    [TipManager showTip:errorMessage];
                }
            }else{
                if (task.needTip) {
                    [TipManager showTip:@"请求失败"];
                }
            }
        }else{
            task.responseInfo = @{};
            if (task.needTip) {
                [TipManager showTip:@"请求失败"];
            }
        }
       
        if ([task.path rangeOfString:@"login"].location == NSNotFound) {
//            DDLogWarn(@"\n---请求失败---\n请求时间%f\n%@\n请求参数>>>\n%@\n<<<\n返回结果>>>\n%@\n<<<",[[self startTime] timeIntervalSinceNow],task.path,task.parames,task.responseString);
            
        }
        
        return NO;
    }
}

- (void)beforeTask:(TOTask *)task{
    [self setStartTime:[NSDate date]];
    if ([task.tipMessage length] == 0) {
        task.tipMessage = @"加载中...";
    }
}

@end
