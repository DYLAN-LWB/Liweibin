//
//  LoginAuthCodeViewController.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/11.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginAuthCodeViewController : WBBaseViewController


typedef NS_ENUM(NSInteger, SendCodeType) {
    SendCodeTypeRegister = 1,
    SendCodeTypeForget   = 2,
};

@property (readwrite, assign) SendCodeType sendCodeType;

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;

@end
