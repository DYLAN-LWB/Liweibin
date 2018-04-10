//
//  WBTabbarViewController.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBTabbarButton.h"


@class WBTabbarViewController;
@protocol WBTabBarDelegate <NSObject>
@optional

/** tabBar 点击事件回调 */
-(void)WBTabBar:(WBTabbarViewController *)tabBar didSelectViewController:(UIViewController *)viewController;

@end

@interface WBTabbarViewController : UITabBarController

@property(nonatomic,assign) id<WBTabBarDelegate>delegate;

/*
 隐藏TabBar 调用系统方法
 VC.hidesBottomBarWhenPushed = YES;
 */

/** 设置tabBar显示指定控制器 */
-(void)showViewController:(NSInteger)index;

/** 数字角标 */
-(void)showBadgeMark:(NSInteger)badge index:(NSInteger)index;

/** 小红点 */
-(void)showPointMarkIndex:(NSInteger)index;

/** 隐藏指定位置角标 */
-(void)hideMarkIndex:(NSInteger)index;

@end
