//
//  WBPayManger.h
//  Beisu
//
//  Created by 李伟宾 on 16/4/21.
//  Copyright © 2016年 李伟宾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBPayManger : NSObject

+ (WBPayManger *)payManger;

/**
 *  微信支付
 *  @param money          支付金额
 */
- (void)weChatPayWithMoney:(NSString *)money;

/**
 *  微信支付 购买套餐
 *  @param money          支付金额
 */
- (void)weChatPayWithPackageMoney:(NSString *)money courseType:(NSString *)type goodsId:(NSString *)Id ;

@end
