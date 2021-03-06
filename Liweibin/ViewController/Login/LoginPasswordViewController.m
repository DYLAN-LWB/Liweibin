//
//  LoginPasswordViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/11.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "LoginPasswordViewController.h"
#import "LoginAuthCodeViewController.h"

@interface LoginPasswordViewController () 
{
    UILabel *_remindLabel;
    UITextField *_pwdNumTF;
    UIButton *_nextBtn;
}
@end

@implementation LoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationView.hidden = YES;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, WB_Common.screenWidth, WB_Common.screenWidth*1.2);
    imageView.image = [UIImage imageNamed:@"login_bg"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(WBFit(10), WBFit(20), WBFit(50), WBFit(50));
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    _remindLabel = [[UILabel alloc] init];
    _remindLabel.frame = CGRectMake(0, WBFit(40), WB_Common.screenWidth, WBFit(70));
    _remindLabel.numberOfLines = 0;
    _remindLabel.textColor = [WBTools colorWithHexValue:0x800000];
    _remindLabel.font = WBFont(18);
    _remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_remindLabel];
    
    if (self.isRegist) {
        _remindLabel.text = [NSString stringWithFormat:@"%@已注册\n请输入密码登录", self.account];
    } else {
        _remindLabel.text = [NSString stringWithFormat:@"%@未注册\n请设置您的登录密码", self.account];
    }
    
    UIButton *secureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secureBtn.frame = CGRectMake(WBFit(20), WBFit(5), WBFit(35), WBFit(35));
    secureBtn.selected = YES;
    [secureBtn setImage:[UIImage imageNamed:@"secure_no"] forState:UIControlStateNormal];
    [secureBtn setImage:[UIImage imageNamed:@"secure_yes"] forState:UIControlStateSelected];
    [secureBtn addTarget:self action:@selector(secureBtnChange:) forControlEvents:UIControlEventTouchUpInside];
    
    _pwdNumTF = [[UITextField alloc] init];
    _pwdNumTF.frame = CGRectMake(WBFit(60), WBFit(120), WB_Common.screenWidth - WBFit(120), WBFit(45));
    _pwdNumTF.font = WBFont(21);
    _pwdNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdNumTF.contentMode = UIViewContentModeScaleAspectFill;
    _pwdNumTF.leftView = secureBtn;
    _pwdNumTF.leftViewMode = UITextFieldViewModeAlways;
    _pwdNumTF.tintColor = [UIColor whiteColor];
    _pwdNumTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _pwdNumTF.secureTextEntry = YES;
    _pwdNumTF.layer.masksToBounds = YES;
    _pwdNumTF.layer.cornerRadius = WBFit(20);
    _pwdNumTF.layer.borderColor = [UIColor whiteColor].CGColor;
    _pwdNumTF.layer.borderWidth = WBFit(2);
    [self.view addSubview:_pwdNumTF];
    [_pwdNumTF becomeFirstResponder];

    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake((WB_Common.screenWidth - WBFit(100))*0.5, WBFit(200), WBFit(100), WBFit(100));
    [_nextBtn setImage:[UIImage imageNamed:@"next_over_btn"] forState:UIControlStateNormal];
    [_nextBtn setImage:[UIImage imageNamed:@"next_btn"] forState:UIControlStateHighlighted];
    [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(WBFit(80), WBFit(320), WB_Common.screenWidth - WBFit(160), WBFit(50));
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
}

- (void)secureBtnChange:(UIButton *)button {
    button.selected = !button.selected;
    _pwdNumTF.secureTextEntry = !_pwdNumTF.secureTextEntry;
}
//返回
- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

//忘记密码
- (void)forgetBtnClick {
    LoginAuthCodeViewController *code = [[LoginAuthCodeViewController alloc] init];
    code.sendCodeType = SendCodeTypeForget;
    code.account = self.account;
    [self.navigationController pushViewController:code animated:YES];
}

//下一步
- (void)nextBtnClick {
    
    if (_pwdNumTF.text.length < 6) {
        [self shake:_pwdNumTF];
        [WBAlertView showMessageToast:@"密码长度至少6位" toView:self.view];
        return;
    }
    
    if (_pwdNumTF.text.length > 20) {
        [self shake:_pwdNumTF];
        [WBAlertView showMessageToast:@"密码长度需小于20位" toView:self.view];
        return;
    }
    
    for (int i = 0; i < _pwdNumTF.text.length; ++i) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [_pwdNumTF.text substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            [self shake:_pwdNumTF];
            [WBAlertView showMessageToast:@"密码不能包含中文或者中文符号" toView:self.view];
            return;
        }
    }
    
    _nextBtn.enabled = NO;
    
    if (self.isRegist) {
        [self loginAccount];
    } else {
        LoginAuthCodeViewController *code = [[LoginAuthCodeViewController alloc] init];
        code.sendCodeType = SendCodeTypeRegister;
        code.password = _pwdNumTF.text;
        code.account = self.account;
        [self.navigationController pushViewController:code animated:YES];
    }
}

- (void)loginAccount {
    [_pwdNumTF resignFirstResponder];

    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"username"] = self.account;
    param[@"password"] = _pwdNumTF.text;

    [[WBNetwork networkManger] requestPost:WB_Network.userLogin
                                    params:param
                                   success:^(id response) {
                                       _nextBtn.enabled = YES;
                                       WBModel *model = [WBModel modelWithKeyValues:response];
                                       if (model.code == 0) {
                                           [WB_Manger saveUserInfo:model.data];
                                           [self dismissViewControllerAnimated:YES completion:nil];
                                       } else {
                                           [self shake:_pwdNumTF];
                                           [WBAlertView showMessageToast:model.msg toView:self.view];
                                       }
                                   }
                                   failure:^(NSError *error) {
                                       _nextBtn.enabled = YES;
                                       [WBAlertView showMessageToast:WB_Network.errorMsg toView:self.view];
                                   }];
}

//震动动画
- (void)shake:(UIView *)view {
    CGRect frame = view.frame;
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef shakePath = CGPathCreateMutable();
    CGPathMoveToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
    int index;
    for (index = 3; index >=0; --index)
    {
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 - frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 + frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
    }
    CGPathCloseSubpath(shakePath);
    
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = 0.5f;
    shakeAnimation.removedOnCompletion = YES;
    
    [view.layer addAnimation:shakeAnimation forKey:nil];
    CFRelease(shakePath);
}
@end
