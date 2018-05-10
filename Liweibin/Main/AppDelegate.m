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
    
    self.common = [[WBCommon alloc] init];
    [self.common initCommonParam];
    
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
    NSData *data = [ud objectForKey:@"user"];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.user = [WBUser modelWithKeyValues:dict];
    }


    [self initUMengShare];
    
    return YES;
}



//关闭启动页广告背景
- (void)dismissCustomLaunchImage {
    
}



#pragma mark - 友盟
- (void)initUMengShare {
    
    //初始化友盟
    [UMConfigure initWithAppkey:AppManger.common.UMengAppKey channel:@"App Store"];
    
    //关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:AppManger.common.wechatAppKey
                                       appSecret:AppManger.common.wechatAppSecret
                                     redirectURL:AppManger.common.shareUrl];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:AppManger.common.qqAppKey
                                       appSecret:AppManger.common.qqAppSecret
                                     redirectURL:AppManger.common.shareUrl];
  
}

//设置系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        //其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark - appdelegate
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
