//
//  WBBaseViewController.h
//  Beisu
//
//  Created by 李伟宾 on 16/5/10.
//  Copyright © 2016年 李伟宾. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WBBaseViewController : UIViewController

/** 自定义nav视图 */
@property (nonatomic, strong) UIView *navigationView;
/** 标题 */
@property (nonatomic, copy) NSString *navTitle;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *navBackButton;

@end
