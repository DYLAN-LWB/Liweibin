//
//  WBGuideView.m
//  Liweibin
//
//  Created by 李伟宾 on 15/12/17.
//  Copyright © 2015年 李伟宾. All rights reserved.
//

#import "WBGuideView.h"
#import "WBPageControl.h"
@interface WBGuideView () <UIScrollViewDelegate>

{
    UIScrollView  *_scrollView;
    WBPageControl *_viewPageControl;
    UIView        *_lastPageView;
}

@property (nonatomic, strong) NSArray *imageArray; //图片数组


@end

@implementation WBGuideView

+ (void)showGuideInView:(UIView *)view {
    
    CGRect frame = [UIScreen mainScreen].bounds;
    WBGuideView *guideView = [[self alloc] initWithFrame:frame];
    [AppManger.window addSubview:guideView];
}

- (id)initWithFrame:(CGRect)frame {
    
    if ([self shouldShowIntroView]) {
        if (self = [super initWithFrame:frame]) {
            [self setUpSubViews];
        }
        return self;
    } else {
        return nil;
    }
}

//是否显示引导页
- (BOOL)shouldShowIntroView {
    
    //获取沙盒中的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key = (__bridge_transfer NSString *)kCFBundleVersionKey;
    NSString *sandBoxVersion = [defaults valueForKey:key];
    //获取当前版本号
    NSDictionary *md =[NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = md[key];

    if ([currentVersion compare:sandBoxVersion] == NSOrderedDescending) {
        //存储当前版本号
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];

        return YES;
    }
    return NO;
}

- (void)setUpSubViews {
    
    NSArray *array35 = @[[UIImage imageNamed:@"guide_35_01"], [UIImage imageNamed:@"guide_35_02"], [UIImage imageNamed:@"guide_35_03"]];
    NSArray *array55 = @[[UIImage imageNamed:@"guide_55_01"], [UIImage imageNamed:@"guide_55_02"], [UIImage imageNamed:@"guide_55_03"]];
//
    self.imageArray = AppManger.common.is35Inch ? array35 : array55;
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.contentSize = CGSizeMake(AppManger.common.screenWidth * (self.imageArray.count + 1), AppManger.common.screenHeight);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    // 显示的图片
    for (int i = 0; i < self.imageArray.count; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(AppManger.common.screenWidth*i, 0, AppManger.common.screenWidth, AppManger.common.screenHeight)];
        if (i == self.imageArray.count - 1) {
            _lastPageView = view;
        }
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:view.bounds];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = self.imageArray[i];
        imageview.backgroundColor = [UIColor redColor];
        [view addSubview:imageview];
        
        [_scrollView addSubview:view];
    }
    
    //pageControl
    _viewPageControl = [[WBPageControl alloc] initWithFrame:CGRectMake(0, AppManger.common.screenHeight*0.9, AppManger.common.screenWidth, 50)];
    _viewPageControl.numberOfPages = self.imageArray.count;
    _viewPageControl.currentPage = 0;
    _viewPageControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
    [self addSubview:_viewPageControl];
} 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = _scrollView.contentOffset.x / pageWidth;

    _viewPageControl.currentPage = roundf(pageFraction);
    
    if ((_scrollView.contentOffset.x / pageWidth) >= (self.imageArray.count-1)) {
        float alpha = 1 - ((_scrollView.contentOffset.x/pageWidth)-(self.imageArray.count-1));
        _lastPageView.alpha = alpha;
        _viewPageControl.alpha = alpha;
    }
    if ((_scrollView.contentOffset.x / pageWidth) >= self.imageArray.count) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0;
            _viewPageControl.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            //启动页结束检查是否登录

        }];
    }
}

@end
