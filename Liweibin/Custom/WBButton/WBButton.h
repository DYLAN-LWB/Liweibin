//
//  WBButton.h
//  BeiSu
//
//  Created by 李伟宾 on 2017/1/4.
//  Copyright © 2017年 李伟宾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WBButtonStyle) {

    WBButtonStyleImageLeftTextRight = 1, //图片在左,文字在右
    WBButtonStyleImageRightTextLeft = 2, //图片在右,文字在左
    WBButtonStyleImageUpTextUnder   = 3, //图片在上,文字在下
    WBButtonStyleImageUnderTextUp   = 4, //图片在下,文字在上
    WBButtonStyleDefault            = WBButtonStyleImageLeftTextRight //默认系统样式,图片在左,文字在右
};

@interface WBButton : UIButton

/** 
 按钮样式,默认系统样式(图片在左,文字在右)
 */
@property (nonatomic, assign) WBButtonStyle buttonStyle;

/** 
 距离顶部边界的偏移量
 */
@property (nonatomic, assign) CGFloat topMarginOffset;

/**
 竖直方向图片和文字间距
 */
@property (nonatomic, assign) CGFloat verticalSpacing;

/**
 水平方向图片和文字间距
 */
@property (nonatomic, assign) CGFloat horizontalSpacing;

@end
