//
//  FeedbackViewController.m
//  Beisu
//
//  Created by 李伟宾 on 16/3/14.
//  Copyright © 2016年 李伟宾. All rights reserved.
//

#import "FeedbackViewController.h"
#import <sys/utsname.h>

@interface FeedbackViewController ()
<UITextViewDelegate>

{
    UIButton    *_confirmButton;
    UITextView  *_feedBackTextView;
    UILabel     *_falseLabel;
}

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"意见反馈";
    self.view.backgroundColor = WB_Common.defaultBcakgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO; // textview光标不在第一行bug

    _feedBackTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 24 + WB_Common.navHeight, WB_Common.screenWidth - 40, WBFit(195))];
    _feedBackTextView.font = WBFont(20);
    _feedBackTextView.delegate = self;
    _feedBackTextView.layoutManager.allowsNonContiguousLayout = NO;
    _feedBackTextView.layer.cornerRadius = 5;
    _feedBackTextView.layer.masksToBounds = YES;
    [self.view addSubview:_feedBackTextView];
    
    _falseLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, WB_Common.screenWidth-20, 25)];
    _falseLabel.text = @"请输入您的意见（10～140字）";
    _falseLabel.font =  WBFont(20);
    _falseLabel.textColor = [UIColor colorWithWhite:0.752 alpha:1.000];
    [_feedBackTextView addSubview:_falseLabel];
    
    // 提交
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = CGRectMake(40, CGRectGetMaxY(_feedBackTextView.frame) + 50 , WB_Common.screenWidth - 80, WBFit(45));
    _confirmButton.backgroundColor = WB_Common.defaultThemeColor;
    _confirmButton.titleLabel.font = WBFont(21);
    _confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _confirmButton.layer.cornerRadius = 8;
    [_confirmButton setTitle:@"提交反馈" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchDown];
    [_confirmButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view  addSubview:_confirmButton];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _falseLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (0 == _feedBackTextView.text.length) {
        _falseLabel.hidden = NO;
    }
}

- (void)confirmButtonClick {
    NSLog(@"%@",  _feedBackTextView.text);

    //过滤空格
    NSString *content = [_feedBackTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (_feedBackTextView.text.length < 10) {
        [WBAlertView showMessageToast:@"反馈字数不少于10个字" toView:self.view];
        return;
    }
    
    if (_feedBackTextView.text.length > 140) {
        [WBAlertView showMessageToast:@"回复字数不能超过140字" toView:self.view];
        return;
    }
    
    [_feedBackTextView resignFirstResponder];
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *model = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];  //手机型号代码
    NSString *phoneVer = [[UIDevice currentDevice] systemVersion];  //手机系统版本
    
//    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
//    param[@"uid"] = WBUserID;
//    param[@"key"] = WBUserKey;
//    param[@"content"] = content;
//    param[@"type"] = @"2";
//    param[@"devicebrand"] = @"苹果";
//    param[@"systemmodel"] = [self currentModel:model];
//    param[@"systemversion"] = phoneVer;
//    param[@"appversion"] = Current_Version;
//
//    [WBRequestManager requestWithMethod:HTTP_POST
//                                    url:Http_UserFeedback
//                                 params:param
//                                success:^(id response) {
//                                    NSLog(@"%@", response);
//                                    WBShowToastMessage(response[@"msg"]);
//                                    if (WBInteger(response[@"code"]) == 0) {
//                                        [self.navigationController popViewControllerAnimated:YES];
//                                    }
//                                }
//                                failure:^(NSError *error) { }];
}

- (NSString *)currentModel:(NSString *)phoneModel {
    
    if ([phoneModel isEqualToString:@"iPhone3,1"] ||
        [phoneModel isEqualToString:@"iPhone3,2"])   return @"iPhone 4";
    if ([phoneModel isEqualToString:@"iPhone4,1"])   return @"iPhone 4S";
    if ([phoneModel isEqualToString:@"iPhone5,1"] ||
        [phoneModel isEqualToString:@"iPhone5,2"])   return @"iPhone 5";
    if ([phoneModel isEqualToString:@"iPhone5,3"] ||
        [phoneModel isEqualToString:@"iPhone5,4"])   return @"iPhone 5C";
    if ([phoneModel isEqualToString:@"iPhone6,1"] ||
        [phoneModel isEqualToString:@"iPhone6,2"])   return @"iPhone 5S";
    if ([phoneModel isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([phoneModel isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([phoneModel isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([phoneModel isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([phoneModel isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([phoneModel isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([phoneModel isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([phoneModel isEqualToString:@"iPhone10,1"] ||
        [phoneModel isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([phoneModel isEqualToString:@"iPhone10,2"] ||
        [phoneModel isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([phoneModel isEqualToString:@"iPhone10,3"] ||
        [phoneModel isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if ([phoneModel isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([phoneModel isEqualToString:@"iPad2,1"] ||
        [phoneModel isEqualToString:@"iPad2,2"] ||
        [phoneModel isEqualToString:@"iPad2,3"] ||
        [phoneModel isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([phoneModel isEqualToString:@"iPad3,1"] ||
        [phoneModel isEqualToString:@"iPad3,2"] ||
        [phoneModel isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([phoneModel isEqualToString:@"iPad3,4"] ||
        [phoneModel isEqualToString:@"iPad3,5"] ||
        [phoneModel isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([phoneModel isEqualToString:@"iPad4,1"] ||
        [phoneModel isEqualToString:@"iPad4,2"] ||
        [phoneModel isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([phoneModel isEqualToString:@"iPad5,3"] ||
        [phoneModel isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([phoneModel isEqualToString:@"iPad6,3"] ||
        [phoneModel isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7-inch";
    if ([phoneModel isEqualToString:@"iPad6,7"] ||
        [phoneModel isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch";
    if ([phoneModel isEqualToString:@"iPad6,11"] ||
        [phoneModel isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([phoneModel isEqualToString:@"iPad7,1"] ||
        [phoneModel isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    if ([phoneModel isEqualToString:@"iPad7,3"] ||
        [phoneModel isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    
    if ([phoneModel isEqualToString:@"iPad2,5"] ||
        [phoneModel isEqualToString:@"iPad2,6"] ||
        [phoneModel isEqualToString:@"iPad2,7"]) return @"iPad mini";
    if ([phoneModel isEqualToString:@"iPad4,4"] ||
        [phoneModel isEqualToString:@"iPad4,5"] ||
        [phoneModel isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([phoneModel isEqualToString:@"iPad4,7"] ||
        [phoneModel isEqualToString:@"iPad4,8"] ||
        [phoneModel isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([phoneModel isEqualToString:@"iPad5,1"] ||
        [phoneModel isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    
    if ([phoneModel isEqualToString:@"iPod1,1"]) return @"iTouch";
    if ([phoneModel isEqualToString:@"iPod2,1"]) return @"iTouch2";
    if ([phoneModel isEqualToString:@"iPod3,1"]) return @"iTouch3";
    if ([phoneModel isEqualToString:@"iPod4,1"]) return @"iTouch4";
    if ([phoneModel isEqualToString:@"iPod5,1"]) return @"iTouch5";
    if ([phoneModel isEqualToString:@"iPod7,1"]) return @"iTouch6";
    
    if ([phoneModel isEqualToString:@"i386"] || [phoneModel isEqualToString:@"x86_64"]) return @"iPhone Simulator";

    
    return @"Unknown";
}
@end
