//
//  ShareView.m
//  Beisu
//
//  Created by 李伟宾 on 15/12/17.
//  Copyright © 2015年 李伟宾. All rights reserved.
//

#import "WBShareView.h"

@interface WBShareView () 


@end

@implementation WBShareView

+ (void)showShareViewOn:(id)viewController {
    
    //配置分享面板的参数
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
//    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.isShow = NO;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndBottom = 3;

    [UMSocialUIManager setShareMenuViewDelegate:viewController];

    //调用分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
    }];
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType on:viewController];
    }];
    
}

+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType on:(id)viewController {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"倍速课堂"
                                                                             descr:@"倍速课堂-万向思维,科学备考"
                                                                         thumImage:@"http://beisu-js.oss-cn-beijing.aliyuncs.com/lib/img/share_icon.png"];
    //设置网页地址
    shareObject.webpageUrl = AppManger.common.shareUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:viewController
                                           completion:^(id data, NSError *error) {
                                               if (!error && [data isKindOfClass:[UMSocialShareResponse class]]) {
                                                   UMSocialShareResponse *resp = data;
                                                   if (resp.originalResponse) {
                                                       NSLog(@"分享成功aaaaa");
                                                   }
                                               }
                                           }];
}

@end
