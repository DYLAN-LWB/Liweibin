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

#import <UMShare/UMShare.h>

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


- (void)initUMengShare {
    
    //关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:AppManger.common.wechatAppKey
                                       appSecret:AppManger.common.wechatAppSecret
                                     redirectURL:AppManger.common.shareUrl];

    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:AppManger.common.qqAppKey
                                       appSecret:nil
                                     redirectURL:AppManger.common.shareUrl];
  
}
@end
