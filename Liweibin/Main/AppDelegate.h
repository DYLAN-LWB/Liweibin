//
//  AppDelegate.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)manager;

@property (nonatomic, assign) BOOL isShowingAd;
@property (nonatomic, assign) BOOL isShowingGuide;

@property (nonatomic, assign) BOOL adLoadSuccess;
@property (nonatomic, assign) BOOL isTaped;

//缓存用户信息
- (void)saveUserInfo:(NSDictionary *)info;
//退出/异地登录,清空缓存信息
- (void)loginOut;

//关闭启动页广告背景
- (void)dismissCustomLaunchImage;

@end

