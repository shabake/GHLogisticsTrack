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
- (UIView *)logisticsTrackViewController:(GHLogisticsTrackViewController *)logisticsTrackViewController viewForHeader:(UIView *)header;

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

@end

NS_ASSUME_NONNULL_END
