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
#import <objc/runtime.h>
#import "UIView+Model.h"

static char *kLogisticsTrackheaderKey = "kLogisticsTrackheaderKey";

@interface GHLogisticsTrackViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *header;
@property (nonatomic , strong) GHLogisticsTrackModel *logisticsTrackModel;

@end

@implementation GHLogisticsTrackViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流轨迹";
    [self setupUI];
    [self getData];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.header;
}

- (void)setDelegate:(id<GHLogisticsTrackViewDelagte>)delegate {
    _delegate = delegate;
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
    return self.logisticsTrackModel.list.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [GHLogisticsTrackLastCell cellHeightWithContent:self.logisticsTrackModel logisticsTrackStatusModel:self.logisticsTrackModel.list[indexPath.section]];
    } else {
        return [GHLogisticsTrackCell cellHeightWithContent:self.logisticsTrackModel logisticsTrackStatusModel:self.logisticsTrackModel.list[indexPath.section]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHLogisticsTrackStatusModel *logisticsTrackStatusModel = self.logisticsTrackModel.list[indexPath.section];
    
    if (indexPath.section == 0 ) {
        GHLogisticsTrackLastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHLogisticsTrackLastCellID"];
        cell.indexPath = indexPath;
        cell.logisticsTrackModel = self.logisticsTrackModel;
        cell.logisticsTrackStatusModel = logisticsTrackStatusModel;
        weakself(self);
        cell.didClickPhoneNumberBlock = ^(NSString * _Nonnull number) {
            [weakSelf callWithNumber:number];
        };
        return cell;
    }
    GHLogisticsTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHLogisticsTrackCellID"];
    cell.indexPath = indexPath;
    cell.logisticsTrackModel = self.logisticsTrackModel;
    cell.logisticsTrackStatusModel = logisticsTrackStatusModel;
    weakself(self);
        cell.didClickPhoneNumberBlock = ^(NSString * _Nonnull number) {
            [weakSelf callWithNumber:number];
    };
    return cell;
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
