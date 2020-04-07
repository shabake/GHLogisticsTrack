//
//  ViewController.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "ViewController.h"
#import "GHLogisticsTrackViewController.h"
#import "GHExampleHeader.h"
#import "GHLogisticsTrackLastCell.h"
#import "GHLogisticsTrackStatusModel.h"
#import "GHLogisticsTrackModel.h"
#import "GHLogisticsTrackCell.h"

@interface ViewController ()<GHLogisticsTrackViewDelagte>

@property (nonatomic , strong) GHExampleHeader *header;
@property (nonatomic , strong) GHLogisticsTrackModel *logisticsTrackModel;
@property (nonatomic , strong) GHLogisticsTrackViewController *vc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
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
            weakSelf.logisticsTrackModel = logisticsTrackModel;
            weakSelf.header.logisticsTrackModel = self.logisticsTrackModel;
            weakSelf.vc.delegate = weakSelf;
        } else {
            NSLog(@"服务器内部错误");
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    GHLogisticsTrackViewController *vc = [[GHLogisticsTrackViewController alloc]init];
    vc.delegate = self;
    self.vc = vc;
    weakself(self);
    vc.reloadDataBlock = ^(UITableView * _Nonnull tableView) {
        [weakSelf getData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInLogisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView {
    return self.logisticsTrackModel.list.count;
}

- (NSInteger)logisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)itemOfLogisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    GHLogisticsTrackStatusModel *logisticsTrackStatusModel = self.logisticsTrackModel.list[indexPath.section];
    
    if (indexPath.section == 0) {
        GHLogisticsTrackLastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHLogisticsTrackLastCellID"];
        cell.indexPath = indexPath;
        cell.logisticsTrackModel = self.logisticsTrackModel;
        cell.logisticsTrackStatusModel = logisticsTrackStatusModel;
        return cell;
    }
    GHLogisticsTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHLogisticsTrackCellID"];
    cell.indexPath = indexPath;
    cell.logisticsTrackModel = self.logisticsTrackModel;
    cell.logisticsTrackStatusModel = logisticsTrackStatusModel;
    return cell;
}

- (CGFloat)logisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [GHLogisticsTrackLastCell cellHeightWithContent:self.logisticsTrackModel logisticsTrackStatusModel:self.logisticsTrackModel.list[indexPath.section]];
    } else {
        return [GHLogisticsTrackCell cellHeightWithContent:self.logisticsTrackModel logisticsTrackStatusModel:self.logisticsTrackModel.list[indexPath.section]];
    }
}

- (UIView *)logisticsTrackViewController:(GHLogisticsTrackViewController *)logisticsTrackViewController viewForHeader:(UIView *)header {
    return self.header;
}

- (GHExampleHeader *)header {
    if (_header == nil) {
        _header = [[GHExampleHeader alloc]initWithFrame:CGRectMake(0, 0, 0, 84)];
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
