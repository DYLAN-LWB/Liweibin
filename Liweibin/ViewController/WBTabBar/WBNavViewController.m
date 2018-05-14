//
//  WBNavViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/14.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBNavViewController.h"

@interface WBNavViewController ()

@end

@implementation WBNavViewController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
