//
//  AppDelegate.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBModel.h"

#define AppShared [AppDelegate sharedManger]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedManger;

//用户信息模型
@property (nonatomic, strong) WBUser *user;



//关闭启动页广告背景
- (void)dismissCustomLaunchImage;



@end

