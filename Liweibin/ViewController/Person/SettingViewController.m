//
//  SettingViewController.m
//  Beisu
//
//  Created by 李伟宾 on 16/1/29.
//  Copyright © 2016年 李伟宾. All rights reserved.
//

#import "SettingViewController.h"
#import "FeedbackViewController.h"
#import "SDImageCache.h"
#import "WBNetworkCache.h"
#import "WBClearCache.h"

#define cellHeight WBFit(55)

@interface SettingViewController ()
<UITableViewDelegate, UITableViewDataSource>

{
    UITableView *_tableView;
    NSArray *_titleA;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WB_Common.defaultBcakgroundColor;
    self.navTitle = @"设置";
    _titleA = @[@[@"", @"修改密码"], @[@"意见反馈"]];

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WB_Common.navHeight, WB_Common.screenWidth, cellHeight * 5 + WBFit(52)) style:UITableViewStylePlain];
    _tableView.backgroundColor = WB_Common.defaultBcakgroundColor;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.rowHeight       = cellHeight;
    _tableView.scrollEnabled   = NO;
    [self.view addSubview:_tableView];
    
    
    UIButton *takeOffButton = [[UIButton alloc] init];
    takeOffButton.frame = CGRectMake(50, CGRectGetMaxY(_tableView.frame) + cellHeight, WB_Common.screenWidth - 100, WBFit(45));
    [takeOffButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [takeOffButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    takeOffButton.titleLabel.textAlignment   = NSTextAlignmentCenter;
    takeOffButton.titleLabel.font = WBFont(18);
    takeOffButton.layer.cornerRadius = 10;
    takeOffButton.backgroundColor = WB_Common.defaultThemeColor;
    [takeOffButton addTarget:self action:@selector(takeOffButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takeOffButton];
}

- (void)takeOffButtonClick {
    
    [WB_Manger loginOut];

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleA.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleA[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section ==0 && indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(25, 0, 200, cellHeight);
    label.text  = _titleA[indexPath.section][indexPath.row];
    label.font = WBFont(18);
    [cell.contentView addSubview:label];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, cellHeight - 1, WB_Common.screenWidth, 1);
    line.backgroundColor = WB_Common.defaultBcakgroundColor;
    [cell.contentView addSubview:line];
    
    if ([label.text isEqualToString:@"联系电话客服"]) {
        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, WB_Common.screenWidth - 120 - 35, cellHeight)];
        subLabel.text  = self.servicePhone;
        subLabel.font = WBFont(17);
        subLabel.textColor = [UIColor colorWithWhite:0.424 alpha:1.000];
        subLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:subLabel];
    }
    
    if ([label.text isEqualToString:@"清除缓存"]) {
        //    //获取缓存图片的大小(字节)
        NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
        CGFloat MBCache = bytesCache/1000/1000;//换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
        NSLog(@"%f", MBCache);

        //Library/Caches:
//        NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//        NSString *cache = [WBClearCache getCacheSizeWithFilePath:cachesPath];
//        cache = [cache stringByReplacingOccurrencesOfString:@"M" withString:@""];
//        NSLog(@"%@", cache);
        
        //接口缓存
        NSString *urlCache = [WBNetworkCache cacheSizeFormat];
        urlCache = [urlCache stringByReplacingOccurrencesOfString:@"M" withString:@""];
        NSLog(@"%@", urlCache);

        //tmp
//        NSString *tmpPath = NSTemporaryDirectory();
//        NSString *tmp = [WBNetworkCache getCacheSizeWithFilePath:tmpPath];
//        tmp = [tmp stringByReplacingOccurrencesOfString:@"M" withString:@""];
//        NSLog(@"%@", tmp);

//        CGFloat total = MBCache + [urlCache floatValue] + [tmp floatValue];

//        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, WB_Common.screenWidth - 120 - 35, cellHeight)];
//        subLabel.text  = [NSString stringWithFormat:@"%.2fM", total];
//        subLabel.font = WBFont(17);
//        subLabel.textColor = [UIColor colorWithWhite:0.424 alpha:1.000];
//        subLabel.textAlignment = NSTextAlignmentRight;
//        [cell.contentView addSubview:subLabel];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {


        }
    } else {
        if (indexPath.row == 0) {
            FeedbackViewController *feedBack = [[FeedbackViewController alloc] init];
            [self.navigationController pushViewController:feedBack animated:YES];
        } else if (indexPath.row == 1) {
            NSString *str = @"itms-apps://itunes.apple.com/cn/app/bei-su-ke-tang/id1079725911?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        } else if (indexPath.row == 2) {
            [self clearCache];
        }
    }
}

- (void)clearCache {

    //图片缓存
//    [[SDImageCache sharedImageCache] clearDisk];
    
    //library-cache 存放体积大又不需要备份的数据 //已下载的html静态项目不能清理哦
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    [WBClearCache clearCacheWithFilePath:cachesPath];
    
    //接口缓存
    [WBNetworkCache clearCache];
    
    //tmp
    NSString *tmpPath = NSTemporaryDirectory();
    [WBClearCache clearCacheWithFilePath:tmpPath];

    //webview
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WBFit(13);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WB_Common.screenWidth, WBFit(13))];
    view.backgroundColor = WB_Common.defaultBcakgroundColor;
    return view;
}

@end
