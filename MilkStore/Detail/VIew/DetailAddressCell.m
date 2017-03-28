//
//  DetailAddressCell.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "DetailAddressCell.h"
@interface DetailAddressCell ()

@property(nonatomic,strong) UILabel *tipLabel;
@property(nonatomic,strong) UILabel *addressLabel;
@property(nonatomic,strong) UILabel *countLabel;

@end
@implementation DetailAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}
- (void)configViews{
    
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.frame = CGRectMake(5, 2, 40, 25);
    _tipLabel.font = [UIFont systemFontOfSize:13];
    _tipLabel.textColor = [UIColor lightGrayColor];
    _tipLabel.text = @"送至";
    [self.contentView addSubview:_tipLabel];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.frame = CGRectMake(CGRectGetMaxX(_tipLabel.frame), 2, SCREEN_WIDTH - 40 - 20, 25);
    _addressLabel.font = [UIFont systemFontOfSize:13];
    _addressLabel.numberOfLines = 0;
    _addressLabel.text = @"杭州市西湖区文一西路522号西溪科创园";
    [self.contentView addSubview:_addressLabel];
    
//    _countLabel = [[UILabel alloc]init];
//    _countLabel.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame) , 2, 40, 25);
//    _countLabel.font = [UIFont systemFontOfSize:13];
//    _countLabel.numberOfLines = 0;
//    _countLabel.text = @" 1个";
//    [self.contentView addSubview:_countLabel];
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
