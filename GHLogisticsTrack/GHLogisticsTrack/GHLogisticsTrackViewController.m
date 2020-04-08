//
//  GHLogisticsTrackViewController.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "GHLogisticsTrackViewController.h"
#import "GHLogisticsTrackHeaderView.h"

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
//        self.headerView.url = self.url;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.delegate numberOfSectionsInLogisticsTrackView:self tableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate logisticsTrackView:self tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate logisticsTrackView:self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemOfLogisticsTrackView:tableView:indexPath:)]) {
        return [self.delegate itemOfLogisticsTrackView:self tableView:tableView indexPath:indexPath];
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
