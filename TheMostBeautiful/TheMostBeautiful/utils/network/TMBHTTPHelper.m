//
//  TMBHTTPHelper.m
//  TheMostBeautiful
//
//  Created by TonyJR on 2019/11/20.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "TMBHTTPHelper.h"
#import "TOTask.h"
#import "TOTaskConfig.h"
#import <objc/runtime.h>
#import "TOTask+TMB.h"


#define kVersion                   [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]   //程序版本号
#define kAPPBundleID               @"com.theMostBeautiful.client.ios"
#define KUserAgent                 [NSString stringWithFormat:@"%@/%@",kAPPBundleID,kVersion]  //请求头



@interface TOTask ()
@property (nonatomic,strong) NSMutableDictionary *fileNames;

@end


@implementation TMBHTTPHelper : NSObject


+(void)startTask:(nonnull TOTask *)task
        progress:(nullable void (^)(NSProgress * _Nonnull))progressHandler
        complete:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSData * _Nullable,NSError * _Nullable))completeHandler{
    
    if ([task.method length] == 0) {
        task.method = @"POST";
    }
    
    if ([task.method isEqualToString:@"GET"]) {
        [self doGet:task
           progress:progressHandler
           complete:completeHandler];
    }else if([task.method isEqualToString:@"POST"]){
        [self doPost:task
            progress:progressHandler
            complete:completeHandler];
    }
}

+ (NSURLSession *)session{
    static NSURLSession *_session;
    if (!_session) {
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.HTTPMaximumConnectionsPerHost = 4;
        //        config.timeoutIntervalForRequest = 10;
        //        config.timeoutIntervalForResource = 10;
        //
        _session = [NSURLSession sessionWithConfiguration:config];
        
    }
    return _session;
}

#pragma mark - Request
+ (void)doGet:(nonnull TOTask *)task
     progress:(nullable void (^)(NSProgress * _Nonnull))progressHandler
     complete:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSData * _Nullable,NSError * _Nullable))completeHandler{
    
    NSURLComponents *components = [NSURLComponents componentsWithString:task.path];
    
    NSMutableArray *queryItems = [NSMutableArray array];
    
    NSMutableDictionary *parames = [task.parames mutableCopy];
    [parames setObject:@([NSDate timeIntervalSinceReferenceDate]) forKey:@"sq_rand"];
    
    for (NSString *key in parames.allKeys) {
        id<NSObject> value = parames[key];
        if ([value isKindOfClass:[NSString class]]) {
            [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:(NSString *)value]];
        }else if([value isKindOfClass:[NSNumber class]]){
            [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:[(NSNumber *)value stringValue]]];
        }else if([value isKindOfClass:[NSArray class]]){
            NSArray *arr = (NSArray *)value;
            for (id<NSObject> arrItem in arr) {
                [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:[NSString stringWithFormat:@"%@",arrItem]]];
            }
        }
        
    }
    components.queryItems = queryItems;
    
    NSURL *url = components.URL;
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = task.timeoutInterval;
    request.HTTPMethod = @"GET";
    [request setValue:KUserAgent forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    request.cachePolicy = NSURLCacheStorageNotAllowed;
    
    __block NSURLSessionDataTask *sessionTask;
    sessionTask = [[self session] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (completeHandler) {
            completeHandler(sessionTask,data,error);
        }
        
    }];
    task.httpTask = sessionTask;
    [sessionTask resume];
}

+ (void)doPost:(nonnull TOTask *)task
      progress:(nullable void (^)(NSProgress * _Nonnull))progressHandler
      complete:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSData * _Nullable,NSError * _Nullable))completeHandler{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:task.path]];
    request.timeoutInterval = task.timeoutInterval;
    request.HTTPMethod = @"POST";
    [request setValue:KUserAgent forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (task.parames != nil) {
        NSData* data = [NSJSONSerialization dataWithJSONObject:task.parames options:NSJSONWritingPrettyPrinted error:nil];
        request.HTTPBody = data;
    }
    
    __block NSURLSessionDataTask *sessionTask;
    sessionTask = [[self session] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (completeHandler) {
            completeHandler(sessionTask,data,error);
        }
        
    }];
    task.httpTask = sessionTask;
    [sessionTask resume];
}

+ (void)cancel:(nonnull TOTask *)task{
    if (!task) {
        return;
    }
    [task.httpTask cancel];
}



@end
