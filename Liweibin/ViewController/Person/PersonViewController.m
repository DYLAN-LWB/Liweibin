//
//  PersonViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "PersonViewController.h"
#import "P_EditInfoViewController.h"
#import "P_MyScoreViewController.h"
#import "P_ScoreMallViewController.h"
#import "P_MessageViewController.h"
#import "P_ContactViewController.h"
#import "P_SettingViewController.h"

#import "WBFullImage.h"

@interface PersonViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UIView          *_topInfoView;      //顶部视图
    UIImageView     *_iconIV;           //头像
    UIImageView     *_iconBorderIV;     //头像边框
    UILabel         *_nameLabel;        // 用户名
    UILabel         *_gradeLabel;       // 年级
    UILabel         *_scoreLabel;       // 积分
    
    UITableView     *_tableView;
    NSArray         *_listArray;
}
@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.hidden = YES;

    [self initPersonInfoView];
    
    [self initTableView];
}

- (void)initPersonInfoView {
    _topInfoView = [[UIView alloc] init];
    _topInfoView.frame = CGRectMake(0, 0, AppManger.common.screenWidth, WBFit(150));
    _topInfoView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"person_bg@3x"]];
    [self.view addSubview:_topInfoView];
    
    //头像
    _iconIV = [[UIImageView alloc] init];
    _iconIV.frame = CGRectMake(WBFit(30), WBFit(55), WBFit(70), WBFit(70));
    _iconIV.image = [UIImage imageNamed:@"person_default_icon"];
    _iconIV.layer.masksToBounds = YES;
    _iconIV.layer.cornerRadius = CGRectGetHeight([_iconIV bounds])/2;
    [_topInfoView addSubview:_iconIV];
    _iconIV.userInteractionEnabled = YES;
    [_iconIV addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fullImageTap:)]];

    
    //头像边框图片
    _iconBorderIV = [[UIImageView alloc] init];
    _iconBorderIV.frame = CGRectMake(WBFit(25), WBFit(50), WBFit(80), WBFit(80));
    _iconBorderIV.image = [UIImage imageNamed:@"person_border_icon"];
    [_topInfoView addSubview:_iconBorderIV];
    
    //昵称
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(WBFit(120), WBFit(50), WBFit(200), WBFit(30));
    _nameLabel.text = @"啊发法国人";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = WBFont(20);
    [_topInfoView addSubview:_nameLabel];
    
    //年级
    _gradeLabel = [[UILabel alloc] init];
    _gradeLabel.frame = CGRectMake(WBFit(120), WBFit(80), WBFit(200), WBFit(30));
    _gradeLabel.textColor = [UIColor whiteColor];
    _gradeLabel.font = WBFont(18);
    [_topInfoView addSubview:_gradeLabel];
    _gradeLabel.text = @"七年级上";

    //积分
    _scoreLabel = [[UILabel alloc] init];
    _scoreLabel.frame = CGRectMake(WBFit(120), WBFit(110), WBFit(200), WBFit(25));
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.font = WBFont(18);
    [_topInfoView addSubview:_scoreLabel];
    _scoreLabel.text = @"积分：329";

    //编辑资料
    WBButton *editBtn = [WBButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(AppManger.common.screenWidth - WBFit(80), WBFit(70), WBFit(80), WBFit(80));
    editBtn.buttonStyle = WBButtonStyleImageUpTextUnder;
    editBtn.titleLabel.font = WBFont(14);
    [editBtn setImage:[UIImage imageNamed:@"person_edit"] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_topInfoView addSubview:editBtn];
}

- (void)fullImageTap:(UITapGestureRecognizer*)tap {
    [WBFullImage showFullImageWithUrlString:nil orImageView:_iconIV];
}

- (void)editBtnClick {
    P_EditInfoViewController *edit = [[P_EditInfoViewController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)initTableView {
    
    _listArray = @[@"购买的课程", @"我的积分", @"积分商城", @"做任务赚积分", @"分享给好友", @"消息", @"联系我们", @"当前版本", @"设置"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WBFit(150), AppManger.common.screenWidth, AppManger.common.screenHeight - WBFit(150)- AppManger.common.navHeight)];
    _tableView.backgroundColor = AppManger.common.defaultBcakgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.rowHeight = WBFit(50);
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WBFit(20), WBFit(12.5), WBFit(26), WBFit(25))];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"person%ld", indexPath.row]];
    [cell.contentView addSubview:imageView];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WBFit(65), 0, 200, _tableView.rowHeight)];
    label.text  = _listArray[indexPath.row];
    label.font = WBFont(17);
    label.textColor = [UIColor colorWithWhite:0.239 alpha:1.000];
    [cell.contentView addSubview:label];
    
    if ([label.text isEqualToString:@"我的积分"]) {
        label.textColor = AppManger.common.defaultThemeColor;
        
        UILabel *subLabel = [[UILabel alloc] init];
        subLabel.frame = CGRectMake(WBFit(140), 0, AppManger.common.screenWidth - WBFit(180), _tableView.rowHeight);
        subLabel.text  = @"每日完成任务，积分当钱花";
        subLabel.font = WBFont(17);
        subLabel.textColor = [UIColor colorWithWhite:0.424 alpha:1.000];
        subLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:subLabel];
    }
//
//    if ([label.text isEqualToString:@"做任务赚积分"] && _showTaskRed) {
//        _taskRedLabel = [[UILabel alloc] init];
//        _taskRedLabel.frame = CGRectMake(WBFit(180), (cellHeight-WBFit(8))/2, WBFit(8), WBFit(8));
//        _taskRedLabel.backgroundColor = [UIColor redColor];
//        _taskRedLabel.layer.masksToBounds = YES;
//        _taskRedLabel.layer.cornerRadius = WBFit(5);
//        [cell.contentView addSubview:_taskRedLabel];
//    }
//
//    if ([label.text isEqualToString:@"消息"] && WBAppDel.receiveJPush) {
//        _msgRedLabel = [[UILabel alloc] init];
//        _msgRedLabel.frame = CGRectMake(WBFit(120), (cellHeight-WBFit(8))/2, WBFit(8), WBFit(8));
//        _msgRedLabel.backgroundColor = [UIColor redColor];
//        _msgRedLabel.layer.masksToBounds = YES;
//        _msgRedLabel.layer.cornerRadius = WBFit(5);
//        [cell.contentView addSubview:_msgRedLabel];
//    }

    if ([label.text isEqualToString:@"当前版本"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;

        //当前版本
        NSString *text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

//        if (WBAppDel.isNewVersion) {
//            text = @"发现新版本";
//            UILabel *redLabel = [[UILabel alloc] init];
//            redLabel.frame = CGRectMake(SCREEN_WIDTH - 25, (cellHeight-WBFit(8))/2, WBFit(8), WBFit(8));
//            redLabel.backgroundColor = [UIColor redColor];
//            redLabel.layer.masksToBounds = YES;
//            redLabel.layer.cornerRadius = WBFit(5);
//            [cell.contentView addSubview:redLabel];
//        }

        UILabel *subLabel = [[UILabel alloc] init];
        subLabel.frame = CGRectMake(WBFit(140), 0, AppManger.common.screenWidth - WBFit(160), _tableView.rowHeight);
        subLabel.text = text;
        subLabel.font = WBFont(17);
        subLabel.textColor = [UIColor colorWithWhite:0.424 alpha:1.000];
        subLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:subLabel];
    }
    
    return cell;
}

@end
