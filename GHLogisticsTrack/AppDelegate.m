//
//  AppDelegate.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GHNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc]init];
    GHNavigationController *nav = [[GHNavigationController  alloc]initWithRootViewController:vc];
    window.rootViewController = nav;
    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

@end
