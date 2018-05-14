//
//  WBButton.m
//  BeiSu
//
//  Created by 李伟宾 on 2017/1/4.
//  Copyright © 2017年 李伟宾. All rights reserved.
//

#import "WBButton.h"

@implementation WBButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    WBButton *button = [super buttonWithType:buttonType];
    [button defaultSet];
    return button;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultSet];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSet];
    }
    return self;
}

- (void)defaultSet {
    self.topMarginOffset = -5;
    self.verticalSpacing = 10;
    self.horizontalSpacing = 10;
    self.buttonStyle = WBButtonStyleDefault;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    switch (self.buttonStyle) {
        case WBButtonStyleImageRightTextLeft: {
            //图片在右,文字在左
            CGRect imageViewFrame = self.imageView.frame;
            CGRect titleLabelFrame = self.titleLabel.frame;
            CGFloat totalWidth = imageViewFrame.size.width + self.horizontalSpacing + titleLabelFrame.size.width;
            
            titleLabelFrame.origin.x = (self.frame.size.width - totalWidth) / 2;
            imageViewFrame.origin.x = titleLabelFrame.origin.x + titleLabelFrame.size.width + self.horizontalSpacing;
            
            titleLabelFrame.origin.y += self.topMarginOffset;
            imageViewFrame.origin.y += self.topMarginOffset;

            self.titleLabel.frame = titleLabelFrame;
            self.imageView.frame = imageViewFrame;
        }
            break;
        case WBButtonStyleImageUnderTextUp: {
            //图片在下,文字在上
            CGRect imageViewFrame = self.imageView.frame;
            CGRect titleLabelFrame = self.titleLabel.frame;
            CGFloat totalHeight = imageViewFrame.size.height + self.verticalSpacing + titleLabelFrame.size.height;
            
            titleLabelFrame.origin.y = (self.frame.size.height - totalHeight) / 2 + self.topMarginOffset;
            imageViewFrame.origin.y = titleLabelFrame.origin.y + titleLabelFrame.size.height + self.verticalSpacing;
            
            titleLabelFrame.origin.x = (self.frame.size.width - titleLabelFrame.size.width) / 2;
            imageViewFrame.origin.x = (self.frame .size.width - imageViewFrame.size.width) / 2;
            
            self.titleLabel.frame = titleLabelFrame;
            self.imageView.frame = imageViewFrame;
        }
            break;
            
        case WBButtonStyleImageUpTextUnder: {
            //图片在上,文字在下
            CGRect imageViewFrame = self.imageView.frame;
            CGRect titleLabelFrame = self.titleLabel.frame;
            CGFloat totalHeight = imageViewFrame.size.height + self.verticalSpacing + titleLabelFrame.size.height;
            
            imageViewFrame.origin.y = (self.frame.size.height - totalHeight) / 2 + self.topMarginOffset;
            titleLabelFrame.origin.y = imageViewFrame.origin.y + imageViewFrame.size.height + self.verticalSpacing;

            imageViewFrame.origin.x = (self.frame .size.width - imageViewFrame.size.width) / 2;
            titleLabelFrame.origin.x = (self.frame.size.width - titleLabelFrame.size.width) / 2;
   
            self.titleLabel.frame = titleLabelFrame;
            self.imageView.frame = imageViewFrame;
        }
            break;
        case WBButtonStyleImageLeftTextRight: {
            //图片在左,文字在右
        }
            break;
        default:
            break;
    }

}

@end
