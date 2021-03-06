//
//  WBCommonModel.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBCommonModel.h"

@implementation WBCommonModel

- (void)initCommonParam {

    self.curVersion = @"1";
    
    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.screenHeight = [[UIScreen mainScreen] bounds].size.height ;
    self.is35Inch = [UIScreen mainScreen].bounds.size.height == 480.f;
    self.is40Inch = [UIScreen mainScreen].bounds.size.height == 568.f;
    self.is47Inch = [UIScreen mainScreen].bounds.size.height == 667.f;
    self.is55Inch = [UIScreen mainScreen].bounds.size.height == 736.f;
    self.is58Inch = [UIScreen mainScreen].bounds.size.height == 812.f;
    
    self.navHeight = self.is58Inch ? 88 : 64;
    self.tabbarHeight = self.is58Inch ? 83 : 49;

    self.defaultThemeColor = [WBTools colorWithHexValue:0xFFA340];
    self.defaultBcakgroundColor = [WBTools colorWithHexValue:0xEFF0F1];
    
    self.UMengAppKey = @"568093ede0f55af33e0022cf";
    self.wechatAppKey = @"wx782f1e709ffdaf1e";
    self.wechatAppSecret = @"0cf8a47d8a1740c833b61ca57ed4066c";
    self.qqAppKey = @"1105050670";
    self.qqAppSecret = @"w7hO5DpbJFzzzH6t";
    
    self.shareUrl = @"http://www.beisu100.com/app/qr/ad/ad001.html";
    self.shareImageUrl = @"http://beisu-js.oss-cn-beijing.aliyuncs.com/lib/img/share_icon.png";
    
    self.JPushAppKey = @"2fb83c64b4e82384a0e9fbf0";
    
    self.noticeShowLogin = @"noticeShowLogin";
    self.noticeLoginSuccess = @"noticeLoginSuccess";
    self.noticePaySuccess = @"noticePaySuccess";

}


@end
