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

- (UIView *)logisticsTrackViewController:(GHLogisticsTrackViewController *)logisticsTrackViewController viewForHeader:(UIView *)header;

@end

typedef void (^LogisticsTrackGetDataBlock)(GHLogisticsTrackModel *model);

@interface GHLogisticsTrackViewController : UIViewController

@property (nonatomic , copy) LogisticsTrackGetDataBlock getDataBlock;;

@property (nonatomic , weak) id <GHLogisticsTrackViewDelagte> delegate;

@end

NS_ASSUME_NONNULL_END
