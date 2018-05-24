//
//  WBWebViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "SecurityUtil.h"
@interface WBWebViewController ()<UIWebViewDelegate>

{
    UIView *_navView;
    UILabel *_navTitleLabel;
    UIButton *_navBackBtn;
    UIButton *_navPopBtn;
    
    UIWebView *_webView;
    WBAlertView *_alert;
    WebViewJavascriptBridge *_bridge;
    
    UIButton *_collectButton;
    UIButton *_shareButton;
    
    BOOL _receiveShare;
}

@end

@implementation WBWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = WB_Common.defaultBcakgroundColor;
    self.navigationView.hidden = YES;
    
    //默认情况下需添加参数
    if (!self.hasParam) {
        self.detailUrl = [NSString stringWithFormat:@"%@?className=%@&uid=%@&key=%@&ios_code_version=%@", self.detailUrl, [SecurityUtil encodeBase64String:WB_User.gradename], WB_User.uid, WB_User.key, @""];
    }
    
    //为了及时刷新课程购买状态,url添加时间戳
    if ([self.detailUrl rangeOfString:@"ms_course"].length) {
        self.detailUrl = [NSString stringWithFormat:@"%@&time=%.f", self.detailUrl, [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]];
    }
    
    NSLog(@"detailUrl - %@", self.detailUrl);
    
    //nav
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WB_Common.screenWidth, WB_Common.navHeight)];
    _navView.backgroundColor = WB_Common.defaultThemeColor;
    _navView.userInteractionEnabled = YES;
    [self.view addSubview:_navView];
    
    //标题
    _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, WB_Common.navHeight-44, WB_Common.screenWidth-220, 44)];
    _navTitleLabel.textColor = [UIColor whiteColor];
    _navTitleLabel.font = [UIFont systemFontOfSize:18];
    _navTitleLabel.numberOfLines = 0;
    _navTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:_navTitleLabel];
    
    //返回按钮
    _navBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, WB_Common.navHeight-44, 60, 44)];
    _navBackBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_navBackBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -9, 0, 0)];
    [_navBackBtn setImageEdgeInsets:UIEdgeInsetsMake(-1.5, 5, 2, 0)];
    [_navBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_navBackBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [_navBackBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    [_navBackBtn addTarget:self action:@selector(navBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_navBackBtn];
    
    //关闭按钮
    _navPopBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, WB_Common.navHeight-44, 50, 44)];
    _navPopBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_navPopBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_navPopBtn addTarget:self action:@selector(navPopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_navPopBtn];
    
    //添加网页
    _webView = [[UIWebView alloc] init];
    _webView.frame = CGRectMake(0, WB_Common.navHeight, WB_Common.screenWidth, WB_Common.screenHeight - WB_Common.navHeight);
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scalesPageToFit = YES;
    _webView.allowsInlineMediaPlayback = YES;
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]
                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                       timeoutInterval:10.0]];
    
    //添加与H5交互的方法
    [self addJsMethod];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucess) name:WB_Common.noticePaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:WB_Common.noticeLoginSuccess object:nil];
}

#pragma mark - webView delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_alert dismiss];
    _navTitleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError = %@", error);
}

#pragma mark - js method

- (void)addJsMethod {
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    //直接唤起微信支付
    [_bridge registerHandler:@"weChatPay" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"weChatPay");
//        [[WBPayManger payManger] weChatPayWithMoney:data[@"data"]];
    }];
    
    //套餐试看视频id
    [_bridge registerHandler:@"packageFreeVideo" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"packageFreeVideo");
//        PlayerViewController *player = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
//        player.videoTitle = @" ";
//        player.videoID = data[@"data"];
//        [self.navigationController pushViewController:player animated:YES];
    }];
    
    //进入套餐购买页
    [_bridge registerHandler:@"buyVideoPackage" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"buyVideoPackage");
//        CoursePackageViewController *package = [[CoursePackageViewController alloc] init];
//        package.packageData = data[@"data"];
//        [self.navigationController pushViewController:package animated:YES];
    }];
    
    //已购买套餐查看视频列表
    [_bridge registerHandler:@"packageVideoList" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"packageVideoList");
//        CourseListViewController *courseList = [[CourseListViewController alloc] init];
//        courseList.courseListType = CourseListTypeIsPackage;
//        courseList.packageData = data[@"data"];
//        [self.navigationController pushViewController:courseList animated:YES];
    }];
    
    //分享事件
    [_bridge registerHandler:@"abc" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"abc");
        
        [WBShare showShareViewWithTitle:data[@"blogURL"][@"desc"]
                                   desc:data[@"blogURL"][@"title"]
                               imageUrl:WB_Common.shareImageUrl
                                 webUrl:data[@"blogURL"][@"link"]
                         viewController:self];
    }];
    
    //返回上一级
    [_bridge registerHandler:@"popToRootViewController" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"popToRootViewController");
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    //点击跟读按钮,获取点读数据,进入评测页面
    [_bridge registerHandler:@"getAudioData" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"能收到吗???????????");
        [_webView reload];
        
//        SpeechViewController *speech = [[SpeechViewController alloc] init];
//        speech.speechString = data[@"blogURL"];
//        [self.navigationController pushViewController:speech animated:YES];
    }];
    
    //积分商城
    [_bridge registerHandler:@"PointsMall" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"PointsMall");
//        ScoreViewController *score = [[ScoreViewController alloc] init];
//        score.servePhone = D_S_P;
//        [self.navigationController pushViewController:score animated:YES];
    }];
    
    //登录
    [_bridge registerHandler:@"goLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"goLogin");
//        if (NoLogin) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:Notice_ShowLogin object:self userInfo:nil];
//        }
    }];
}

//支付成功
- (void)paySucess {
    [_webView stringByEvaluatingJavaScriptFromString:@"weChatPaySuccess()"];
}

//网页触发登录页面,接收登录成功的通知,拼接参数
- (void)loginSuccess {
    
    NSRange rang =   [self.detailUrl rangeOfString:@"?className"];
    if (rang.length) {
        self.detailUrl = [self.detailUrl substringToIndex:rang.location];
    }
    self.detailUrl = [NSString stringWithFormat:@"%@?className=%@&uid=%@&key=%@&ios_code_version=%@", self.detailUrl, [SecurityUtil encodeBase64String:WB_User.gradename], WB_User.uid, WB_User.key, @""];

    if ([self.detailUrl rangeOfString:@"ms_course"].length) {
        self.detailUrl = [NSString stringWithFormat:@"%@&time=%.f", self.detailUrl, [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]];
    }
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0]];
}

- (void)shareButtonClick {
    
    [WBShare showShareViewWithTitle:self.detailTitle
                               desc:self.shareContent ? self.shareContent : self.detailTitle
                           imageUrl:self.detailImageUrl ? self.detailImageUrl: WB_Common.shareImageUrl
                             webUrl:self.detailUrl
                     viewController:self];
}

#pragma mark - webview nav button action

- (void)navBackBtnClick {
    //判断是否有上一层H5页面
    if ([_webView canGoBack]) {
        //如果有则返回
        [_webView goBack];
    } else {
        [self navPopBtnClick];
    }
}

- (void)navPopBtnClick {
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
