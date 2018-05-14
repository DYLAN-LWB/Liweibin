//
//  LoginAccountViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "LoginAccountViewController.h"
#import "LoginPasswordViewController.h"

@interface LoginAccountViewController () <UITextFieldDelegate>
{
    UILabel *_remindLabel;
    UITextField *_phoneNumTF;
    UIButton *_nextBtn;
    UIButton *_agreeBtn;
}
@end

@implementation LoginAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationView.hidden = YES;
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, AppManger.common.screenWidth, AppManger.common.screenWidth*1.2);
    imageView.image = [UIImage imageNamed:@"login_bg"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    _remindLabel = [[UILabel alloc] init];
    _remindLabel.frame = CGRectMake(0, WBFit(50), AppManger.common.screenWidth, WBFit(50));
    _remindLabel.numberOfLines = 0;
    _remindLabel.textColor = [WBTools colorWithHexValue:0x800000];
    _remindLabel.font = WBFont(21);
    _remindLabel.text = @"请输入您的手机号";
    _remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_remindLabel];

    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.frame = CGRectMake(AppManger.common.screenWidth - WBFit(70), WBFit(20), WBFit(70), WBFit(50));
    [dismissBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    _phoneNumTF = [[UITextField alloc] init];
    _phoneNumTF.frame = CGRectMake(WBFit(60), WBFit(120), AppManger.common.screenWidth - WBFit(120), WBFit(45));
    _phoneNumTF.delegate = self;
    _phoneNumTF.font = WBFont(20);
    _phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumTF.contentMode = UIViewContentModeScaleAspectFill;
    _phoneNumTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 22)];
    _phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumTF.tintColor = [UIColor whiteColor];
    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumTF.layer.masksToBounds = YES;
    _phoneNumTF.layer.cornerRadius = WBFit(20);
    _phoneNumTF.layer.borderColor = [UIColor whiteColor].CGColor;
    _phoneNumTF.layer.borderWidth = WBFit(2);
    [self.view addSubview:_phoneNumTF];
    [_phoneNumTF becomeFirstResponder];

    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake((AppManger.common.screenWidth - WBFit(100))*0.5, WBFit(200), WBFit(100), WBFit(100));
    [_nextBtn setImage:[UIImage imageNamed:@"next_over_btn"] forState:UIControlStateNormal];
    [_nextBtn setImage:[UIImage imageNamed:@"next_btn"] forState:UIControlStateHighlighted];
    [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    protocolBtn.frame = CGRectMake(WBFit(100), WBFit(350), AppManger.common.screenWidth - WBFit(200), WBFit(40));
    protocolBtn.titleLabel.font = WBFont(16);
    [protocolBtn setTitle:@"我同意倍速课堂的用户协议" forState:UIControlStateNormal];
    [protocolBtn setTitleColor:[WBTools colorWithHexValue:0x804120] forState:UIControlStateNormal];
    [protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protocolBtn];
    
    _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _agreeBtn.frame = CGRectMake(WBFit(60), WBFit(350), WBFit(40), WBFit(40));
    [_agreeBtn setImage:[UIImage imageNamed:@"tongyi_btn"] forState:UIControlStateNormal];
    [_agreeBtn setImage:[UIImage imageNamed:@"tongyi_over_btn"] forState:UIControlStateSelected];
    [_agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_agreeBtn];
    
    _agreeBtn.selected = YES;
}

- (void)agreeBtnClick:(UIButton *)button {
    button.selected = !button.selected;
}

//协议
- (void)protocolBtnClick {
    WebViewController *web = [[WebViewController alloc] init];
    web.detailUrl = @"http://www.beisu100.com/beisuapp/article/reginfo/aid/13";
    [self.navigationController pushViewController:web animated:YES];
}

//下一步
- (void)nextBtnClick {

    // 判断手机号格式是否正确
    NSString *mobileRegex = @"^[1][34578][0-9]{9}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];
    
    if (![mobileTest evaluateWithObject:_phoneNumTF.text]) {
        [self shake:_phoneNumTF];
        [WBAlertView showMessageToast:@"手机号错误,请重新输入" toView:self.view];
        return;
    }
    
    if (!_agreeBtn.selected) {
        [WBAlertView showMessageToast:@"请先阅读相关协议并同意" toView:self.view];
        return;
    }
    
    _nextBtn.enabled = NO;
    
    [[WBNetwork networkManger] requestGet:[NSString stringWithFormat:@"%@/mobile/%@",AppManger.network.userIsRegist, _phoneNumTF.text]
                                  success:^(id response) {
                                      _nextBtn.enabled = YES;
                                      WBModel *model = [WBModel modelWithKeyValues:(id)response];
                                      //0未注册 3已注册
                                      if (model.code == 0 || model.code == 3) {
                                          LoginPasswordViewController *pwd = [[LoginPasswordViewController alloc] init];
                                          pwd.isRegist = model.code == 3 ? YES : NO;
                                          pwd.account = _phoneNumTF.text;
                                          [self.navigationController pushViewController:pwd animated:YES];
                                      } else {
                                          [self shake:_phoneNumTF];
                                          _remindLabel.text = model.msg;
                                          _remindLabel.textColor = [WBTools colorWithHexValue:0x800000];
                                      }
                                  } failure:^(NSError *error) {
                                      _nextBtn.enabled = YES;
                                      [self shake:_phoneNumTF];
                                      _remindLabel.text = AppManger.network.errorMsg;
                                      _remindLabel.textColor = [WBTools colorWithHexValue:0x800000];
                                  }];
}

//当长度大于11位时禁止输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return (textField.text.length - range.length + string.length > 11) ? NO :YES;
 }

//跳过
- (void)dismissBtnClick {
    [_phoneNumTF resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
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
