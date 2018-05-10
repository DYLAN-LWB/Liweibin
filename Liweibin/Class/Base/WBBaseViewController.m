//
//  WBBaseViewController.m
//  Beisu
//
//  Created by 李伟宾 on 16/5/10.
//  Copyright © 2016年 李伟宾. All rights reserved.
//

#import "WBBaseViewController.h"

@interface WBBaseViewController ()

@property (nonatomic, copy) NSString *VCClass;
@property (nonatomic, strong) UILabel *navTitleLabel;
@property (nonatomic, strong) UISwipeGestureRecognizer *recognizer;
@end

@implementation WBBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏系统nav
    self.navigationController.navigationBarHidden = YES;
    
    
    if ([self.VCClass isEqualToString:@"HomeViewController"]
        || [self.VCClass isEqualToString:@"CourseViewController"]
        || [self.VCClass isEqualToString:@"DiscoverViewController"]
        || [self.VCClass isEqualToString:@"PersonViewController"]) {
        
//        [[AppDelegate networkManger].tabBarController setTabBarHidden:NO];
    }
    
 
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.VCClass isEqualToString:@"HomeViewController"]
        || [self.VCClass isEqualToString:@"CourseViewController"]
        || [self.VCClass isEqualToString:@"DiscoverViewController"]
        || [self.VCClass isEqualToString:@"PersonViewController"]) {
        
//        [[AppDelegate networkManger].tabBarController setTabBarHidden:YES];
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.VCClass = [NSString stringWithFormat:@"%@", self.class];
    self.view.backgroundColor = AppManger.common.defaultBcakgroundColor;
    
    //添加自定义nav视图
    self.navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppManger.common.screenWidth, AppManger.common.navHeight)];
    self.navigationView.backgroundColor = AppManger.common.defaultThemeColor;
    [self.view addSubview:self.navigationView];

    //添加标题
    self.navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WBFit(100), AppManger.common.navHeight-44, AppManger.common.screenWidth-WBFit(200), 44)];
    self.navTitleLabel.textColor = [UIColor whiteColor];
    self.navTitleLabel.font = [UIFont systemFontOfSize:20];
    self.navTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationView addSubview:self.navTitleLabel];
    
    //添加返回按钮
    self.navBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, AppManger.common.navHeight-44, 50, 40)];
    [self.navBackButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.navBackButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    [self.navBackButton setImageEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 5)];
    [self.navBackButton addTarget:self action:@selector(backBarButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:self.navBackButton];
    
    //添加滑动返回手势
    self.recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [self.recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:self.recognizer];
    
    //不需要显示返回按钮的界面
    if ([self.VCClass isEqualToString:@"HomeViewController"]
        || [self.VCClass isEqualToString:@"CourseViewController"]
        || [self.VCClass isEqualToString:@"DiscoverViewController"]
        || [self.VCClass isEqualToString:@"PersonViewController"]
        || [self.VCClass isEqualToString:@"LoginViewController"]
        || [self.VCClass isEqualToString:@"ScanCodeViewController"]) {
        
        [self.navBackButton removeFromSuperview];
        self.navBackButton = nil;
    }
    
    //不需要滑动返回的界面
    if ([self.VCClass isEqualToString:@"LoginViewController"] ||
        [self.VCClass isEqualToString:@"RegisterViewController"] ||
        [self.VCClass isEqualToString:@"ForgetPwdViewController"] ||
        [self.VCClass isEqualToString:@"PlayerViewController"] ||
        [self.VCClass isEqualToString:@"LiveChatViewController"] ||
        [self.VCClass isEqualToString:@"CommodityExchangeDetailController"] ||
        [self.VCClass isEqualToString:@"WBWebViewController"] ||
        [self.VCClass isEqualToString:@"SpeechViewController"] ||
        [self.VCClass isEqualToString:@"SecurityCodeViewController"]) {
        
        [self.recognizer removeTarget:self action:@selector(handleSwipeFrom:)];
    }
}

//右滑返回
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self backBarButtonPressed];
    }
}

//点击返回按钮
- (void)backBarButtonPressed {
    if (self.view.tag == 678) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//避免横屏时出现错误
- (void)viewWillLayoutSubviews {
    self.navigationView.frame = CGRectMake(0, 0, AppManger.common.screenWidth, AppManger.common.navHeight);
    self.navTitleLabel.frame = CGRectMake(WBFit(100), AppManger.common.navHeight-44, AppManger.common.screenWidth-WBFit(200), 44);
}

//设置标题
- (void)setNavTitle:(NSString *)navTitle {
    self.navTitleLabel.text = navTitle;
}

#pragma mark -
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
