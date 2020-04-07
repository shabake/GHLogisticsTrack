//
//  GHLogisticsTrackStatusModel.h
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/22.
//  Copyright © 2019 GHome. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLogisticsTrackStatusModel : NSObject

/**
 * 物流信息，比如：“【北京转运中心】 已发出 下一站 【北京市石景山区首钢分公司公司】”
 */
@property (nonatomic , copy) NSString *status;

/**
 * 物流信息更新时间，比如："2018-09-21 00:55:07"
 */
@property (nonatomic , copy) NSString *time;

@property (nonatomic , strong) NSArray *phoneNumber;

@end

NS_ASSUME_NONNULL_END
