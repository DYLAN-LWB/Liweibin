//
//  WBTabbarButton.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBTabbarButton.h"


//TabBarButton中 图片与文字上下所占比
static const float scale = 0.6;

@interface WBTabbarButton()

@end

@implementation WBTabbarButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat newX = 0;
    CGFloat newY = 5;
    CGFloat newWidth = contentRect.size.width;
    CGFloat newHeight = contentRect.size.height*scale - newY;
    return CGRectMake(newX, newY, newWidth, newHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat newX = 0;
    CGFloat newY = contentRect.size.height*scale;
    CGFloat newWidth = contentRect.size.width;
    CGFloat newHeight = contentRect.size.height - contentRect.size.height*scale;
    return CGRectMake(newX, newY, newWidth, newHeight);
}

@end

