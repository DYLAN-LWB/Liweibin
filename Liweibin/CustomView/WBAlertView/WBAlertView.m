//
//  WBAlertView.m


#import "WBAlertView.h"

#define IS_IOS_8_OR_HIGHER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


#define buttonHeight    35      //按钮高度
#define titleHeight     35      //标题高度
#define blackMaskAlpha  0.5     //蒙版透明度
#define viewPadding     WBFit(20) //间隙


@interface WBAlertView ()
{
    CGFloat     _alertWidth;
    CGFloat     _alertHeight;

    UIView      *_blackMaskView;    //黑色背景蒙版
    UILabel     *_titleLabel;       //标题
    UILabel     *_messageLabel;     //内容
    UIButton    *_cancelButton;     //取消按钮
    UIButton    *_confirmButton;    //确定按钮
    UIButton    *_closeButton;

    BOOL    _hasContentView;    //是否添加了自定义视图
    BOOL    _hasHideButton;     //是否隐藏按钮
    BOOL    _isProgress;        //是否是动画进度
    
    UITableView      *_tableView;
    UICollectionView *_collectionView;
    
    UILabel  *_toastLabel;
}

@end

@implementation WBAlertView

#pragma mark - 图片progress

- (instancetype)initWithProgressOfTitle:(NSString *)title {
    
    _alertWidth = WBFit(125);
    _alertHeight = WBFit(125) + 30;
    
    self = [super initWithFrame:CGRectMake(0, 0, _alertWidth, _alertHeight)];
    if (self) {

        _isProgress = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WBFit(97.5), WBFit(127.5))];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.userInteractionEnabled = YES;
        
        CGPoint center = CGPointMake(_alertWidth/2, imageView.frame.size.height/2);
        imageView.center = center;
        
        NSMutableArray *imageAarry = [NSMutableArray array];
        for (int i = 1; i < 13; i++) {
            [imageAarry addObject:[UIImage imageNamed:[NSString stringWithFormat:@"bei%d",i]]];
        }
        imageView.animationImages = imageAarry;
        imageView.animationDuration = 0.3;
        imageView.animationRepeatCount = 0;
        [imageView startAnimating];
        
        //内容
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-60, _alertHeight - 30, _alertWidth+100, 50)];
        label.numberOfLines = 0;
        label.font = WBFont(17);
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [imageView addSubview: label];
        
        self.contentView  = imageView;
    }
    return self;
}

#pragma mark - 加载失败时展示图片提醒

+ (void)showNoDataImageToastToView:(UIView *)view {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, AppManger.common.screenWidth, WBFit(70))];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 2;
    titleLabel.tag = 9999;
    titleLabel.text = @"正在努力制作中\n敬请期待哦～";
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = WBFont(20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(AppManger.common.screenWidth*0.5, AppManger.common.screenHeight*0.3);
    [view addSubview:titleLabel];
    
    //150 200
    NSMutableArray *imageAarry = [NSMutableArray array];
    for (int i = 1; i < 13; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bei%d",i]];
        [imageAarry addObject:image];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WBFit(115), WBFit(115)*1.3)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.userInteractionEnabled = YES;
    imageView.animationImages = imageAarry;
    imageView.animationDuration = 0.3;
    imageView.animationRepeatCount = 0;
    imageView.tag = 9999;
    imageView.center = CGPointMake(AppManger.common.screenWidth*0.5, AppManger.common.screenHeight*0.45);
    [imageView startAnimating];
    [view addSubview:imageView];
}

/**
 用户无记录 - 无记录 1001
 网络连接失败 - 页面加载失败 下拉刷新 1000
 系统消息 - 暂时没有系统消息 1003
 课程评论列表 - 暂时没有评论 1002
 收藏 - 您还没有收藏任何课程/资料 1004 1005
 提问 - 您还没有发表过任何提问 1006
 */
+ (void)showLoadFailedImageToastToView:(UIView *)view {

    NSString *toast = @"页面加载失败 下拉刷新";
    switch (view.tag) {
        case 1002: toast = @"暂时还没有评论"; break;
        case 1003: toast = @"暂时没有系统消息"; break;
        case 1004: toast = @"您还没有收藏课程"; break;
        case 1005: toast = @"您还没有收藏资料"; break;
        case 1006: toast = @"您还没有发表过提问"; break;
        case 1007: toast = @"没有搜索结果\n换其他关键字试试～"; break;
        case 1008: toast = @"暂时还没有评论"; break;
        case 1009: toast = @"暂时还没有排行榜信息哦"; break;
        case 2323: toast = @"没有兑换记录"; break;
        case 1102: toast = @"您还没有学习过课程"; break;

        default: break;
    }

    //144 150
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WBFit(115), WBFit(121))];
    imageView.image = [UIImage imageNamed:@"loadfailed"];
    imageView.center = CGPointMake(view.frame.size.width*0.5, view.frame.size.height*0.43);
    imageView.tag = 9999;
    [view addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(imageView.frame)- WBFit(65), view.frame.size.width, WBFit(65))];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = toast;
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = WBFont(20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.tag = 9999;
    titleLabel.numberOfLines = 0;
    [view addSubview:titleLabel];
}


