//
//  WBModel.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/12.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBModel.h"

@interface WBModel : NSObject
@property (nonatomic, assign) int code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSMutableArray *data;

+ (instancetype)modelWithKeyValues:(id)keyValues;
@end

@interface WBDictModel : NSObject
@property (nonatomic, assign) int code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSDictionary *data;

+ (instancetype)modelWithKeyValues:(id)keyValues;
@end

