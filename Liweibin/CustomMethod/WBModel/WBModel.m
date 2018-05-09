//
//  WBModel.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/12.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBModel.h"
#import "MJExtension.h"

@implementation WBModel

+ (instancetype)modelWithKeyValues:(id)keyValues {
    return [self mj_objectWithKeyValues:keyValues context:nil];
}


@end

@implementation WBUser

@end
