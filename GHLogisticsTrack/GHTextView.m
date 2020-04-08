//
//  GHTextView.m
//  GHLogisticsTrack
//
//  Created by mac on 2020/4/8.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "GHTextView.h"

@implementation GHTextView

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
     if ([UIMenuController sharedMenuController]) {
       [UIMenuController sharedMenuController].menuVisible = NO;
     }
     return NO;
}

@end
