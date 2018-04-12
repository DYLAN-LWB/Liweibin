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

+ (AppDelegate *)sharedManger {
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

    
    //读取用户信息
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[ud objectForKey:@"user"]
                                                         options:NSJSONReadingMutableLeaves
                                                           error:nil];
    self.user = [WBUser modelWithKeyValues:dict];
    
    NSLog(@"uid = %@", self.user.uid);
    NSLog(@"key = %@", self.user.key);
    
    return YES;
}


//关闭启动页广告背景
- (void)dismissCustomLaunchImage {
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
