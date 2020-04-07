//
//  GHLogisticsTrackModel.h
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/22.
//  Copyright © 2019 GHome. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHLogisticsTrackModel : NSObject


/**
 *  快递员 或 快递站(没有则为空)
 */
@property (nonatomic , copy) NSString *courier;

/**
 *  快递员电话 (没有则为空)
 */
@property (nonatomic , copy) NSString *courierPhone;

/**
 *
 * 0：快递收件(揽件)1.在途中 2.正在派件 3.已签收 4.派送失败 5.疑难件 6.退件签收
 */
@property (nonatomic , copy) NSString *deliverystatus;

/**
 * 快递公司名称
 */
@property (nonatomic , copy) NSString *expName;

/**
 * 快递公司电话
 */
@property (nonatomic , copy) NSString *expPhone;

/**
 * 快递公司官网
 */
@property (nonatomic , copy) NSString *expSite;

/**
 * 1.是否签收
 */
@property (nonatomic , copy) NSString *issign;

/**
 * 快递公司LOGO
 */
@property (nonatomic , copy) NSString *logo;

/**
 * 快递单号
 */
@property (nonatomic , copy) NSString *number;

/**
 * 发货到收货消耗时长 (截止最新轨迹)
 */
@property (nonatomic , copy) NSString *takeTime;

/**
 * 快递公司缩写，比如“zto”
 */
@property (nonatomic , copy) NSString *type;

/**
 * 快递轨迹信息最新时间
 */
@property (nonatomic , copy) NSString *updateTime;

/**
 * 物流状态数组
 */
@property (nonatomic , strong) NSArray *list;


/**
 *  物流状态本地地段
 * 0：快递收件(揽件)1.在途中 2.正在派件 3.已签收 4.派送失败 5.疑难件 6.退件签收
 */
@property (nonatomic , copy) NSString *deliverystatusStr;

@property (nonatomic , copy) NSString *imageName;
@end

NS_ASSUME_NONNULL_END
