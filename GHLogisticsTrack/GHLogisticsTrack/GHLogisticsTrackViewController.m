//
//  GHLogisticsTrackViewController.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "GHLogisticsTrackViewController.h"
#import "GHLogisticsTrackHeader.h"
#import "GHLogisticsTrackCell.h"
#import "GHLogisticsTrackLastCell.h"
#import "GHLogisticsTrackModel.h"
#import "GHLogisticsTrackStatusModel.h"

@interface GHLogisticsTrackViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *header;
@property (nonatomic , strong) GHLogisticsTrackModel *logisticsTrackModel;

@end

@implementation GHLogisticsTrackViewController

- (void)setDelegate:(id<GHLogisticsTrackViewDelagte>)delegate {
    _delegate = delegate;
    [self.tableView reloadData];
}

- (void)reloadData {
    if (self.reloadDataBlock) {
        self.reloadDataBlock(self.tableView);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流轨迹";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadData)];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.header;
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

- (void)callWithNumber:(NSString *)number {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",number];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[GHLogisticsTrackCell class] forCellReuseIdentifier:@"GHLogisticsTrackCellID"];
        [_tableView registerClass:[GHLogisticsTrackLastCell class] forCellReuseIdentifier:@"GHLogisticsTrackLastCellID"];
    }
    return _tableView;
}

- (GHLogisticsTrackModel *)logisticsTrackModel {
    if (_logisticsTrackModel == nil) {
        _logisticsTrackModel = [[GHLogisticsTrackModel alloc]init];
    }
    return _logisticsTrackModel;
}

- (UIView *)header {
    if (self.delegate && [self.delegate respondsToSelector:@selector(logisticsTrackViewController:viewForHeader:)]) {
        return [self.delegate logisticsTrackViewController:self viewForHeader:nil];
    }
    return nil;;
}

@end
