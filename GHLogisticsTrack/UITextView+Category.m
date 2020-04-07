//
//  UITextView+Category.m
//  GHLogisticsTrack
//
//  Created by mac on 2020/4/7.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "UITextView+Category.h"

@implementation UITextView (Category)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
     if ([UIMenuController sharedMenuController]) {
       [UIMenuController sharedMenuController].menuVisible = NO;
     }
     return NO;
}

@end
