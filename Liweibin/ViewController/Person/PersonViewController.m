//
//  PersonViewController.m
//  Liweibin
//
//  Created by 李伟宾 on 2018/4/10.
//  Copyright © 2018年 李伟宾. All rights reserved.
//

#import "PersonViewController.h"
#import "EditInfoViewController.h"
#import "MyScoreViewController.h"
#import "ScoreMallViewController.h"
#import "MessageViewController.h"
#import "ContactViewController.h"
#import "SettingViewController.h"

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
    _topInfoView.frame = CGRectMake(0, 0, WB_Common.screenWidth, WBFit(150));
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
    _nameLabel.text = @"";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = WBFont(20);
    [_topInfoView addSubview:_nameLabel];
    
    //年级
    _gradeLabel = [[UILabel alloc] init];
    _gradeLabel.frame = CGRectMake(WBFit(120), WBFit(80), WBFit(200), WBFit(30));
    _gradeLabel.textColor = [UIColor whiteColor];
    _gradeLabel.font = WBFont(18);
    [_topInfoView addSubview:_gradeLabel];
    _gradeLabel.text = @"";

    //积分
    _scoreLabel = [[UILabel alloc] init];
    _scoreLabel.frame = CGRectMake(WBFit(120), WBFit(110), WBFit(200), WBFit(25));
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.font = WBFont(18);
    [_topInfoView addSubview:_scoreLabel];
    _scoreLabel.text = @"";

    //编辑资料
    WBButton *editBtn = [WBButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(WB_Common.screenWidth - WBFit(100), WBFit(70), WBFit(100), WBFit(80));
    editBtn.buttonStyle = WBButtonStyleImageUpTextUnder;
    editBtn.titleLabel.font = WBFont(14);
    [editBtn setImage:[UIImage imageNamed:@"person_edit"] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_topInfoView addSubview:editBtn];
    
    if (!WB_User.uid) {
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame =  CGRectMake(0, WBFit(30), WB_Common.screenWidth, WBFit(120));
        loginBtn.titleLabel.font = WBFont(23);
        [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_topInfoView addSubview:loginBtn];
    }
}

- (void)loginBtnClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:WB_Common.noticeShowLogin object:self userInfo:nil];
}
- (void)fullImageTap:(UITapGestureRecognizer*)tap {
    [WBFullImage showFullImageWithUrlString:nil orImageView:_iconIV];
}
- (void)editBtnClick {
    if (!WB_User.uid) {
        [WBAlertView showMessageToast:@"请先登录" toView:self.view];
        return;
    }
    EditInfoViewController *edit = [[EditInfoViewController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)initTableView {
    
    _listArray = @[@"购买的课程", @"我的积分", @"积分商城", @"做任务赚积分", @"分享给好友", @"消息", @"联系我们", @"当前版本", @"设置"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WBFit(150), WB_Common.screenWidth, WB_Common.screenHeight - WBFit(150)- WB_Common.navHeight)];
    _tableView.backgroundColor = WB_Common.defaultBcakgroundColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorInset  = UIEdgeInsetsZero;
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
        label.textColor = WB_Common.defaultThemeColor;
        
        UILabel *subLabel = [[UILabel alloc] init];
        subLabel.frame = CGRectMake(WBFit(140), 0, WB_Common.screenWidth - WBFit(180), _tableView.rowHeight);
        subLabel.text  = @"每日完成任务，积分当钱花";
        subLabel.font = WBFont(17);
        subLabel.textColor = [UIColor colorWithWhite:0.424 alpha:1.000];
        subLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:subLabel];
    }

    if ([label.text isEqualToString:@"当前版本"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;

        //当前版本
        NSString *text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

        UILabel *subLabel = [[UILabel alloc] init];
        subLabel.frame = CGRectMake(WBFit(140), 0, WB_Common.screenWidth - WBFit(160), _tableView.rowHeight);
        subLabel.text = text;
        subLabel.font = WBFont(17);
        subLabel.textColor = [UIColor colorWithWhite:0.424 alpha:1.000];
        subLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:subLabel];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //购买的课程,我的积分,积分商城,做任务赚积分,分享给好友,消息,联系我们,当前版本,设置
    switch (indexPath.row) {
        case 0:{
            MyScoreViewController *score = [[MyScoreViewController alloc] init];
            [self.navigationController pushViewController:score animated:YES];
        }
            break;
        case 1: {
            MyScoreViewController *score = [[MyScoreViewController alloc] init];
            [self.navigationController pushViewController:score animated:YES];
        }
            break;
        case 2:{
            ScoreMallViewController *samll = [[ScoreMallViewController alloc] init];
            [self.navigationController pushViewController:samll animated:YES];
        }
            break;
        case 3:{
        
        }
            break;
        case 4:
            [WBShare showShareViewWithTitle:@"倍速课堂"
                                       desc:@"倍速课堂-万向思维,科学备考"
                                   imageUrl:@"http://beisu-js.oss-cn-beijing.aliyuncs.com/lib/img/share_icon.png"
                                     webUrl:WB_Common.shareUrl
                             viewController:self];
            break;
        case 5:{
            MessageViewController *message = [[MessageViewController alloc] init];
            [self.navigationController pushViewController:message animated:YES];
        }
            break;
        case 6:{
            ContactViewController *contact = [[ContactViewController alloc] init];
            [self.navigationController pushViewController:contact animated:YES];
        }
            break;
        case 7:{
           
        }
            
            break;
        case 8:{
            SettingViewController *setting = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:setting animated:YES];
        }
            
            break;
        default:
            break;
    }
}

@end
