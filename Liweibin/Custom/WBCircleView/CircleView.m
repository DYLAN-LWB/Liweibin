//
//  CircleView.m
//  CircleCountDown
//
//  Created by Zin_戦 on 16/6/26.
//  Copyright © 2016年 Zin戦壕. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

//        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 , 30, 30)];
//        _timeLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_timeLabel];
    }
    return self;
}

- (void)setBegin:(BOOL)begin {
    [self time];
}

- (void)drawRect:(CGRect)rect
{
    //获得上下文对象，只要是用CoreGraphics就必须要
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, WBFit(3));//线宽
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.5);  //颜色

    //CGContextAddArc(上下文对象,圆心x,圆心y,曲线开始点,曲线结束点,半径);
    CGContextAddArc(context,    //上下文对象
                    self.frame.size.width/2.0,  //圆心x
                    self.frame.size.height/2.0, //圆心y
                    self.bounds.size.width/2.0 - WBFit(3), 0 , //曲线开始点
                    self.count/300.0 * 2 * M_PI, 0); //
   
    CGContextStrokePath(context);
}

- (void)time {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(action) userInfo:nil repeats:YES];
}

- (void)action{
    self.count++;//时间累加
    
    //100=1秒
    if (self.count == 300) {
        //到达时间以后取消定时器
        [self.timer invalidate];
        self.timer = nil;
    }
    if (self.count%100 == 0) {
        NSLog(@"---%@",[NSString stringWithFormat:@"%ld",3 - self.count/100]);
    }
    [self setNeedsDisplay];
}
@end
