//
//  WBShare.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBShare : NSObject

/**
 *  分享
 *
 *  @param title            分享消息的标题
 *  @param desc             分享消息的内容
 *  @param imageUrl         分享消息的图片地址
 *  @param webUrl           分享消息的详情页地址
 *  @param viewController   展示分享面板的控制器
 */
+ (void)showShareViewWithTitle:(NSString *)title
                          desc:(NSString *)desc
                      imageUrl:(NSString *)imageUrl
                        webUrl:(NSString *)webUrl
                viewController:(id)viewController;
@end
