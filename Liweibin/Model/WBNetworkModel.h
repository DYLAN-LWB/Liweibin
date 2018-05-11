//
//  WBNetwork.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/5/11.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBNetworkModel : NSObject

- (void)initNetworkInterface;

@property (nonatomic , copy) NSString   *errorMsg;
@property (nonatomic , copy) NSString   *userIsRegist;

@end
