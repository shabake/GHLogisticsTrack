//
//  GHLogisticsTrackViewController.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "GHLogisticsTrackViewController.h"
#import "GHLogisticsTrackHeaderView.h"
#import "GHLogisticsTrackLastCell.h"
#import "GHLogisticsTrackStyleCell.h"

@interface GHLogisticsTrackViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *header;
@property (nonatomic , strong) GHLogisticsTrackHeaderView *headerView;

@end

@implementation GHLogisticsTrackViewController

- (void)setNavTitle:(NSString *)navTitle {
    self.navigationItem.title = navTitle;
}

- (void)setDelegate:(id<GHLogisticsTrackViewDelagte>)delegate {
    _delegate = delegate;
    [self.tableView reloadData];
}

- (void)reloadData {
    if (self.reloadDataBlock) {
        self.reloadDataBlock();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadData)];
    [self setupUI];
    [self reloadData];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerForLogisticsTrackViewController:)]) {
        self.tableView.tableHeaderView = [self.delegate headerForLogisticsTrackViewController:self];
    } else {
        self.headerView.number = self.number;
        self.headerView.courierCompany = self.courierCompany;
        self.headerView.deliveryStatus = self.deliveryStatus;
        self.headerView.url = self.url;
        self.tableView.tableHeaderView = self.headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 0.01f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfSectionsInLogisticsTrackView:tableView:)]) {
        return [self.delegate numberOfSectionsInLogisticsTrackView:self tableView:tableView];
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(logisticsTrackView:tableView:numberOfRowsInSection:)]) {
        return [self.delegate logisticsTrackView:self tableView:tableView numberOfRowsInSection:section];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(logisticsTrackView:tableView:heightForRowAtIndexPath:)]) {
        return [self.delegate logisticsTrackView:self tableView:tableView heightForRowAtIndexPath:indexPath];
    } else {
        NSString *status = self.statuss[indexPath.section];

        if (indexPath.section == 0) {
            return [GHLogisticsTrackLastCell cellHeightWithContent:status];
        } else {
            return [GHLogisticsTrackStyleCell cellHeightWithContent:status];
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemOfLogisticsTrackView:tableView:indexPath:)]) {
        return [self.delegate itemOfLogisticsTrackView:self tableView:tableView indexPath:indexPath];
    } else {
        NSString *status = self.statuss[indexPath.section];
        NSString *times = self.times[indexPath.section];
        if (indexPath.section == 0) {
            GHLogisticsTrackLastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHLogisticsTrackLastCellID"];
            cell.deliveryStatus = self.deliveryStatus;
            cell.statusStr = status;
            cell.time = times;
            cell.imageName = self.imageName;
            return cell;
        } else {
            GHLogisticsTrackStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHLogisticsTrackStyleCellID"];
            cell.statusStr = status;
            cell.time = times;
            if (indexPath.section == self.times.count - 1) {
                cell.isLast = YES;
            } else {
                cell.isLast = NO;
            }
            return cell;
        }
    }
    return [UITableViewCell new];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[GHLogisticsTrackLastCell class] forCellReuseIdentifier:@"GHLogisticsTrackLastCellID"];
        [_tableView registerClass:[GHLogisticsTrackStyleCell class] forCellReuseIdentifier:@"GHLogisticsTrackStyleCellID"];
    }
    return _tableView;
}

- (GHLogisticsTrackHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[GHLogisticsTrackHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
    }
    return _headerView;
}

@end