#pragma mark - 文字提醒

+ (void)showMessageToast:(NSString *)message toView:(UIView *)view {
    [[[self alloc] init] alertShowMessageToast:message toView:view];
}

- (void)alertShowMessageToast:(NSString *)message toView:(UIView *)view {
    
    for (UIView *label in view.subviews) {

        if (label.tag == 8346) {
            [label removeFromSuperview];
        }
    }
    
    _toastLabel = [[UILabel alloc] init];
    _toastLabel.frame = CGRectMake(0, 0, 200, WBFit(45));
    _toastLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.66];
    _toastLabel.text = message;
    _toastLabel.textColor = [UIColor whiteColor];
    _toastLabel.textAlignment = NSTextAlignmentCenter;
    _toastLabel.layer.masksToBounds = YES;
    _toastLabel.layer.cornerRadius = 8;
    _toastLabel.font = WBFont(18);
    _toastLabel.tag = 8346;
    [view addSubview:_toastLabel];
    
    CGSize size = [message boundingRectWithSize:CGSizeMake(AppManger.common.screenWidth - 20, _toastLabel.frame.size.height)
                                        options: NSStringDrawingTruncatesLastVisibleLine
                                     attributes:@{ NSFontAttributeName:_toastLabel.font }
                                        context:nil].size;
    CGRect frame = _toastLabel.frame;
    frame.size.width = size.width + 40;
    _toastLabel.frame = frame;
    
    CGPoint center = _toastLabel.center;
    center = CGPointMake(AppManger.common.screenWidth/2, AppManger.common.screenHeight*0.5);
    _toastLabel.center = center;
    
    _toastLabel.alpha = 0.3;
    [UIView animateWithDuration:0.5 animations:^{
        _toastLabel.alpha = 1;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            _toastLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [_toastLabel removeFromSuperview];
        }];
    });
}

#pragma mark - 普通的alert

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)otherButtonTitle {
    _alertWidth = WBFit(325);
    _alertHeight = WBFit(195);
    
    self = [super initWithFrame:CGRectMake(0, 0, _alertWidth, _alertHeight)];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        
        //默认不隐藏按钮
        _hasHideButton = NO;
        
        if (!title) {
            title = @"温馨提示";
        }
        //标题
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = WBFont(20);
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = AppManger.common.defaultThemeColor;
        
        //内容
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = WBFont(18);
        _messageLabel.text = message;
        if (message.length < 15) {
            _messageLabel.textAlignment = NSTextAlignmentCenter;
        } else {
            _messageLabel.textAlignment = NSTextAlignmentLeft;
        }
        _messageLabel.textColor = [UIColor darkGrayColor];
        
        if (cancelButtonTitle) {
            // 取消按钮
            _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _cancelButton.layer.cornerRadius = 5;
            _cancelButton.titleLabel.font = WBFont(18);
            [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [_cancelButton setTitleColor:AppManger.common.defaultThemeColor forState:UIControlStateNormal];
            [_cancelButton setBackgroundColor:[UIColor whiteColor]];
            [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            _cancelButton.layer.masksToBounds = YES;
            _cancelButton.layer.borderWidth = 1;
            _cancelButton.layer.borderColor = AppManger.common.defaultThemeColor.CGColor;
        }
        
        if (otherButtonTitle) {
            //确定按钮
            _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _confirmButton.layer.cornerRadius = 5;
            _confirmButton.titleLabel.font = WBFont(18);
            [_confirmButton setTitle:otherButtonTitle forState:UIControlStateNormal];
            [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_confirmButton setBackgroundColor:AppManger.common.defaultThemeColor];
            [_confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    return self;
}

#pragma mark - 视图出现/消失

- (void)show {

    UIView *window = [[[UIApplication sharedApplication] delegate] window];
    UIView *superView = IS_IOS_8_OR_HIGHER ? window : ([[window subviews] lastObject]);
    
    _blackMaskView = [[UIView alloc] initWithFrame:window.bounds];
    _blackMaskView.backgroundColor = [UIColor colorWithWhite:0 alpha:blackMaskAlpha];
    
    if (self.tag != 743) {
        
        [_blackMaskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewRestureRecognizer:)]];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismiss];
        });
    }

    [superView addSubview:_blackMaskView];
    
    //刷新frame
    [self reloadFrame];
    
    //内容label适配
    if (_titleLabel.text) {
        [_messageLabel sizeToFit];
        CGRect myFrame = _messageLabel.frame;
        myFrame = CGRectMake(myFrame.origin.x, myFrame.origin.y + viewPadding , _alertWidth -  2 * viewPadding, myFrame.size.height);
        _messageLabel.frame = myFrame;
    }
    
    if (!_hasContentView) {
        [self addSubview:_titleLabel];
        [self addSubview:_messageLabel];
    }
    
    if (self.tag == 1532) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(_alertWidth - WBFit(40), 0, WBFit(40), WBFit(40));
        [_closeButton setImage:[UIImage imageNamed:@"off_btn"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
    }
    
    if (!_hasHideButton) {
        [self addSubview:_cancelButton];
        [self addSubview:_confirmButton];
    }
    
    self.frame = CGRectMake((superView.frame.size.width - self.frame.size.width )/2,
                            (superView.frame.size.height - self.frame.size.height) /2,
                            self.frame.size.width,
                            self.frame.size.height);
    
    
    [superView addSubview:self];
    
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0.6;

    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)closeButtonClick {
    [self dismiss];
}

