//
//  GHNavigationController.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/22.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "GHNavigationController.h"

@interface GHNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation GHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;

    NSDictionary *dict = @{ NSForegroundColorAttributeName : [UIColor blackColor],
                            NSFontAttributeName : [UIFont boldSystemFontOfSize:20]
    };
    self.navigationBar.titleTextAttributes = dict;
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *back = [[UIButton alloc]init];
        [back setTitle:@"back" forState:UIControlStateNormal];
        [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
        [back addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popBack {
    [super popViewControllerAnimated:YES];
}


@end
