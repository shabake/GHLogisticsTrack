//
//  NSString+GH.h
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/22.
//  Copyright © 2019 GHome. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GH)
+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
