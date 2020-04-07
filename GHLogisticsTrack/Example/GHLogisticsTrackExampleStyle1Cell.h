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

typedef void (^GHLogisticsTrackExampleStyle1CellDidClickPhoneNumberBlock)(NSString *number);


@interface GHLogisticsTrackExampleStyle1Cell : UITableViewCell

@property (nonatomic , copy) GHLogisticsTrackExampleStyle1CellDidClickPhoneNumberBlock didClickPhoneNumberBlock;

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
