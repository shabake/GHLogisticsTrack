//
//  GHLogisticsTrackLastCell.h
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/22.
//  Copyright © 2019 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GHLogisticsTrackStatusModel,GHLogisticsTrackModel;

typedef void (^GHLogisticsTrackLastCellDidClickPhoneNumberBlock)(NSString *number);

@interface GHLogisticsTrackLastCell : UITableViewCell

@property (nonatomic , strong) NSIndexPath *indexPath;
@property (nonatomic , copy) GHLogisticsTrackLastCellDidClickPhoneNumberBlock didClickPhoneNumberBlock;


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
