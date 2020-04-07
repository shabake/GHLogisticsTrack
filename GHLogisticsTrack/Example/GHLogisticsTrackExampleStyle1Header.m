//
//  GHLogisticsTrackHeader.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "GHLogisticsTrackExampleStyle1Header.h"
#import "UIImageView+WebCache.h"
#import "GHLogisticsTrackModel.h"
@interface GHLogisticsTrackExampleStyle1Header()
@property (nonatomic , strong) UILabel *trackingNumber;
@property (nonatomic , strong) UILabel *company;
@property (nonatomic , strong) UILabel *status;
@property (nonatomic , strong) UILabel *copy;
@property (nonatomic , strong) UIImageView *logo;
@end
@implementation GHLogisticsTrackExampleStyle1Header

- (void)setLogisticsTrackModel:(GHLogisticsTrackModel *)logisticsTrackModel {
    self.trackingNumber.text = [NSString stringWithFormat:@"配送单号:%@",logisticsTrackModel.number.length ? logisticsTrackModel.number:@""];
    
    self.company.text = [NSString stringWithFormat:@"配送公司:%@",logisticsTrackModel.expName.length ? logisticsTrackModel.expName:@""];
    
    self.copy.hidden = logisticsTrackModel.number.length ? NO:YES;
    
    self.status.attributedText = [self getRealStatusWithLogisticsTrackModel:logisticsTrackModel];
    [self.logo sd_setImageWithURL:[NSURL URLWithString:logisticsTrackModel.logo]];
}

- (NSAttributedString *)getRealStatusWithLogisticsTrackModel:(GHLogisticsTrackModel *)logisticsTrackModel {
    if (!logisticsTrackModel.deliverystatusStr.length) {
        return nil;
    }
    NSString *status = [NSString stringWithFormat:@"物流状态:%@",logisticsTrackModel.deliverystatusStr];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:status];
    NSRange range = [status rangeOfString:logisticsTrackModel.deliverystatusStr];
    [attriStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x2A2A2A)} range:range];
    return attriStr;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.trackingNumber];
    [self addSubview:self.copy];
    [self addSubview:self.company];
    [self addSubview:self.logo];
    [self addSubview:self.status];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.trackingNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(15);
    }];
    
    [self.copy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.trackingNumber);
        make.left.equalTo(self.trackingNumber.mas_right).offset(10);
        make.width.equalTo(@44);
        make.height.equalTo(@21);
    }];
    
    [self.company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trackingNumber.mas_bottom).offset(5);
        make.left.equalTo(self.trackingNumber);
        make.right.equalTo(self.trackingNumber);
    }];
    
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trackingNumber);
        make.bottom.equalTo(self.status);
        make.width.equalTo(self.logo.mas_height);
        make.right.equalTo(self).offset(-15);
    }];
    
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.company.mas_bottom).offset(5);
        make.left.equalTo(self.company);
        make.right.equalTo(self.company);
    }];
}


- (void)clickLook {
//    if (self.didClickLookBlock) {
//        self.didClickLookBlock();
//    }
}

- (void)clickCopy {
    
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = self.logisticsTrackModel.courierPhone;
//    [FSToastTool makeToast:@"复制成功" targetView:kKeyWindow];
}

- (UILabel *)company {
    if (_company == nil) {
        _company = [[UILabel alloc]init];
        _company.text = @"配送公司:";
        _company.font = [UIFont systemFontOfSize:12];
        _company.textColor = UIColorFromRGB(0x666666);
    }
    return _company;
}

- (UILabel *)trackingNumber {
    if (_trackingNumber == nil) {
        _trackingNumber = [[UILabel alloc]init];
        _trackingNumber.text = @"配送单号";
        _trackingNumber.font = [UIFont systemFontOfSize:12];
        _trackingNumber.textColor = UIColorFromRGB(0x666666);
    }
    return _trackingNumber;
}

- (UILabel *)copy {
    if (_copy == nil) {
        _copy = [[UILabel alloc]init];
        _copy.text = @"复制";
        _copy.font = [UIFont systemFontOfSize:12];
        _copy.textAlignment = NSTextAlignmentCenter;
        _copy.layer.borderColor = UIColorFromRGB(0xDDDDDD).CGColor;
        _copy.layer.borderWidth = 1;
        _copy.layer.cornerRadius = 3;
        _copy.layer.masksToBounds = YES;
        _copy.hidden = YES;
//        [_copy addTapAction:self selector:@selector(clickCopy)];
        _copy.textColor = UIColorFromRGB(0x333333);
    }
    return _copy;
}

- (UIImageView *)logo {
    if (_logo == nil) {
        _logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    }
    return _logo;
}

- (UILabel *)status {
    if (_status == nil) {
        _status = [[UILabel alloc]init];
        _status.font = [UIFont systemFontOfSize:12];
        _status.textColor = UIColorFromRGB(0x666666);
        _status.text = @"123";
    }
    return _status;
}


@end
