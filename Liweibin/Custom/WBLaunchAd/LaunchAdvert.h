//
//  LaunchAdvert.h
//  BeiSu
//
//  Created by 李伟宾 on 2017/10/17.
//  Copyright © 2017年 李伟宾. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CountDownTime  3

@interface LaunchAdvert : UIImageView

// 1全屏 2倍速小店商品 
@property (nonatomic, assign) NSInteger advertType;

//广告数据
@property (nonatomic, strong) NSDictionary *adInfoDict;

@end
