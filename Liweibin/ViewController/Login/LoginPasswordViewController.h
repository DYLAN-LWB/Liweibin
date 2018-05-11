//
//  LoginPasswordViewController.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/11.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPasswordViewController : WBBaseViewController

/**手机号*/
@property (nonatomic, copy) NSString *account;
/**是否已经注册*/
@property (nonatomic, assign) BOOL isRegist;

@end
