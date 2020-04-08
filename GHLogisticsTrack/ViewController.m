//
//  ViewController.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "ViewController.h"
#import "GHLogisticsTrackViewController.h"
#import "GHLogisticsTrackExampleStyle1LastCell.h"
#import "GHLogisticsTrackStatusModel.h"
#import "GHLogisticsTrackModel.h"
#import "GHLogisticsTrackExampleStyle1Cell.h"
#import "GHLogisticsTrackExampleStyle1Header.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,GHLogisticsTrackViewDelagte>

@property (nonatomic , strong) GHLogisticsTrackModel *logisticsTrackModel;
@property (nonatomic , strong) GHLogisticsTrackViewController *vc;
@property (nonatomic , strong) GHLogisticsTrackExampleStyle1Header *header;
@property (nonatomic , strong) NSIndexPath *indexPath;
@property (nonatomic , strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"解耦";
    [self.view addSubview:self.tableView];
}

- (void)getData {
    weakself(self);
    NSString *strUrl = [NSString stringWithFormat:@"http://mock-api.com/7zxXywz3.mock/logisticsTrack"];
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
            weakSelf.logisticsTrackModel = logisticsTrackModel;
            weakSelf.header.logisticsTrackModel = weakSelf.logisticsTrackModel;
            if (weakSelf.indexPath.row != 0 ) {
                weakSelf.vc.delegate = weakSelf;
            }
        } else {
            NSLog(@"服务器内部错误");
        }
    }];
}

- (NSInteger)numberOfSectionsInLogisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView {
    return self.logisticsTrackModel.list.count;
}

- (NSInteger)logisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)itemOfLogisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    GHLogisticsTrackStatusModel *logisticsTrackStatusModel = self.logisticsTrackModel.list[indexPath.section];
    [tableView registerClass:[GHLogisticsTrackExampleStyle1Cell class] forCellReuseIdentifier:@"GHLogisticsTrackExampleStyle1CellID"];
    [tableView registerClass:[GHLogisticsTrackExampleStyle1LastCell class] forCellReuseIdentifier:@"GHLogisticsTrackExampleStyle1LastCellID"];
    if (indexPath.section == 0) {
        GHLogisticsTrackExampleStyle1LastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHLogisticsTrackExampleStyle1LastCellID"];
        cell.indexPath = indexPath;
        cell.didClickPhoneNumberBlock = ^(NSString * _Nonnull number) {
            NSLog(@"number:%@",number);
        };
        cell.logisticsTrackModel = self.logisticsTrackModel;
        cell.logisticsTrackStatusModel = logisticsTrackStatusModel;
        return cell;
    }
    GHLogisticsTrackExampleStyle1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHLogisticsTrackExampleStyle1CellID"];
    cell.didClickPhoneNumberBlock = ^(NSString * _Nonnull number) {
        NSLog(@"number:%@",number);
    };
    cell.indexPath = indexPath;
    cell.logisticsTrackModel = self.logisticsTrackModel;
    cell.logisticsTrackStatusModel = logisticsTrackStatusModel;
    return cell;
}

- (CGFloat)logisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [GHLogisticsTrackExampleStyle1LastCell cellHeightWithContent:self.logisticsTrackModel logisticsTrackStatusModel:self.logisticsTrackModel.list[indexPath.section]];
    } else {
        return [GHLogisticsTrackExampleStyle1Cell cellHeightWithContent:self.logisticsTrackModel logisticsTrackStatusModel:self.logisticsTrackModel.list[indexPath.section]];
    }
}

- (UIView *)headerForLogisticsTrackViewController:(GHLogisticsTrackViewController *)logisticsTrackViewController {
    return self.header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"默认样式";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"代理样式";
    }
    return cell;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    
    GHLogisticsTrackViewController *vc = [[GHLogisticsTrackViewController alloc] init];
    if (indexPath.row == 0) {
        vc.navTitle = @"默认样式";
    } else {
        vc.navTitle = @"代理样式";
        vc.delegate = self;
    }
    /// 设置数据
    vc.number = @"8430110";
    vc.courierCompany = @"顺丰";
    vc.deliveryStatus = @"正在配送";
    vc.times = @[@"2018-20-20 20:20:20",@"2020-20-20 20:20:20",@"2040-40-40 40:240:40"];
    vc.statuss = @[@"【北京转运中心】 已发出 下一站 【北京市石景山区首钢分公司公司】",
    @"【那警方转运中心】 已发出 下一1站 【北京市石景山区首钢分公司公司】",
                   @"【河北】 已发出 下一1站 【北京市石景山区首钢分公司公司】"];

    vc.url = @"";
    self.vc = vc;
    weakself(self);
    vc.reloadDataBlock = ^{
        [weakSelf getData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
    }
    return _tableView;
}

- (GHLogisticsTrackExampleStyle1Header *)header {
    if (_header == nil) {
        _header = [[GHLogisticsTrackExampleStyle1Header alloc]initWithFrame:CGRectMake(0, 0, 0, 90)];
    }
    return _header;
}

- (GHLogisticsTrackModel *)logisticsTrackModel {
    if (_logisticsTrackModel == nil) {
        _logisticsTrackModel = [[GHLogisticsTrackModel alloc]init];
    }
    return _logisticsTrackModel;
}

@end
