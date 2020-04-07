//
//  UIView+Model.m
//  GHLogisticsTrack
//
//  Created by mac on 2020/4/6.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "UIView+Model.h"

#import <objc/runtime.h>

static char *kLogisticsTrackHeaderModelKey = "kLogisticsTrackHeaderModelKey";

@implementation UIView (Model)

- (void)setModel:(GHLogisticsTrackModel *)model {
    objc_setAssociatedObject(self, kLogisticsTrackHeaderModelKey, model, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (GHLogisticsTrackModel *)model{
    return objc_getAssociatedObject(self, kLogisticsTrackHeaderModelKey);
}

@end
