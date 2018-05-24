//
//  MessageViewController.m
//  Beisu
//
//  Created by 李伟宾 on 16/1/29.
//  Copyright © 2016年 李伟宾. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "WBWebViewController.h"


@interface MessageViewController ()
<UITableViewDelegate, UITableViewDataSource,
WBAlertViewDelegate>

{
    UITableView     *_tableView;
    WBModel         *_dataModel;
    NSInteger       _pageNumber;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WB_Common.defaultBcakgroundColor;
    self.navTitle = @"消息";
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(WB_Common.screenWidth - 54, WB_Common.navHeight-44, 54, 44)];
    [rightButton setImage:[UIImage imageNamed:@"delete_btn"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:rightButton];
    
    [self setUpTableView];
    [self setUpHeaderRefresh];
    
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) {
        WBAlertView *alert = [[WBAlertView alloc] initWithTitle:nil message:@"请打开系统的消息通知功能，才能收到我们的消息哦~" cancelButtonTitle:@"取消" confirmButtonTitle:@"去打开"];
        alert.delegate = self;
        alert.tag = 2;
        [alert show];
    }
}

- (void)setUpHeaderRefresh {
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNumber = 1;
        [_tableView.mj_footer endRefreshing];
        [self getReplyInfoWithPage:_pageNumber];
    }];
    
    [_tableView.mj_header beginRefreshing];
}

- (void)setUpFooterRefresh {
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [_tableView.mj_header endRefreshing];
        [self getReplyInfoWithPage:++_pageNumber];
    }];
}

- (void)getReplyInfoWithPage:(NSInteger)page {
    _tableView.tag = 1003;
//
//    NSString *url = [NSString stringWithFormat:@"%@/page/%ld",Http_SystemMsg, page];
//    [WBRequestManager requestWithMethod:HTTP_GET url:url params:nil
//                                success:^(id response) {
//
//                                    for (UIView *view in _tableView.subviews) {
//                                        if (view.tag == 9999)  [view removeFromSuperview];
//                                    }
//
//                                    WBModel *model = [WBModel modelWithKeyValues:response];
//                                    if (model.code == 0) {
//                                        if (_pageNumber == 1) {
//                                            _dataModel = [WBModel modelWithKeyValues:response];
//                                        } else {
//                                            [_dataModel.data addObjectsFromArray:model.data];
//                                        }
//
//                                        [_tableView reloadData];
//
//                                        if (_dataModel.data.count > 9 && !_tableView.mj_footer) {
//                                            [self setUpFooterRefresh];
//                                        }
//
//                                    } else {
//
//                                        if (_dataModel.data.count == 0) {
//                                            [WBAlertView showLoadFailedImageToastToView:_tableView];
//                                        }
//                                    }
//                                    [_tableView.mj_header endRefreshing];
//                                    [_tableView.mj_footer endRefreshing];
//                                }
//                                failure:^(NSError *error) {
//                                    for (UIView *view in _tableView.subviews) {
//                                        if (view.tag == 9999)  [view removeFromSuperview];
//                                    }
//                                    if (_dataModel.data.count == 0) {
//                                        [WBAlertView showLoadFailedImageToastToView:_tableView];
//                                    }
//                                    [_tableView.mj_header endRefreshing];
//                                    [_tableView.mj_footer endRefreshing];
//                                }];
}

- (void)rightItemClick {
    
    WBAlertView *alert = [[WBAlertView alloc] initWithTitle:nil message:@"确定清空系统消息吗？" cancelButtonTitle:@"取消" confirmButtonTitle:@"清空"];
    alert.delegate = self;
    [alert show];
}

- (void)confirmButtonClickedOnAlertView:(WBAlertView *)alertView {
    if (alertView.tag == 2) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
//        [WBRequestManager requestWithMethod:HTTP_GET
//                                        url:Http_DeleteSystemMsg
//                                     params:nil
//                                    success:^(id response) {
//                                        
//                                        if (WBInteger(response[@"code"]) == 0) {
//                                            [_tableView.mj_header beginRefreshing];
//                                        }
//                                    }
//                                    failure:^(NSError *error) { }];
    }
}

- (void)setUpTableView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, WB_Common.navHeight, WB_Common.screenWidth, WB_Common.screenHeight - WB_Common.navHeight);
    _tableView.backgroundColor = WB_Common.defaultBcakgroundColor;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataModel.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model = [MessageModel modelWithKeyValues:_dataModel.data[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageModel *model = [MessageModel modelWithKeyValues:_dataModel.data[indexPath.row]];
    
    CGSize size1 = [WBTools sizeWithText:model.title width:WBFit(300) height:CGFLOAT_MAX font:WBFont(16)];
    CGSize size = [WBTools sizeWithText:model.content width:WBFit(300) height:CGFLOAT_MAX font:WBFont(15)];
    return size.height + size1.height + WBFit(55);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageModel *model = [MessageModel modelWithKeyValues:_dataModel.data[indexPath.row]];
    if (WBInteger(model.kind) == 2) {
        WBWebViewController *web = [[WBWebViewController alloc] init];
        web.detailUrl = model.url;
        [self.navigationController pushViewController:web animated:YES];
    }
}


@end
