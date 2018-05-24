//
//  WBWebViewController.h
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "WBBaseViewController.h"

@interface WBWebViewController : WBBaseViewController
@property (nonatomic, copy) NSString *detailTitle;
@property (nonatomic, copy) NSString *shareContent;
@property (nonatomic, copy) NSString *detailUrl;
@property (nonatomic, copy) NSString *detailImageUrl;



@property (nonatomic, assign) BOOL hasParam;



@end
