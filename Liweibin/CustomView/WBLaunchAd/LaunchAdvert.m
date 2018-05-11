//
//  LaunchAdvert.m
//  Liweibin
//
//  Created by 李伟宾 on 2017/10/17.
//  Copyright © 2017年 李伟宾. All rights reserved.
//

#import "LaunchAdvert.h"
#import "WebViewController.h"
#import "CircleView.h"

@interface LaunchAdvert ()

{
    NSInteger _countTime;
    NSTimer *_countDownTimer;
    NSMutableArray *_goodsAM;
}
@property (nonatomic, copy) NSString *adUrl;
@property (nonatomic, copy) NSString *adTitle;
@end

@implementation LaunchAdvert

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
//1全屏 2倍速小店商品
- (void)setAdvertType:(NSInteger)advertType {
    
    if (advertType == 1) {
        [self fullScreenAd];
    } else { 
        [AppManger dismissCustomLaunchImage];
    }
}

- (void)fullScreenAd {
    self.adUrl = WBString(self.adInfoDict[@"url"]);
    self.adTitle  = WBString(self.adInfoDict[@"explain"]);
    
    UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AppManger.common.screenWidth, 1.52 * AppManger.common.screenWidth)];
    launchImageView.contentMode = UIViewContentModeScaleAspectFit;
    launchImageView.userInteractionEnabled = YES;
    launchImageView.backgroundColor = [UIColor clearColor];
    [launchImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)]];
    [self addSubview:launchImageView];

    
    CircleView *circleView = [[CircleView alloc] initWithFrame:CGRectMake(AppManger.common.screenWidth - WBFit(65), WBFit(26), WBFit(40), WBFit(40))];
    circleView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.66];
    circleView.layer.masksToBounds = YES;
    circleView.layer.cornerRadius = WBFit(20);
    [launchImageView addSubview:circleView];

    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpBtn.frame = CGRectMake(0, 0, WBFit(40), WBFit(40));
    jumpBtn.backgroundColor = [UIColor clearColor];
    jumpBtn.titleLabel.font = WBFont(12);
    jumpBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [jumpBtn addTarget:self action:@selector(dismissCustomLaunchImage) forControlEvents:UIControlEventTouchDown];
    
    __weak CircleView *weakCircleView = circleView;
    [launchImageView sd_setImageWithURL:[NSURL URLWithString:WBString(self.adInfoDict[@"img"])]
                              completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                  if(error) {
                                      [AppManger dismissCustomLaunchImage];
                                  } else {
                                      
                                      //广告图片加载完成之后在出现跳过按钮
                                      weakCircleView.begin = YES;
                                      [weakCircleView addSubview:jumpBtn];
                                      
                                      _countTime = CountDownTime;
                                      _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                                  }
                              }];
}

- (void)timeFireMethod {
    _countTime--;
    if(_countTime == 0) {
        [_countDownTimer invalidate];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [AppManger dismissCustomLaunchImage];
        });
    }
}

- (void)viewTapped {

    if (self.adUrl.length > 6) {
        
        WebViewController *web = [[WebViewController alloc] init];
        web.detailUrl = self.adUrl;
        web.detailTitle = self.adTitle ;
        web.view.tag = 678;
        [AppManger.window.rootViewController presentViewController:web animated:YES completion:nil];
        
        [AppManger dismissCustomLaunchImage];
    }
}


@end
