//
//  WBFullImage.m
//  Beisu
//
//  Created by 李伟宾 on 16/3/9.
//  Copyright © 2016年 李伟宾. All rights reserved.
//

#import "WBFullImage.h"

@implementation WBFullImage

+ (void)showFullImageWithUrlString:(NSString *)urlString orImageView:(UIImageView *)showImageView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 大图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha  = 0;
    [backgroundView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)]];
    [window addSubview:backgroundView];
    
    
    // 放大图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WB_Common.screenWidth/2, WB_Common.screenWidth/2, 0, 0)];
    if (showImageView) {
        imageView.image = showImageView.image;
    } else {
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];

    }
    imageView.tag = 1;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [backgroundView addSubview:imageView];
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha = 1;
        imageView.frame = CGRectMake(0,  0, WB_Common.screenWidth, WB_Common.screenHeight);
    }];
}

+ (void)hideImage:(UITapGestureRecognizer*)tap {
    
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(WB_Common.screenWidth/2, WB_Common.screenHeight/2, 0, 0);
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
