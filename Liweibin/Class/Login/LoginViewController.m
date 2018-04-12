//
//  LoginViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"username"] = @"18810536903";
    param[@"password"] = @"123456";
    
    [[RequestManager sharedManger] requestPost:@"https://app.beisu100.com/beisuapp/user/login"
                                        params:param
                                       success:^(id response) {
                                           NSLog(@"%@", response);
                                           
                                           WBModel *model = [WBModel modelWithKeyValues:(id)response];
                                           if (model.code == 0) {
                                               //保存用户信息
                                               NSData *data = [NSJSONSerialization dataWithJSONObject:model.data
                                                                                              options:NSJSONWritingPrettyPrinted
                                                                                                error:nil];
                                               [[NSUserDefaults standardUserDefaults] setObject:data
                                                                                         forKey:@"user"];
                                           }
                                       }
                                       failure:^(NSError *error) {
                                           
                                       }];
}

@end
