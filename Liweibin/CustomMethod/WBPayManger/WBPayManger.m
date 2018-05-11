//
//  WBPayManger.m
//  Beisu
//
//  Created by 李伟宾 on 16/4/21.
//  Copyright © 2016年 李伟宾. All rights reserved.
//

#import "WBPayManger.h"
//#import "Order.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "APAuthV2Info.h"
//#import "DataSigner.h"
//
//#import "WXApi.h"

@interface WBPayManger ()
//<WXApiDelegate>

@end

@implementation WBPayManger

#pragma mark  支付宝

+ (WBPayManger *)payManger {
    static WBPayManger *instance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
//
//- (void)weChatPayWithMoney:(NSString *)money {
//
//    [ProgressHUD show:@"请稍后..."];
//
//    //是否安装微信
//    if (![WXApi isWXAppInstalled]) {
//        [ProgressHUD showError:@"未安装微信"];
//        return;
//    }
//
//    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
//    param[@"uid"] = WBUserID;
//    param[@"type"] = @"cz";
//    param[@"money"] = money;
//    [WBRequestManager requestWithMethod:HTTP_POST
//                                    url:@"https://app.beisu100.com/wxpay/pay"
//                                 params:param
//                                success:^(id response) {
//                                    NSLog(@"%@", response);
//                                    [ProgressHUD dismiss];
//                                    if (WBInteger(response[@"code"]) == 0) {
//                                        [self wechatPayRequestSuccess:response];
//                                    } else {
//                                        [WBAlertView showMessageToast:response[@"msg"] toView:WBAppDel.window];
//                                    }
//
//                                }
//                                failure:^(NSError *error) {
//                                    [ProgressHUD dismiss];
//                                    [ProgressHUD showError:@"暂时无法支付"];
//                                }];
//}
//
//- (void)weChatPayWithPackageMoney:(NSString *)money courseType:(NSString *)type goodsId:(NSString *)Id {
//    [ProgressHUD show:@"请稍后..."];
//
//    //是否安装微信
//    if (![WXApi isWXAppInstalled]) {
//        [ProgressHUD showError:@"未安装微信"];
//        return;
//    }
//
//    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
//    param[@"uid"] = WBUserID;
//    param[@"type"] = @"bvbt";
//    param[@"money"] = money;
//    param[@"video_type"] = type;
//    param[@"goods_id"] = Id;
//
//    [WBRequestManager requestWithMethod:HTTP_POST
//                                    url:@"http://sims.beisu100.com/wxpay/pay"
//                                 params:param
//                                success:^(id response) {
//                                    NSLog(@"%@", response);
//                                    [ProgressHUD dismiss];
//                                    if (WBInteger(response[@"code"]) == 0) {
//                                        [self wechatPayRequestSuccess:response];
//                                    } else {
//                                        [WBAlertView showMessageToast:response[@"msg"] toView:WBAppDel.window];
//                                    }
//                                }
//                                failure:^(NSError *error) {
//                                    [ProgressHUD dismiss];
//                                    [ProgressHUD showError:@"暂时无法支付"];
//                                }];
//}
//
//- (void)wechatPayRequestSuccess:(id)response {
//
//    if (WBInteger(response[@"code"]) == 0) {
//        PayReq *req   = [[PayReq alloc] init];
//        req.partnerId = WBString(response[@"data"][@"partnerid"]);
//        req.prepayId  = WBString(response[@"data"][@"prepayid"]);
//        req.nonceStr  = WBString(response[@"data"][@"noncestr"]);
//        req.timeStamp = [WBString(response[@"data"][@"timestamp"]) intValue];
//        req.package   = WBString(response[@"data"][@"package"]);
//        req.sign      = WBString(response[@"data"][@"sign"]);
//
//        [WXApi sendReq:req];
//
//    } else {
//        [ProgressHUD showError:response[@"msg"]];
//    }
//}

@end
