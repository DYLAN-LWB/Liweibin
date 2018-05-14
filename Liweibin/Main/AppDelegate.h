//
//  AppDelegate.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBTabbarViewController.h"
#import "WBCommonModel.h"
#import "WBModel.h"
#import "WBUserModel.h"
#import "WBNetworkModel.h"

#define AppManger [AppDelegate sharedManger]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedManger;

@property (nonatomic, strong) WBTabbarViewController *tabbar;
//用户信息表
@property (nonatomic, strong) WBUserModel *user;
//公共信息表
@property (nonatomic, strong) WBCommonModel *common;
//网络接口表
@property (nonatomic, strong) WBNetworkModel *network;

//关闭启动页广告背景
- (void)dismissCustomLaunchImage;

- (void)saveUserInfo:(NSDictionary *)info;
- (void)loginOut;

@end

