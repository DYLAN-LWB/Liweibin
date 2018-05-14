//
//  WBTools.h
//  Liweibin
//
//  Created by 李伟宾 on 2017/9/25.
//  Copyright © 2017年 李伟宾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface WBTools : NSObject

//计算文字宽度/高度
+ (CGSize)sizeWithText:(NSString *)text width:(CGFloat)width height:(CGFloat)height font:(UIFont *)font;

//颜色代码
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue;

//把字典转为json字符串
+ (NSString *)jsonWithDict:(NSDictionary *)dict;

//把json字符串转为字典
+ (NSDictionary *)dictWithJson:(NSString *)jsonString;

//把json字符串转为数组
+ (NSArray *)arrayWithJson:(NSString *)jsonStr;

//把数组转为json字符串
+ (NSString *)arrayToJSONString:(NSArray *)array;

//返回UTF8编码的字符串
+ (NSString *)stringEncodingWithString:(NSString *)string;

@end

