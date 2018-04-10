//
//  AppDelegate.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "PersonViewController.h"
#import "WBTabbarViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)manager {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    WBTabbarViewController *tabbar = [[WBTabbarViewController alloc] init];
    self.window.rootViewController = tabbar;
    
    //设置数字角标
    [tabbar showBadgeMark:8 index:0];
    //设置小红点
    [tabbar showPointMarkIndex:1];
    //不显示角标
    //[tabbar hideMarkIndex:3];

    return YES;
}


//缓存用户信息
- (void)saveUserInfo:(NSDictionary *)info {
    
}
//退出/异地登录,清空缓存信息
- (void)loginOut {
    
}

//关闭启动页广告背景
- (void)dismissCustomLaunchImage {
    
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
