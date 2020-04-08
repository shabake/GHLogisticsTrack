//
//  GHLogisticsTrackViewController.h
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GHLogisticsTrackViewController,GHLogisticsTrackModel;
@protocol GHLogisticsTrackViewDelagte <NSObject>

/**
 *  返回Header
 */
- (UIView *)headerForLogisticsTrackViewController:(GHLogisticsTrackViewController *)logisticsTrackViewController;

/**
 *  返回cell
 */
- (UITableViewCell *)itemOfLogisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSectionsInLogisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView;

- (NSInteger)logisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (CGFloat)logisticsTrackView:(GHLogisticsTrackViewController *)logisticsTrackView tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef void (^LogisticsTrackGetDataBlock)(GHLogisticsTrackModel *model);
typedef void (^LogisticsTrackReloadDataBlock)(void);

@interface GHLogisticsTrackViewController : UIViewController

@property (nonatomic , copy) LogisticsTrackReloadDataBlock reloadDataBlock;

@property (nonatomic , copy) LogisticsTrackGetDataBlock getDataBlock;;

@property (nonatomic , weak) id <GHLogisticsTrackViewDelagte> delegate;

@property (nonatomic , copy) NSString *navTitle;;

/**
 *  配送单号
 */
@property (nonatomic , copy) NSString *number;;

/**
 *  配送快递公司
 */
@property (nonatomic , copy) NSString *courierCompany;

/**
 *  配送状态
 */
@property (nonatomic , copy) NSString *deliveryStatus;

/**
 *  图标
 */
@property (nonatomic , copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
