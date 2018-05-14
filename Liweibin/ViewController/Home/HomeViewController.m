//
//  HomeViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navTitle = @"首页";
    
    
    
    NSLog(@"uid = %@", AppManger.user.uid);
    NSLog(@"key = %@", AppManger.user.key);
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(100, 100, 222, 55);
    share.backgroundColor = [UIColor redColor];
    [share setTitle:@"share" forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
    
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(100, 200, 222, 55);
    login.backgroundColor = [UIColor redColor];
    [login setTitle:@"login" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
//    [self loginBtn];
}

- (void)loginBtn {
    [[NSNotificationCenter defaultCenter] postNotificationName:AppManger.common.noticeShowLogin object:self userInfo:nil];
}

- (void)shareBtn {

    [WBShare showShareViewWithTitle:@"倍速课堂"
                               desc:@"倍速课堂-万向思维,科学备考"
                           imageUrl:@"http://beisu-js.oss-cn-beijing.aliyuncs.com/lib/img/share_icon.png"
                             webUrl:AppManger.common.shareUrl
                     viewController:self];
}

- (void)UMSocialShareMenuViewDidAppear {
    NSLog(@"UMSocialShareMenuViewDidAppear11111");
}
- (void)UMSocialShareMenuViewDidDisappear {
    NSLog(@"UMSocialShareMenuViewDidDisappear2222");
}
@end
