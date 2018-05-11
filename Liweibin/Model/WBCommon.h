//
//  WBCommon.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBCommon : NSObject

- (void)initCommonParam;

//屏幕尺寸相关
@property (nonatomic , assign) CGFloat   screenWidth;
@property (nonatomic , assign) CGFloat   screenHeight;
@property (nonatomic , assign) BOOL   is35Inch;
@property (nonatomic , assign) BOOL   is40Inch;
@property (nonatomic , assign) BOOL   is47Inch;
@property (nonatomic , assign) BOOL   is55Inch;
@property (nonatomic , assign) BOOL   is58Inch;

@property (nonatomic , assign) CGFloat   navHeight;
@property (nonatomic , assign) CGFloat   tabbarHeight;

//颜色
@property (nonatomic , strong) UIColor   *defaultThemeColor;
@property (nonatomic , strong) UIColor   *defaultBcakgroundColor;

//友盟
@property (nonatomic , copy) NSString   *shareUrl;
@property (nonatomic , copy) NSString   *UMengAppKey;
@property (nonatomic , copy) NSString   *wechatAppKey;
@property (nonatomic , copy) NSString   *wechatAppSecret;
@property (nonatomic , copy) NSString   *qqAppKey;
@property (nonatomic , copy) NSString   *qqAppSecret;

//极光
@property (nonatomic , copy) NSString   *JPushAppKey;

@end
