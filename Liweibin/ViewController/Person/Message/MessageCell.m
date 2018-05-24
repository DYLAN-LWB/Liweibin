//
//  MessageCell.m
//  BeiSu
//
//  Created by 李伟宾 on 2017/9/26.
//  Copyright © 2017年 李伟宾. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *content;
@end

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = WB_Common.defaultBcakgroundColor;
        self.accessoryType = UITableViewCellSelectionStyleNone;

        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        
        self.icon = [[UIImageView alloc] init];
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        self.icon.layer.masksToBounds = YES;
        self.icon.image = [UIImage imageNamed:@"default_icon"];
        [self.bgView addSubview:self.icon];
        
        self.name = [[UILabel alloc] init];
        self.name.font = WBFont(16);
        self.name.textColor = WB_Common.defaultThemeColor;
        self.name.numberOfLines = 0;
        [self.bgView addSubview:self.name];
        
        self.time = [[UILabel alloc] init];
        self.time.font = WBFont(14);
        self.time.textColor = [UIColor grayColor];
        [self.bgView addSubview:self.time];
        
        self.content = [[UILabel alloc] init];
        self.content.font = WBFont(15);
        self.content.numberOfLines = 0;
        self.content.textColor = [UIColor darkGrayColor];
        [self.bgView addSubview:self.content];
    }
    return self;
}

- (void)setModel:(MessageModel *)model {
    self.name.text = model.title;
    self.time.text = model.create_time;
    self.content.text = model.content;

    self.icon.frame = CGRectMake(WBFit(6.5), WBFit(6.5), WBFit(45), WBFit(45));

    CGSize size1 = [WBTools sizeWithText:self.name.text width:WBFit(300) height:CGFLOAT_MAX font:WBFont(16)];
    self.name.frame = CGRectMake(WBFit(65), WBFit(6.5), WBFit(300), size1.height);

    self.time.frame = CGRectMake(WBFit(65), CGRectGetMaxY(self.name.frame) + WBFit(5), WBFit(260), WBFit(15));

    CGSize size = [WBTools sizeWithText:self.content.text width:WBFit(300) height:CGFLOAT_MAX font:WBFont(15)];
    self.content.frame = CGRectMake(WBFit(65), CGRectGetMaxY(self.time.frame) + WBFit(5), WBFit(300), size.height);
    
    self.bgView.frame = CGRectMake(WBFit(13), WBFit(13), WB_Common.screenWidth - WBFit(26), WBFit(10)+CGRectGetMaxY(self.content.frame));
}

@end
