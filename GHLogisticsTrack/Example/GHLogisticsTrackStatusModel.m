//
//  GHLogisticsTrackStatusModel.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/22.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "GHLogisticsTrackStatusModel.h"

@implementation GHLogisticsTrackStatusModel

- (NSArray *)phoneNumber {
    if ([self getMobileFromAllStr:self.status].count) {
        return [self getMobileFromAllStr:self.status];
    }
    return nil;
}

- (BOOL)validateMobile:(NSString *)mobile{
    NSString *regex = @"\\d{5,18}|\\d{3,4}-\\d{7,18}|\\d{5,6}-\\d{3,6}|(\\d{3,6}-){2,3}\\d{3,6}|\\d{3,4} \\d{7,18}|\\d{3,4} \\d{3,7} \\d{4,18}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [phoneTest evaluateWithObject:mobile];
}

- (NSArray *)getMobileFromAllStr:(NSString *)newStr{
    NSString *regex1 = @"\\d{5,18}";
    NSString *regex2 = @"\\d{3,4}-\\d{7,18}";
    NSString *regex3 = @"\\d{5,6}-\\d{3,6}";
    NSString *regex4 = @"(\\d{3,6}-){2,3}\\d{3,6}";
    NSString *regex5 = @"\\d{3,4} \\d{3,7} \\d{4,18}";
    NSString *regex6 = @"1[3456789]([0-9]){9}";
    
    NSMutableArray *strings = [NSMutableArray array];
    NSRange range1 = [newStr rangeOfString:regex1 options:NSRegularExpressionSearch];
    if (range1.location != NSNotFound) {
        NSString *str = [newStr substringWithRange:range1];
        [strings addObject:str];
    }

    NSRange range2 = [newStr rangeOfString:regex2 options:NSRegularExpressionSearch];
    if (range2.location != NSNotFound) {
        NSString *str = [newStr substringWithRange:range2];
        [strings addObject:str];
    }
    NSRange range3 = [newStr rangeOfString:regex3 options:NSRegularExpressionSearch];
    if (range3.location != NSNotFound) {
        NSString *str = [newStr substringWithRange:range3];
        [strings addObject:str];
    }
    NSRange range4 = [newStr rangeOfString:regex4 options:NSRegularExpressionSearch];
    if (range4.location != NSNotFound) {
        NSString *str = [newStr substringWithRange:range4];
        [strings addObject:str];
    }
    NSRange range5 = [newStr rangeOfString:regex5 options:NSRegularExpressionSearch];
    if (range5.location != NSNotFound) {
        NSString *str = [newStr substringWithRange:range5];
        [strings addObject:str];
    }
    
    NSRange range6 = [newStr rangeOfString:regex6 options:NSRegularExpressionSearch];
     if (range6.location != NSNotFound) {
         NSString *str = [newStr substringWithRange:range6];
         [strings addObject:str];
     }
    return strings.copy;
}

@end
