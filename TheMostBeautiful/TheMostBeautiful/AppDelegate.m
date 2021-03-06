//
//  AppDelegate.m
//  TheMostBeautiful
//
//  Created by Tony on 19/11/17.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import <TONetwork.h>

@interface AppDelegate ()

@property (nonatomic,strong)UINavigationController *root;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];

    self.window.rootViewController = self.root;
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    
    progressListenTo([TONetwork sharedNetwork],message);
    
    tipListenTo([TONetwork sharedNetwork],tip);


    return YES;
}

- (UINavigationController *)root{
    if (!_root) {
        _root = [UINavigationController new];
        _root.navigationBarHidden = YES;
        _root.viewControllers = @[[IndexViewController indexViewController]];
    }
    return _root;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
