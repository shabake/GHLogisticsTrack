//
//  GHLogisticsTrackLastCell.m
//  GHLogisticsTrack
//
//  Created by mac on 2019/12/22.
//  Copyright © 2019 GHome. All rights reserved.
//

#import "GHLogisticsTrackExampleStyle1LastCell.h"
#import "GHLogisticsTrackModel.h"
#import "GHLogisticsTrackStatusModel.h"
#import "NSString+GH.h"
#import "GHTextView.h"

@interface GHLogisticsTrackExampleStyle1LastCell()<UITextViewDelegate>

@property (nonatomic , strong) GHTextView *info;
@property (nonatomic , strong) UILabel *date;
@property (nonatomic , strong) UILabel *status;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UIImageView *icon;

@end
@implementation GHLogisticsTrackExampleStyle1LastCell

- (void)setLogisticsTrackModel:(GHLogisticsTrackModel *)logisticsTrackModel {
    _logisticsTrackModel = logisticsTrackModel;
    if (logisticsTrackModel.list.count - 1 == self.indexPath.section) {
        self.line.hidden = YES;
    } else {
        self.line.hidden = NO;
    }
    self.icon.image = [UIImage imageNamed:logisticsTrackModel.imageName];
    self.status.text = logisticsTrackModel.deliverystatusStr;
}

- (void)setLogisticsTrackStatusModel:(GHLogisticsTrackStatusModel *)logisticsTrackStatusModel {
    _logisticsTrackStatusModel = logisticsTrackStatusModel;
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:logisticsTrackStatusModel.status];
    [attriStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x666666)} range:NSMakeRange(0, attriStr.length)];
    if (logisticsTrackStatusModel.phoneNumber.count) {
        for (NSString *string in logisticsTrackStatusModel.phoneNumber) {
            if ([logisticsTrackStatusModel.status containsString:string]) {
                self.info.attributedText = [self getRealStatusWithLogisticsTrackModel:self.logisticsTrackModel logisticsTrackStatusModel:logisticsTrackStatusModel attriStr:attriStr string:string];
            }
        }
    } else {
        self.info.text = logisticsTrackStatusModel.status;
    }
    self.date.text = logisticsTrackStatusModel.time;
}

- (NSAttributedString *)getRealStatusWithLogisticsTrackModel:(GHLogisticsTrackModel *)logisticsTrackModel logisticsTrackStatusModel:(GHLogisticsTrackStatusModel *)statusModel attriStr:(NSMutableAttributedString *)attriStr string:(NSString *)string {
    NSRange range = [statusModel.status rangeOfString:string];
    if (range.location != NSNotFound) {
        [attriStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x4A90E2)} range:range];
        [attriStr addAttribute:NSLinkAttributeName
                         value:string
                         range:range];
        return attriStr;
    }
    return nil;
}

+ (CGFloat)cellHeightWithContent:(GHLogisticsTrackModel *)logisticsTrackModel logisticsTrackStatusModel:(GHLogisticsTrackStatusModel *)statusModel {
    CGSize infoSize = [NSString sizeWithText:statusModel.status andFont:[UIFont systemFontOfSize:12] andMaxSize:CGSizeMake(kScreenWidth - 64, MAXFLOAT)];
    return 20 + 16 + 5 + infoSize.height+ 5 +16 + 14;
}

- (BOOL)textView:(GHTextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction  API_AVAILABLE(ios(10.0)){
    NSString *str = [self.logisticsTrackStatusModel.status substringWithRange:characterRange];
    if (self.didClickPhoneNumberBlock) {
        self.didClickPhoneNumberBlock(str);
    }
    return NO;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.status];
    [self.contentView addSubview:self.info];
    [self.contentView addSubview:self.date];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.width.height.equalTo(@(16));
        make.left.equalTo(self.contentView).offset(20);
    }];
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(8);
        make.width.equalTo(@(1));
        make.centerX.equalTo(self.icon);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.status mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon);
        make.left.equalTo(self.icon.mas_right).offset(12);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@16);
    }];
    
    CGSize infoSize = [NSString sizeWithText:self.logisticsTrackStatusModel.status andFont:[UIFont systemFontOfSize:12] andMaxSize:CGSizeMake(kScreenWidth - 64, MAXFLOAT)];
    [self.info mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.status.mas_bottom).offset(5);
        make.left.equalTo(self.icon.mas_right).offset(6);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(infoSize.height));
    }];
    
    [self.date mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.info.mas_bottom).offset(5);
        make.left.equalTo(self.status);
        make.right.equalTo(self.info);
        make.height.equalTo(@16);
    }];
}

- (UILabel *)status {
    if (_status == nil) {
        _status = [[UILabel alloc]init];
        _status.font = [UIFont systemFontOfSize:12 weight:1];
        _status.textColor = UIColorFromRGB(0x333333);
    }
    return _status;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xDCDEE3);
    }
    return _line;
}

- (GHTextView *)info {
    if (_info == nil) {
        _info = [[GHTextView alloc]init];
        _info.font = [UIFont systemFontOfSize:12];
        _info.editable = NO;
        _info.textColor = UIColorFromRGB(0x666666);
        _info.scrollEnabled = NO;
        _info.delegate = self;
        _info.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _info;
}

- (UILabel *)date {
    if (_date == nil) {
        _date = [[UILabel alloc]init];
        _date.font = [UIFont systemFontOfSize:12];
        _date.textColor = UIColorFromRGB(0x666666);
    }
    return _date;
}

- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc]init];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 8;
    }
    return _icon;
}

@end
