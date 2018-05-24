//
//  DiscoverViewController.m
//  Beisu
//
//  Created by 李伟宾 on 16/4/27.
//  Copyright © 2016年 李伟宾. All rights reserved.
//

#import "DiscoverViewController.h"
#import "WBWebViewController.h"
#import "DiscoverCell.h"


@interface DiscoverViewController () <UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tableView;
    WBModel *_model;
}

@end

@implementation DiscoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = WB_Common.defaultBcakgroundColor;
    self.navTitle = @"发现";
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, WB_Common.navHeight, WB_Common.screenWidth, WB_Common.screenHeight - WB_Common.navHeight);
    _tableView.backgroundColor = WB_Common.defaultBcakgroundColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorInset  = UIEdgeInsetsZero;
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.rowHeight       = WBFit(55);
    _tableView.scrollEnabled   = NO;
    [self.view addSubview:_tableView];
    

    [[WBNetwork networkManger] requestGet:WB_Network.discoverlist
                                  success:^(id response) {
                                      _model = [WBModel modelWithKeyValues:response];
                                      if (_model.code == 0) {
                                          [_tableView reloadData];
                                      }
                                  } failure:^(NSError *error) {
                                      [WBAlertView showMessageToast:WB_Network.errorMsg toView:self.view];
                                  }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_model.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[DiscoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model = [DiscoverModel modelWithKeyValues:_model.data[indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DiscoverModel *_discoverModel = [DiscoverModel modelWithKeyValues:_model.data[indexPath.row]];
    WBWebViewController *web = [[WBWebViewController alloc] init];
    web.detailUrl = _discoverModel.disurl;
    web.detailTitle =  _discoverModel.disname;
    [self.navigationController pushViewController:web animated:YES];
}

@end
