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

#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate () <JPUSHRegisterDelegate>

@end

@implementation AppDelegate

+ (AppDelegate *)sharedManger {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.common = [[WBCommonModel alloc] init];
    [self.common initCommonParam];
    
    self.network = [[WBNetworkModel alloc] init];
    [self.network initNetworkInterface];
    
    WBTabbarViewController *tabbar = [[WBTabbarViewController alloc] init];
    self.window.rootViewController = tabbar;
    
    //设置数字角标
    [tabbar showBadgeMark:8 index:0];
    //设置小红点
    [tabbar showPointMarkIndex:1];
    //不显示角标
    [tabbar hideMarkIndex:3];

    
    //读取用户信息
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:@"user"];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.user = [WBUserModel modelWithKeyValues:dict];
    }


    [self initUMengShare];
    [self initJPushWith:launchOptions];

    return YES;
}



//关闭启动页广告背景
- (void)dismissCustomLaunchImage {
    
}

- (void)saveUserInfo:(NSDictionary *)info {
    
    self.user = [WBUserModel modelWithKeyValues:info];

    NSData *data = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user"];
    
    [JPUSHService setAlias:[NSString stringWithFormat:@"beisu_%@", self.user.uid]
                completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    NSLog(@"iResCode = %ld, \n seq = %ld, \n iAlias =　%@", iResCode, seq, iAlias);
                } seq:111];
}

- (void)loginOut {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"user"];
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

#pragma mark - 极光
- (void)initJPushWith:(NSDictionary *)launchOptions {

    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    [JPUSHService setupWithOption:launchOptions
                           appKey:self.common.JPushAppKey
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
    
    // 用户注册时发给服务器
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    self.common.deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [self receiveJPushNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    [JPUSHService handleRemoteNotification:userInfo];
    [self receiveJPushNotification:userInfo];
}

// 收到推送, 显示角标, 跳转控制器
- (void)receiveJPushNotification:(NSDictionary *)userInfo {

    if (WBInteger(userInfo[@"kind"]) == 2) {
        //网页推送时直接进入webview
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveJPushWeb" object:self userInfo:userInfo];
    } else {
        //系统消息推送时显示角标
    }
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
