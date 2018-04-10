//
//  Common.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#ifndef Common_h
#define Common_h

#import "WBTools.h"

#import "AppDelegate.h"
#import "WBBaseViewController.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "WBTools.h"
#import "WBAlertView.h"
#import "WBCache.h"

#define WBUserID            [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_ID]]
#define WBUserKey           [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_Key]]
#define WBUserPhone         [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_Phone]]
#define WBUserGrade         [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_Grade]]
#define WBUserGradeID       [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_GradeID]]
#define WBUserInviteCode    [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_InviteCode]]
#define WBUserName          [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_Name]]
#define WBUserIcon          [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_Icon]]
#define WBUserToken         [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:User_Token]]

//key
#define User_ID             @"User_ID"
#define User_Key            @"User_Key"
#define User_Phone          @"User_Phone"
#define User_Grade          @"User_Grade"
#define User_GradeID        @"User_GradeID"
#define User_InviteCode     @"User_InviteCode"
#define User_JumpCode       @"User_JumpCode"
#define User_Name           @"User_Name"
#define User_Icon           @"User_Icon"
#define User_Token          @"User_Token"


//通知
#define Notice_ShowLogin        @"Notice_ShowLogin"     //弹出登录页面
#define Notice_LoginSuccess     @"LoginSuccess"         //登录成功
#define Pay_Success             @"Pay_Success"          //支付成功

#define WBString(str)   [NSString stringWithFormat:@"%@",str]

#define NoLogin         ((WBUserKey.length < 10) || (WBUserID.length == 0) || ([WBUserID rangeOfString:@"null"].location != NSNotFound))



#define WBDefaultColor      [WBTools colorWithHexValue:0xFFA340]  //默认主题颜色
#define WBBackgroundColor   [WBTools colorWithHexValue:0xEFF0F1]  //视图背景色

//
#define WBFit(value)        ((value)/414.0f*[UIScreen mainScreen].bounds.size.width)
#define WBFont(font)        [UIFont systemFontOfSize:WBFit(font)]
#define WBFontBold(font)    [UIFont boldSystemFontOfSize:WBFit(font)]

//适配 6P为基准414.0f
#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height

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
