//
//  WBTabbarViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBTabbarViewController.h"
#import "WBNavViewController.h"
#import "LoginAccountViewController.h"

//数字角标直径
#define NumMark_WH 20

@interface WBTabbarViewController ()

@property(nonatomic,strong)UIView *tabBarView;
@property(nonatomic,assign)CGFloat tabBarHeight;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)NSArray *selImageArray;
@property(nonatomic,strong)NSArray *controllerArray;
@property(nonatomic,strong)UIButton *seleBtn;

@end

@implementation WBTabbarViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.controllerArray = @[@"HomeViewController",@"DiscoverViewController",@"PersonViewController"];
        self.titleArray = @[@"首页",@"发现",@"我的"];
        self.imageArray = @[@"tab_01",@"tab_04",@"tab_05"];
        self.selImageArray  = @[@"tab_01_sel",@"tab_04_sel",@"tab_05_sel"];
        self.tabBarHeight = 49.0;

        [self setupViewControllers:self.controllerArray];
        [self setupTabbarView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginController) name:WB_Common.noticeShowLogin object:nil];

    }
    return self;
}

- (void)showLoginController {
    LoginAccountViewController *login = [[LoginAccountViewController alloc] init];
    WBNavViewController *loginNav = [[WBNavViewController alloc] initWithRootViewController:login];
    [self presentViewController:loginNav animated:YES completion:nil];
}

- (void)setupViewControllers:(NSArray *)controllers {
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSString *className in controllers) {
        Class class = NSClassFromString(className);
        UIViewController *viewcontroller = [[class alloc]init];
        WBNavViewController *nav = [[WBNavViewController alloc] initWithRootViewController:viewcontroller];
        [items addObject:nav];
    }
    self.viewControllers = items;
}

- (void)setupTabbarView {
    
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0,0,WB_Common.screenWidth,self.tabBarHeight)];
    [self.tabBar addSubview:self.tabBarView];
    
    [self.tabBar setShadowImage:[[UIImage alloc] init]];
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.tabBarView addSubview:lineLabel];
    
    int num = (int)self.controllerArray.count;
    for(int i = 0; i < num; i++) {
        
        WBTabbarButton *button = [[WBTabbarButton alloc] initWithFrame:CGRectMake(WB_Common.screenWidth/num*i, 0, WB_Common.screenWidth/num, self.tabBarHeight)];
        button.tag = 1000 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:WB_Common.defaultThemeColor forState:UIControlStateSelected];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.selImageArray[i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView  addSubview:button];
        if (i == 0) {
            //默认选中
            button.selected=YES;
            self.seleBtn = button;
        }
        
        //角标
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.size.width/2.0+10, 3, NumMark_WH, NumMark_WH)];
        numLabel.layer.masksToBounds = YES;
        numLabel.layer.cornerRadius = 10;
        numLabel.backgroundColor = [UIColor redColor];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:13];
        numLabel.tag = 1010+i;
        numLabel.hidden = YES;
        [button addSubview:numLabel];
    }
}

- (void)buttonAction:(UIButton *)button {
    [self showViewController:button.tag-1000];
}

/**
 *  切换显示控制器
 *
 *  @param index 位置
 */
- (void)showViewController:(NSInteger)index {
    
    if(index >= self.controllerArray.count) {
        NSLog(@"index取值超出范围");
        return;
    }
    
    self.seleBtn.selected = NO;
    UIButton *button = (UIButton *)[self.tabBarView viewWithTag:1000+index];
    button.selected = YES;
    self.seleBtn = button;
    self.selectedIndex = index;
}

/**
 *  数字角标
 *
 *  @param badge   所要显示数字
 *  @param index 位置
 */
- (void)showBadgeMark:(NSInteger)badge index:(NSInteger)index {
    if(index >= self.controllerArray.count) {
        NSLog(@"index取值超出范围");
        return;
    }
    
    UILabel *numLabel = (UILabel *)[self.tabBarView viewWithTag:1010+index];
    numLabel.hidden=NO;
    CGRect nFrame = numLabel.frame;
    if(badge<=0) {
        //隐藏角标
        [self hideMarkIndex:index];
    } else {
        if(badge>0&&badge<=9) {
            nFrame.size.width = NumMark_WH;
        } else if (badge>9&&badge<=19) {
            nFrame.size.width = NumMark_WH+5;
        } else {
            nFrame.size.width = NumMark_WH+10;
        }
        nFrame.size.height = NumMark_WH;
        numLabel.frame = nFrame;
        numLabel.layer.cornerRadius = NumMark_WH/2.0;
        numLabel.text = [NSString stringWithFormat:@"%ld",badge];
        if(badge>99) {
            numLabel.text =@"99+";
        }
    }
}

/**
 *  小红点
 *
 *  @param index 位置
 */
- (void)showPointMarkIndex:(NSInteger)index {
    if(index >= self.controllerArray.count) {
        NSLog(@"index取值超出范围");
        return;
    }
    UILabel *numLabel = (UILabel *)[self.tabBarView viewWithTag:1010+index];
    numLabel.hidden=NO;
    CGRect nFrame = numLabel.frame;
    nFrame.size.height=10;
    nFrame.size.width = 10;
    numLabel.frame = nFrame;
    numLabel.layer.cornerRadius = 5;
    numLabel.text = @"";
}

/**
 *  隐藏指定位置角标
 *
 *  @param index 位置
 */
- (void)hideMarkIndex:(NSInteger)index {
    if(index >= self.controllerArray.count) {
        NSLog(@"index取值超出范围");
        return;
    }
    
    UILabel *numLabel = (UILabel *)[self.tabBarView viewWithTag:1010+index];
    numLabel.hidden = YES;
}

#pragma mark - 只允许竖屏

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.selectedViewController.preferredStatusBarUpdateAnimation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UINavigationController *nav = (UINavigationController *)self.selectedViewController;
    return nav.topViewController.supportedInterfaceOrientations;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    for (UIViewController *viewCotroller in [self viewControllers]) {
        if (![viewCotroller respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)] ||
            ![viewCotroller shouldAutorotateToInterfaceOrientation:toInterfaceOrientation]) {
            return NO;
        }
    }
    return YES;
}

@end
