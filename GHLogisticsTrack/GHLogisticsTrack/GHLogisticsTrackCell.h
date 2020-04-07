//
//  GHLogisticsTrackCell.h
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GHLogisticsTrackStatusModel,GHLogisticsTrackModel;

typedef void (^GHLogisticsTrackLastCellDidClickPhoneNumberBlock)(NSString *number);


@interface GHLogisticsTrackCell : UITableViewCell

@property (nonatomic , copy) GHLogisticsTrackLastCellDidClickPhoneNumberBlock didClickPhoneNumberBlock;


@property (nonatomic , strong) NSIndexPath *indexPath;

/**
 * GHLogisticsTrackModel实体
 */
@property (nonatomic , strong) GHLogisticsTrackModel *logisticsTrackModel;

/**
 * GHLogisticsTrackStatusModel实体
 */
@property (nonatomic , strong) GHLogisticsTrackStatusModel *logisticsTrackStatusModel;

/**
 * 计算高度
 */
+ (CGFloat)cellHeightWithContent:(GHLogisticsTrackModel *)logisticsTrackModel logisticsTrackStatusModel:(GHLogisticsTrackStatusModel *)statusModel;

@end

NS_ASSUME_NONNULL_END
