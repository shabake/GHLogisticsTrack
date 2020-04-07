//
//  GHLogisticsTrackModel.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/22.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "GHLogisticsTrackModel.h"
#import "GHLogisticsTrackStatusModel.h"

@implementation GHLogisticsTrackModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setLocalAggregate:dic];
    }
    return self;
}

- (void)setLocalAggregate:(NSDictionary *)dic {
    NSArray *list = dic[@"list"];
    NSMutableArray *listArray = [NSMutableArray array];
    for (NSDictionary *dict in list) {
        GHLogisticsTrackStatusModel *logisticsTrackStatusModel = [GHLogisticsTrackStatusModel mj_objectWithKeyValues:dict];
        [listArray addObject:logisticsTrackStatusModel];
    }
    self.list = listArray.copy;
}

- (NSString *)deliverystatusStr {
    if ([self.deliverystatus isEqualToString:@"0"]) {
        return @"快递收件(揽件)";
    } else if ([self.deliverystatus isEqualToString:@"1"]) {
        return @"在途中";
    } else if ([self.deliverystatus isEqualToString:@"2"]) {
        return @"正在派件";
    } else if ([self.deliverystatus isEqualToString:@"3"]) {
        return @"已签收";
    } else if ([self.deliverystatus isEqualToString:@"4"]) {
        return @"派送失败";
    } else if ([self.deliverystatus isEqualToString:@"5"]) {
        return @"疑难件";
    } else if ([self.deliverystatus isEqualToString:@"6"]) {
        return @"退件签收";
    }
    return @"";
}

- (NSString *)imageName  {

    if ([self.deliverystatus isEqualToString:@"0"]) {
        return @"logistics_collect";
    } else if ([self.deliverystatus isEqualToString:@"1"]) {
        return @"logistics_delivery";
    } else if ([self.deliverystatus isEqualToString:@"2"]) {
        return @"logistics_delivery";
    } else if ([self.deliverystatus isEqualToString:@"3"]) {
        return @"logistics_sign";
    } else if ([self.deliverystatus isEqualToString:@"4"]) {
        return @"logistics_processing";
    } else if ([self.deliverystatus isEqualToString:@"5"]) {
        return @"logistics_processing";
    } else if ([self.deliverystatus isEqualToString:@"6"]) {
        return @"logistics_processing";
    } else {
        return @"logistics_processing";
    }
}

//手机号码验证
- (BOOL)validateMobile:(NSString *)mobile{
    NSString *phoneRegex = @"\\d{5,18}|\\d{3,4}-\\d{7,18}|\\d{5,6}-\\d{3,6}|(\\d{3,6}-){1,3}\\d{3,8}|\\d{3,6}\\s\\d{3,8}\\s\\d{3,8}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
 
- (NSString *)getMobileFromAllStr:(NSString *)newStr{
    NSString *needMobile = @"";
    NSMutableString *arrMobile = [NSMutableString string];
    for (int i = 0; i<newStr.length; i++) {
        NSString *temp = [newStr substringWithRange:NSMakeRange(i,1)];
        if ([temp isEqualToString:@"1"]) {
            NSInteger k = i;
            if (k+11<=newStr.length) {
                needMobile = [newStr substringWithRange:NSMakeRange(k, 11)];
                if ([self validateMobile:needMobile]) {
                    [arrMobile appendString:needMobile];
                }
            }
        }
    }
    return arrMobile.copy;
}


@end
