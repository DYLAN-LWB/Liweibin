//
//  Common.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#ifndef Common_h
#define Common_h


#import "AppDelegate.h"
#import "WBBaseViewController.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "WBTools.h"
#import "WBAlertView.h"
#import "RequestManager.h"

#define WBString(str)   [NSString stringWithFormat:@"%@",str]   //转为字符串

#define WBDefaultColor      [UIColor colorWithRed:255/255.f green:163/255.f blue:64/255.f alpha:1.f]    //默认主题颜色
#define WBBackgroundColor   [UIColor colorWithRed:239/255.f green:240/255.f blue:241/255.f alpha:1.f]   //视图背景色

#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width   //屏幕宽高
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height

#define WBFit(value)        ((value)/414.f*SCREEN_WIDTH)   //适配 6P为基准414.0f
#define WBFont(font)        [UIFont systemFontOfSize:WBFit(font)]
#define WBFontBold(font)    [UIFont boldSystemFontOfSize:WBFit(font)]

#define SCREEN_35 ([UIScreen mainScreen].bounds.size.height == 480.f)    //320 480   @2x
#define SCREEN_40 ([UIScreen mainScreen].bounds.size.height == 568.f)    //320 568   @2x
#define SCREEN_47 ([UIScreen mainScreen].bounds.size.height == 667.f)    //375 667   @2x
#define SCREEN_55 ([UIScreen mainScreen].bounds.size.height == 736.f)    //414 736   @3x
#define SCREEN_58 ([UIScreen mainScreen].bounds.size.height == 812.f)    //375 812   @3x

#define NAV_H   (SCREEN_58 ? 88 : 64)    //navbar高度
#define TAB_H   (SCREEN_58 ? 83 : 49)    //tabbar高度, tabbar主页面高度需要减去NAV_H和TAB_H
#define SUB_H   (SCREEN_58 ? 34 : 0)     //子页面需要减去NAV_H和SUB_H

#ifdef  DEBUG
#define NSLog(FORMAT, ...)  NSLog(@"line:%d,   log:   %@ ",__LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
#else
#define NSLog(FORMAT, ...)  nil
#endif


#endif /* Common_h */
