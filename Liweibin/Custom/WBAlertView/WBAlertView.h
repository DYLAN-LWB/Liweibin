//
//  WBAlertView.h


#import <UIKit/UIKit.h>


@class WBAlertView;
@protocol WBAlertViewDelegate <NSObject>
@optional

- (void)cancelButtonClickedOnAlertView:(WBAlertView *)alertView;
- (void)confirmButtonClickedOnAlertView:(WBAlertView *)alertView;

@end

@interface WBAlertView : UIView

@property (nonatomic, strong) id <WBAlertViewDelegate> delegate;

/** 自定义alert视图 */
@property (nonatomic, strong) UIView *contentView;
/** 自定义视图时是否隐藏按钮 */
@property (nonatomic, assign) BOOL hideButton;
/** 富文本 */
@property (nonatomic, copy) NSAttributedString *attributed;
/** 标题,按钮背景色*/
@property (nonatomic, strong) UIColor *customColor;

/** 普通的alertView */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
           confirmButtonTitle:(NSString *)confirmButtonTitle;

/** 动画进度展示 */
- (instancetype)initWithProgressOfTitle:(NSString *)title;

/** 正在制作, 加载无数据时图片提醒 ,注意:当上拉加载时 不展示 需判断数组count*/
+ (void)showNoDataImageToastToView:(UIView *)view;

/** 加载失败时图片提醒, 注意:当上拉加载时 不展示 需判断数组count
    当再次下拉刷新时, 如果有数据时, 要移除tag=9999的提醒图片 */
+ (void)showLoadFailedImageToastToView:(UIView *)view;

/** 文字toast提醒 */
+ (void)showMessageToast:(NSString *)message toView:(UIView *)view;

- (void)show;
- (void)dismiss;

@end


