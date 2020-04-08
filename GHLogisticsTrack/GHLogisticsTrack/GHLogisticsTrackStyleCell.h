//
//  GHLogisticsTrackStyleCell.h
//  GHLogisticsTrack
//
//  Created by mac on 2020/4/8.
//  Copyright © 2020 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLogisticsTrackStyleCell : UITableViewCell

/**
 * 物流信息，比如：“【北京转运中心】 已发出 下一站 【北京市石景山区首钢分公司公司】”
 */
@property (nonatomic , copy) NSString *statusStr;

@property (nonatomic , strong) NSArray *phoneNumber;

/**
 * 物流信息更新时间，比如："2018-09-21 00:55:07"
 */
@property (nonatomic , copy) NSString *time;

@property (nonatomic , assign) BOOL isLast;

+ (CGFloat)cellHeightWithContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
