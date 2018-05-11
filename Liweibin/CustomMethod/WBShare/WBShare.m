//
//  WBShare.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBShare.h"

@implementation WBShare

+ (void)showShareViewWithTitle:(NSString *)title
                          desc:(NSString *)desc
                      imageUrl:(NSString *)imageUrl
                        webUrl:(NSString *)webUrl
                viewController:(id)viewController {
    
    //配置分享面板的参数
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.isShow = NO;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndBottom = 3;
    
    //分享面板代理方法
    [UMSocialUIManager setShareMenuViewDelegate:viewController];
    
    //调用分享面板
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        //分享内容
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:imageUrl];
        shareObject.webpageUrl = webUrl;
        
        //分享对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
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
    }];
    
}

@end
