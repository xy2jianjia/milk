//
//  OrderInfoReceiverCell.m
//  MilkStore
//
//  Created by monan on 2017/4/13.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "OrderInfoReceiverCell.h"


@interface OrderInfoReceiverCell ()
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextView *addressLabel;

@end

@implementation OrderInfoReceiverCell

- (void)setNickName:(NSString *)nickName address:(NSString *)address phone:(NSString *)phone{
    if (address == nil) {
        address = @"请填写地址";
    }
    if ([nickName length] == 0 || nickName == nil || [nickName isEqualToString:@"(null)"] || [nickName isEqualToString:@"null"]) {
        nickName = @"请填写昵称";
    }
    _nickNameLabel.text = nickName;
    _addressLabel.text = address;
    _phoneLabel.text = phone;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
