//
//  MessageModel.h
//  BeiSu
//
//  Created by 李伟宾 on 2017/9/26.
//  Copyright © 2017年 李伟宾. All rights reserved.
//

#import "WBTools.h"

@interface MessageModel : WBModel
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * isRead;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * pid;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * isall;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * kind;

@end
