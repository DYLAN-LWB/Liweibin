//
//  DiscoverCell.m
//  BeiSu
//
//  Created by 李伟宾 on 2017/9/25.
//  Copyright © 2017年 李伟宾. All rights reserved.
//

#import "DiscoverCell.h"

@interface DiscoverCell ()

@end

@implementation DiscoverCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.font = WBFont(20);
    }
    return self;
}

- (void)setModel:(DiscoverModel *)model {
    
    self.textLabel.text = model.disname;

    if (WBInteger(model.is_new) == 1) {
        CGSize size = [WBTools sizeWithText:self.textLabel.text width:MAXFLOAT height:WBFit(55) font:WBFont(20)];

        UIImageView *newIV = [[UIImageView alloc] init];
        newIV.image = [UIImage imageNamed:@"discover_new"];
        newIV.frame = CGRectMake(size.width + WBFit(40), WBFit(20), WBFit(30), WBFit(15));
        [self addSubview:newIV];
    }
}

@end
