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

@interface ViewController ()<GHLogisticsTrackViewDelagte>

@property (nonatomic , strong) GHExampleHeader *header;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    GHLogisticsTrackViewController *vc = [[GHLogisticsTrackViewController alloc]init];
    vc.delegate = self;
    weakself(self);
    vc.getDataBlock = ^(GHLogisticsTrackModel * _Nonnull model) {
        weakSelf.header.logisticsTrackModel = model;
    };
    [self.navigationController pushViewController:vc animated:YES];
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

@end
