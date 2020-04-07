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
}

- (void)getData {
    weakself(self);
    NSString *strUrl = [NSString stringWithFormat:@"http://mock-api.com/7zxXywz3.mock/logisticsTrack"];
    // 对汉字进行转义
    strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSDictionary *data = dict[@"data"];
            NSDictionary *result = data[@"result"];
            NSArray *list = result[@"list"];
            NSMutableArray *listArray = [NSMutableArray array];
            for (NSDictionary *listDict in list) {
                GHLogisticsTrackStatusModel *logisticsTrackStatusModel = [GHLogisticsTrackStatusModel mj_objectWithKeyValues:listDict];
                [listArray addObject:logisticsTrackStatusModel];
            }
            GHLogisticsTrackModel *logisticsTrackModel = [GHLogisticsTrackModel mj_objectWithKeyValues:result];
            logisticsTrackModel.list = listArray.copy;
            if (weakSelf.getDataBlock) {
                weakSelf.getDataBlock(logisticsTrackModel);
            }
            weakSelf.logisticsTrackModel = logisticsTrackModel;
            [weakSelf.tableView reloadData];
        } else {
            NSLog(@"服务器内部错误");
        }
    }];
}

- (void)reloadData {
    if (self.reloadDataBlock) {
        self.reloadDataBlock();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流轨迹";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadData)];
    [self setupUI];
    [self getData];
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
