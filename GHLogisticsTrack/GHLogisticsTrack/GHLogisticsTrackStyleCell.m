//
//  GHLogisticsTrackStyleCell.m
//  GHLogisticsTrack
//
//  Created by mac on 2020/4/8.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "GHLogisticsTrackStyleCell.h"
#import "NSString+GH.h"

@interface GHLogisticsTrackStyleCell()<UITextViewDelegate>

@property (nonatomic , strong) UITextView *info;
@property (nonatomic , strong) UILabel *date;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UIImageView *icon;

@end

@implementation GHLogisticsTrackStyleCell

- (void)setIsLast:(BOOL)isLast {
    if (isLast) {
        self.line.hidden = YES;
    } else {
        self.line.hidden = NO;
    }
}

- (void)setTime:(NSString *)time {
    self.date.text = time;
}

- (void)setStatusStr:(NSString *)statusStr {
    _statusStr = statusStr;
    if (statusStr.length == 0) {
        return;
    }
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:statusStr];
    [attriStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x666666)} range:NSMakeRange(0, attriStr.length)];
    if (self.phoneNumber.count) {
        for (NSString *string in self.phoneNumber) {
            if ([statusStr containsString:string]) {
                self.info.attributedText = [self getRealStatusWithStatusStr:statusStr attriStr:attriStr string:string];
            }
        }
    } else {
        self.info.text = statusStr;
    }
}

- (NSAttributedString *)getRealStatusWithStatusStr:(NSString *)statusStr attriStr:(NSMutableAttributedString *)attriStr string:(NSString *)string {
    NSRange range = [statusStr rangeOfString:string];
    if (range.location != NSNotFound) {
        [attriStr addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x4A90E2)} range:range];
        [attriStr addAttribute:NSLinkAttributeName
                         value:string
                         range:range];
        return attriStr;
    }
    return nil;
}

+ (CGFloat)cellHeightWithContent:(NSString *)content {
    CGSize infoSize = [NSString sizeWithText:content andFont:[UIFont systemFontOfSize:12] andMaxSize:CGSizeMake(kScreenWidth - 64, MAXFLOAT)];
        return infoSize.height + 5 + 16 + 14;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction  API_AVAILABLE(ios(10.0)){
    NSString *str = [self.statusStr substringWithRange:characterRange];
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
    [self.contentView addSubview:self.info];
    [self.contentView addSubview:self.date];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.height.equalTo(@(8));
        make.left.equalTo(self.contentView).offset(24);
    }];
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(8);
        make.width.equalTo(@(1));
        make.centerX.equalTo(self.icon);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    CGSize infoSize = [self.info sizeThatFits:CGSizeMake(kScreenWidth - 64, MAXFLOAT)];
    [self.info mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon);
        make.left.equalTo(self.icon.mas_right).offset(12);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(infoSize.height));
    }];
    
    [self.date mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.info.mas_bottom).offset(5);
        make.left.equalTo(self.info).offset(5);
        make.right.equalTo(self.info);
        make.height.equalTo(@16);
    }];
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xDCDEE3);
    }
    return _line;
}

- (UITextView *)info {
    if (_info == nil) {
        _info = [[UITextView alloc]init];
        _info.font = [UIFont systemFontOfSize:12];
        _info.textColor = UIColorFromRGB(0x666666);
        _info.editable = NO;
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
        _icon.backgroundColor = UIColorFromRGB(0xDCDEE3);
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 4;
    }
    return _icon;
}

@end
