//
//  WBNetwork.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/11.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBNetworkModel.h"

//static NSString *domain = @"https://app.beisu100.com/beisuapp";     //线上
static NSString *domain = @"http://sims.beisu100.com/beisuapp";     //仿真
//static NSString *domain = @"http://ceshi.app.beisu100.com/beisuapp";    //测试

@implementation WBNetworkModel

- (void)initNetworkInterface {
    
    self.errorMsg = @"服务器连接失败";
    self.userIsRegist =  [NSString stringWithFormat:@"%@/user/isuserexist", domain];
}

@end
