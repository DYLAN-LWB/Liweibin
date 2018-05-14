//
//  WBFullImage.h
//  Beisu
//
//  Created by 李伟宾 on 16/3/9.
//  Copyright © 2016年 李伟宾. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface WBFullImage : NSObject

/**
 *  点击查看大图     [WBFullImage showFullImageWithUrlString:nil orImageView:button.imageView];
 *
 *  @param urlString     图片地址
 *  @param showImageView 图片视图   (二者选一)
 */
+ (void)showFullImageWithUrlString:(NSString *)urlString orImageView:(UIImageView *)showImageView;

@end
