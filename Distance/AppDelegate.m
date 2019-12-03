//
//  AppDelegate.m
//  Distance
//
//  Created by 张信涛 on 2019/9/9.
//  Copyright © 2019年 张信涛. All rights reserved.
//

#import "AppDelegate.h"
#import "DisLoginController.h"
#import "MainViewController.h"
#import "DisLocationManager.h"
#import <ShareSDK/ShareSDK.h>
//#import "BGTaskManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    DISStaticObj *obj = [DISStaticObj sharedObj];
    DISUserInfo *info = [DISUserInfo sharedInfo];
    
    obj.loginVC = [[UINavigationController alloc] initWithRootViewController:[[DisLoginController alloc] init]];
    obj.mainVC = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    
    if (info.userid) {
        [self.window setRootViewController:obj.mainVC];
    }else{
        [self.window setRootViewController:obj.loginVC];
    }
    
    [self.window makeKeyAndVisible];
    
    [YTKNetworkConfig sharedConfig].baseUrl = Dis_Api_domain;
    
    [[DisLocationManager sharedManager] beginUpdateLocation];
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformRegister){
        
    }];
    
    
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
        [DisLog Write:@"系统后台唤醒" To:LOG_Weakup];
        // do something，这里就可以再次调用startUpdatingLocation，开启精确定位啦
        //[[DisLocationManager sharedManager] applicationEnterBackground];
        
    }
    
    return YES;
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
    [DisLog Write:@"啊啦啦，被系统杀死了" To:LOG_User];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[DisLocationManager sharedManager] requestLocation];
    [[DisLocationManager sharedManager] uploadLocation];
    [DisLog Write:@"BackgroundFetch of IOS system" To:LOG_Weakup];
    NSLog(@"fetch了 注意了");
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
