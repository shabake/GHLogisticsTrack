//
//  GHLogisticsTrackHeaderView.h
//  GHLogisticsTrack
//
//  Created by mac on 2020/4/8.
//  Copyright © 2020 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Header
 */
@interface GHLogisticsTrackHeaderView : UIView

/**
 *  配送单号
 */
@property (nonatomic , copy) NSString *number;

/**
 *  配送快递公司
 */
@property (nonatomic , copy) NSString *courierCompany;

/**
 *  配送状态
 */
@property (nonatomic , copy) NSString *deliveryStatus;

/**
 *  快递图标
 */
@property (nonatomic , copy) NSString *imageName;

/**
 *  快递图标
 */
@property (nonatomic , copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
