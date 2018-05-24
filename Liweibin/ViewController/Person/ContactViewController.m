//
//  ContactViewController.m
//  BeiSu
//
//  Created by 李伟宾 on 2018/3/15.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "ContactViewController.h"

#define cellHeight WBFit(60)

static  NSString *qq       = @"QQ客服";
static  NSString *wechat   = @"微信客服";
static  NSString *phone    = @"电话客服";

@interface ContactViewController ()
<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_titleA;
    NSDictionary *_infoDict;
}
@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WB_Common.defaultBcakgroundColor;
    self.navTitle = @"联系我们";
    _titleA = @[qq,wechat,phone];
    _infoDict = @{
                  @"QQ":@"2760811881",
                  @"weixin":@"beisuxiaodian",
                  @"phone":@"010-82378880-203",
                  };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WB_Common.navHeight, WB_Common.screenWidth, cellHeight*5) style:UITableViewStylePlain];
    _tableView.backgroundColor = WB_Common.defaultBcakgroundColor;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.rowHeight       = cellHeight;
    _tableView.scrollEnabled   = NO;
    [self.view addSubview:_tableView];
    
//    [WBRequestManager requestWithMethod:HTTP_GET
//                                    url:Http_ContactUs
//                                 params:nil
//                                success:^(id response) {
//                                    if (WBInteger(response[@"code"]) == 0) {
//                                        _infoDict = response[@"data"];
//                                        [_tableView reloadData];
//                                    }
//                                }
//                                failure:^(NSError *error) {}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleA.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(WBFit(20), 0, WB_Common.screenWidth - WBFit(150), cellHeight);
    label.font = WBFont(18);
    [cell.contentView addSubview:label];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, cellHeight - 1, WB_Common.screenWidth, 1);
    line.backgroundColor = WB_Common.defaultBcakgroundColor;
    [cell.contentView addSubview:line];
    
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.frame = CGRectMake(WB_Common.screenWidth - WBFit(100), WBFit(15), WBFit(90), cellHeight-WBFit(30));
    actionButton.titleLabel.font = WBFont(16);
    actionButton.layer.cornerRadius = 5;
    actionButton.tag = indexPath.row;
    [actionButton addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    actionButton.backgroundColor = WB_Common.defaultThemeColor;
    [cell.contentView addSubview:actionButton];
    
    if (indexPath.row == 0) {
        label.text  = [NSString stringWithFormat:@"%@：%@", _titleA[indexPath.row], _infoDict[@"QQ"]];
        [actionButton setTitle:@"立即联系" forState:UIControlStateNormal];
    } else if (indexPath.row == 1) {
        label.text  = [NSString stringWithFormat:@"%@：%@", _titleA[indexPath.row], _infoDict[@"weixin"]];
        [actionButton setTitle:@"复制微信" forState:UIControlStateNormal];
    } else if (indexPath.row == 2) {
        label.text  = [NSString stringWithFormat:@"%@：%@", _titleA[indexPath.row], _infoDict[@"phone"]];
        [actionButton setTitle:@"立即拨打" forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)actionButton:(UIButton *)button {
    if (button.tag == 0) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web", _infoDict[@"QQ"]]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [webView loadRequest:request];
            [self.view addSubview:webView];
        } else{
            [WBAlertView showMessageToast:@"请先安装QQ客户端" toView:self.view];
        }
    } else if (button.tag == 1) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _infoDict[@"weixin"];
        [WBAlertView showMessageToast:@"微信号已复制到剪贴板" toView:self.view];

    } else if (button.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", _infoDict[@"phone"]]]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

