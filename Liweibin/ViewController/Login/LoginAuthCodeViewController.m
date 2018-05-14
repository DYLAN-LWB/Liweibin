//
//  LoginAuthCodeViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/11.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "LoginAuthCodeViewController.h"
#import "LoginResetPasswordViewController.h"

@interface LoginAuthCodeViewController () <UITextFieldDelegate>
{
    UILabel *_remindLabel;
    UITextField *_authCodeTF;
    
    UIButton *_getAuthCodeButton;
    NSInteger _countTime;
    NSTimer *_countDownTimer;
}
@end

@implementation LoginAuthCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationView.hidden = YES;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, AppManger.common.screenWidth, AppManger.common.screenWidth*1.2);
    imageView.image = [UIImage imageNamed:@"login_bg"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(WBFit(10), WBFit(20), WBFit(50), WBFit(50));
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    _remindLabel = [[UILabel alloc] init];
    _remindLabel.frame = CGRectMake(0, WBFit(40), AppManger.common.screenWidth, WBFit(70));
    _remindLabel.numberOfLines = 0;
    _remindLabel.textColor = [WBTools colorWithHexValue:0x800000];
    _remindLabel.font = WBFont(18);
    _remindLabel.textAlignment = NSTextAlignmentCenter;
    _remindLabel.text = [NSString stringWithFormat:@"验证码已发送到%@", self.account];
    [self.view addSubview:_remindLabel];
    
    for (int i = 0; i < 4; i++) {
        UIView *textBg = [[UIView alloc] init];
        textBg.frame = CGRectMake(WBFit(45) + WBFit(85)*i, WBFit(155), WBFit(70), WBFit(70));
        textBg.layer.borderColor = [UIColor whiteColor].CGColor;
        textBg.layer.borderWidth = WBFit(2);
        textBg.layer.cornerRadius = WBFit(10);
        [self.view addSubview:textBg];
    }
    
    _authCodeTF = [[UITextField alloc] init];
    _authCodeTF.frame = CGRectMake(WBFit(70), WBFit(150), AppManger.common.screenWidth - WBFit(70), WBFit(80));
    _authCodeTF.delegate = self;
    _authCodeTF.font = WBFont(40);
    _authCodeTF.contentMode = UIViewContentModeScaleAspectFill;
    _authCodeTF.tintColor = [UIColor whiteColor];
    _authCodeTF.textColor = [UIColor blackColor];
    _authCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_authCodeTF];
    [_authCodeTF becomeFirstResponder];
    [_authCodeTF addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _getAuthCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getAuthCodeButton.frame = CGRectMake(WBFit(80), WBFit(300), AppManger.common.screenWidth - WBFit(160), WBFit(45));
    _getAuthCodeButton.layer.cornerRadius = WBFit(10);
    [_getAuthCodeButton setTitleColor:[WBTools colorWithHexValue:0x800000]forState:UIControlStateNormal];
    [_getAuthCodeButton addTarget:self action:@selector(getAuthCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getAuthCodeButton];
    
    [self getAuthCodeButtonClick];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    //textField文字边距
    NSDictionary *attrsDictionary = @{NSFontAttributeName: textField.font,
                                      NSKernAttributeName:[NSNumber numberWithFloat:WBFit(62)]};
    textField.attributedText=[[NSAttributedString alloc]initWithString:textField.text attributes:attrsDictionary];
    
    //当长度大于4位时禁止输入
    return (textField.text.length - range.length + string.length > 4) ? NO :YES;
}

//监听textField字符串变化
- (void)textFieldEditChanged:(UITextField *)textField {
    
    //输入完4位验证码
    if (textField.text.length > 3) {
        _authCodeTF.userInteractionEnabled = NO;
        [_authCodeTF resignFirstResponder];
        
        if (self.sendCodeType == SendCodeTypeForget) {
            //忘记密码
            [self forgetPassword];
        } else {
            //注册
            [self userRegist];
        }
    }
}

- (void)forgetPassword {
    [[WBNetwork networkManger] requestGet:[NSString stringWithFormat:@"%@/mobile/%@/type/1/code/%@", AppManger.network.userAuthVerify, self.account, _authCodeTF.text]
                                  success:^(id response) {
                                      WBModel *model = [WBModel modelWithKeyValues:response];
                                      if (model.code == 0) {
                                          LoginResetPasswordViewController *reset = [[LoginResetPasswordViewController alloc] init];
                                          reset.account = self.account;
                                          reset.authCode = _authCodeTF.text;
                                          [self.navigationController pushViewController:reset animated:YES];
                                      } else {
                                          [self shake:_authCodeTF];
                                          [WBAlertView showMessageToast:model.msg toView:self.view];
                                          _authCodeTF.userInteractionEnabled = YES;
                                          _authCodeTF.text = @"";
                                          [_authCodeTF becomeFirstResponder];
                                      }
                                  } failure:^(NSError *error) {
                                      [WBAlertView showMessageToast:AppManger.network.errorMsg toView:self.view];
                                      _authCodeTF.userInteractionEnabled = YES;
                                      _authCodeTF.text = @"";
                                      [_authCodeTF becomeFirstResponder];
                                  }];
}

- (void)userRegist {
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"username"]   = self.account;
    param[@"password"]   = self.password;
    param[@"code"]       = _authCodeTF.text;
    param[@"grade_id"]   = @"0";
    param[@"regsource"]  = @"2";
    param[@"regchannel"] = @"0";
    param[@"token_id"]   = AppManger.common.deviceToken;
    param[@"invite_code"]   = @"";
    
    [[WBNetwork networkManger] requestPost:AppManger.network.userRegist
                                    params:param
                                   success:^(id response) {
                                       WBModel *model = [WBModel modelWithKeyValues:response];
                                       if (model.code == 0) {
                                           [AppManger saveUserInfo:model.data];
                                           [self dismissViewControllerAnimated:YES completion:nil];
                                       } else {
                                           [self shake:_authCodeTF];
                                           [WBAlertView showMessageToast:model.msg toView:self.view];
                                           _authCodeTF.userInteractionEnabled = YES;
                                           _authCodeTF.text = @"";
                                           [_authCodeTF becomeFirstResponder];
                                       }
                                   } failure:^(NSError *error) {
                                       [WBAlertView showMessageToast:AppManger.network.errorMsg toView:self.view];
                                       _authCodeTF.userInteractionEnabled = YES;
                                       _authCodeTF.text = @"";
                                       [_authCodeTF becomeFirstResponder];
                                   }];
}

- (void)getAuthCodeButtonClick {
    
    _countTime = 60;
    _getAuthCodeButton.userInteractionEnabled = NO;
    _getAuthCodeButton.backgroundColor   = [UIColor clearColor];
    [_getAuthCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后可重发验证码",_countTime] forState:UIControlStateNormal];
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"mobile"] = self.account;
    param[@"type"] = self.sendCodeType == SendCodeTypeRegister ? @"0" : @"1";

    [[WBNetwork networkManger] requestPost:AppManger.network.userSendAuthCode
                                    params:param
                                   success:^(id response) {
                                       WBModel *model = [WBModel modelWithKeyValues:response];
                                       if (model.code != 0) {
                                           [WBAlertView showMessageToast:model.msg toView:self.view];
                                       }
                                   } failure:^(NSError *error) {
                                   }];
}

- (void)timeFireMethod {
    _countTime--;
    [_getAuthCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后可重发验证码",_countTime] forState:UIControlStateNormal];
    if(_countTime == 0) {
        [_countDownTimer invalidate];
        [_getAuthCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getAuthCodeButton.userInteractionEnabled = YES;
        _getAuthCodeButton.backgroundColor = [UIColor whiteColor];
    }
}

//返回
- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
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
