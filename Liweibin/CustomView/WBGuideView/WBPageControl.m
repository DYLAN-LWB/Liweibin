//
//  WBPageControl.m
//  BeiSu
//
//  Created by 李伟宾 on 15/12/17.
//  Copyright © 2017年 李伟宾. All rights reserved.
//

#import "WBPageControl.h"

@implementation WBPageControl

- (void)setCurrentPage:(NSInteger)page {
    
    [super setCurrentPage:page];
    
    for (NSUInteger i = 0; i < self.subviews.count; i++) {
        
        UIView *dot = [self.subviews objectAtIndex:i];
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, 7, 7)];
        if (dot.subviews.count == 0) {
            UIImageView *view = [[UIImageView alloc]initWithFrame:dot.bounds];
            [dot addSubview:view];
        };
        
        UIImageView *imageView = dot.subviews[0];
        if (i == page) {
            imageView.image = [UIImage imageNamed:@"guide_circle_over"];
        } else {
            imageView.image = [UIImage imageNamed:@"guide_circle"];
        }
        dot.backgroundColor = [UIColor clearColor];
    }
}

@end
