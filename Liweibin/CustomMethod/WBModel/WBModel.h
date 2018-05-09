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
@property (nonatomic, strong) id data;

//通过字典来创建一个模型
+ (instancetype)modelWithKeyValues:(id)keyValues;

@end

@interface WBUser : WBModel
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * integral;
@property (nonatomic , copy) NSString              * login_time;
@property (nonatomic , copy) NSString              * invite_code;
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * game_img;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * gradename;
@property (nonatomic , copy) NSString              * studycourses;
@property (nonatomic , copy) NSString              * school;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * qrcode;
@property (nonatomic , copy) NSString              * wechat;
@property (nonatomic , copy) NSString              * regchannel;
@property (nonatomic , copy) NSString              * addquiz;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * regsource;
@property (nonatomic , copy) NSString              * perfectinfo;
@property (nonatomic , copy) NSString              * originavatar;
@property (nonatomic , copy) NSString              * address_id;
@property (nonatomic , copy) NSString              * last_time;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * tokenid;
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * istasklistread;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * age;
@property (nonatomic , copy) NSString              * qq;
@property (nonatomic , copy) NSString              * grade_id;

@end
