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

@property (nonatomic , copy) NSString   *shareUrl;
@property (nonatomic , copy) NSString   *wechatAppKey;
@property (nonatomic , copy) NSString   *wechatAppSecret;
@property (nonatomic , copy) NSString   *qqAppKey;
@property (nonatomic , copy) NSString   *qqAppSecret;

@property (nonatomic , strong) UIColor   *defaultThemeColor;
@property (nonatomic , strong) UIColor   *defaultBcakgroundColor;

@property (nonatomic , assign) CGFloat   screenWidth;
@property (nonatomic , assign) CGFloat   screenHeight;
@property (nonatomic , assign) BOOL   is35Inch;
@property (nonatomic , assign) BOOL   is40Inch;
@property (nonatomic , assign) BOOL   is47Inch;
@property (nonatomic , assign) BOOL   is55Inch;
@property (nonatomic , assign) BOOL   is58Inch;

@property (nonatomic , assign) CGFloat   navHeight;
@property (nonatomic , assign) CGFloat   tabbarHeight;
@end