- (void)touchViewRestureRecognizer:(UITapGestureRecognizer*)recognizer {
    [self dismiss];
}

- (void)dismiss {
    
    self.transform = CGAffineTransformIdentity;
    
    [self removeFromSuperview];

    
    if (_blackMaskView) {
        [UIView animateWithDuration:0.1 animations:^{
            _blackMaskView.alpha = 0;
        } completion:^(BOOL finished) {
            [_blackMaskView removeFromSuperview];
        }];
    }
}

#pragma mark - 刷新控件frame

- (void)reloadFrame {

    if (!_hasContentView) {
        
        _titleLabel.frame = _titleLabel.text ? CGRectMake(0, 0, _alertWidth, titleHeight+WBFit(13)) : CGRectZero;

        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, titleHeight, WBFit(13), WBFit(13))];
        view1.backgroundColor = AppManger.common.defaultThemeColor;
        [self addSubview:view1];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(_alertWidth - WBFit(13), titleHeight, WBFit(13), WBFit(13))];
        view2.backgroundColor = AppManger.common.defaultThemeColor;
        [self addSubview:view2];
        
        //根据内容文字长度来计算视图高度
        CGFloat messageHeight = [_messageLabel.text boundingRectWithSize:CGSizeMake(_alertWidth - viewPadding * 2, FLT_MAX)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:@{NSFontAttributeName:_messageLabel.font ? _messageLabel.font : WBFont(18)}
                                                                 context:nil].size.height;
        
        _alertHeight = messageHeight + _titleLabel.frame.size.height + buttonHeight + viewPadding*5;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _alertHeight);
        
        
        _messageLabel.frame = _messageLabel.text ? CGRectMake(viewPadding,
                                                              _titleLabel.frame.size.height + viewPadding,
                                                              _alertWidth - viewPadding * 2,
                                                              messageHeight) : CGRectZero;
    }

    
    _cancelButton.frame = _confirmButton ? CGRectMake(viewPadding,
                                                      _alertHeight - buttonHeight - viewPadding,
                                                      _alertWidth / 2 - viewPadding*2,
                                                      buttonHeight) : CGRectMake(_alertWidth*0.25,
                                                                                 _alertHeight - buttonHeight - viewPadding,
                                                                                 _alertWidth*0.5,
                                                                                 buttonHeight);
    
    _confirmButton.frame = _cancelButton ?  CGRectMake(_alertWidth / 2 + viewPadding,
                                                       _alertHeight - buttonHeight - viewPadding,
                                                       _alertWidth / 2 - viewPadding*2,
                                                       buttonHeight) : CGRectMake(_alertWidth*0.25,
                                                                                  _alertHeight - buttonHeight - viewPadding,
                                                                                  _alertWidth*0.5,
                                                                                  buttonHeight);
    
    
    _titleLabel.layer.masksToBounds = YES;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_titleLabel.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(5,5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _titleLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    _titleLabel.layer.mask = maskLayer;
}

#pragma mark - 重写set方法

- (void)setContentView:(UIView *)contentView {
    
    _hasContentView = YES;
    _alertWidth  = contentView.frame.size.width;
    _alertHeight = contentView.frame.size.height;

    contentView.frame = contentView.bounds;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _alertWidth, _alertHeight);
    
    contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    if (contentView.tag == 2500) {
        self.backgroundColor = [UIColor whiteColor];
    }
    [self addSubview:contentView];
    
    [self reloadFrame];
}

- (void)setHideButton:(BOOL)hideButton {
    _hasHideButton = hideButton;
}

- (void)setAttributed:(NSAttributedString *)attributed {
    _messageLabel.attributedText = attributed;
}

- (void)setCustomColor:(UIColor *)customColor {
    _titleLabel.backgroundColor = customColor;
    [_cancelButton setTitleColor:customColor forState:UIControlStateNormal];
    _cancelButton.layer.borderColor = customColor.CGColor;
    [_confirmButton setBackgroundColor:customColor];
}

#pragma mark - 代理方法

- (void)cancelButtonClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(cancelButtonClickedOnAlertView:)]) {
        [self.delegate cancelButtonClickedOnAlertView:self];
    }
    
    [self dismiss];
}

- (void)confirmButtonClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(confirmButtonClickedOnAlertView:)]) {
        [self.delegate confirmButtonClickedOnAlertView:self];
    }
    
    [self dismiss];
}

@end
