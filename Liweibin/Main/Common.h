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
#import "WBNetwork.h"
#import "WBShare.h"

#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

#define WBString(str)       [NSString stringWithFormat:@"%@",str]   //转为字符串
#define WBInteger(str)  [WBString(str) integerValue]

#define WBFit(value)        ((value)/414.f*[[UIScreen mainScreen] bounds].size.width)   //适配 6P为基准414.0f
#define WBFont(font)        [UIFont systemFontOfSize:WBFit(font)]
#define WBFontBold(font)    [UIFont boldSystemFontOfSize:WBFit(font)]




#ifdef  DEBUG
#define NSLog(FORMAT, ...)  NSLog(@"line:%d,   log:   %@ ",__LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
#else
#define NSLog(FORMAT, ...)  nil
#endif


#endif /* Common_h */
