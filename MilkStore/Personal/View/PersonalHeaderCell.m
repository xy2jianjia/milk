//
//  PersonalHeaderCell.m
//  MilkStore
//
//  Created by monan on 2017/3/27.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "PersonalHeaderCell.h"

@interface PersonalHeaderCell ()
@property (nonatomic,strong) UIImageView *headerImageV;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *userIdLabel;
@end

@implementation PersonalHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}
- (void)configViews{
    _headerImageV = [[UIImageView alloc]init];
    _headerImageV.frame = CGRectMake(10, 10, 60, 60);
    _headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageV.clipsToBounds = YES;
    _headerImageV.layer.cornerRadius = 8;
    [self.contentView addSubview:_headerImageV];
    
    _userNameLabel = [[UILabel alloc]init];
    _userNameLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageV.frame) + 10, CGRectGetMinY(_headerImageV.frame), SCREEN_WIDTH - CGRectGetWidth(_headerImageV.frame) - 30, 25);
    _userNameLabel.font = [UIFont systemFontOfSize:15];
    _userNameLabel.textColor = kUIColorFromRGB(0x333333);
    [self.contentView addSubview:_userNameLabel];
    
    _userIdLabel = [[UILabel alloc]init];
    _userIdLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageV.frame) + 10, CGRectGetMaxY(_userNameLabel.frame) + 5, CGRectGetWidth(_userNameLabel.frame), 25);
    _userIdLabel.font = [UIFont systemFontOfSize:13];
    _userIdLabel.textColor = kUIColorFromRGB(0x666666);
    [self.contentView addSubview:_userIdLabel];
    
}
-(void)setUserInfo:(UserInfoModel *)userInfo{
    UIImage *image = [UIImage imageWithContentsOfFile:userInfo.headerImageUrl];
    if (!image) {
        image = [UIImage imageNamed:@"list_item_icon"];
    }
    _headerImageV.image = image;
    if (_hideLabel) {
        _userNameLabel.hidden = YES;
        _userIdLabel.hidden = YES;
    }else{
        _userNameLabel.hidden = NO;
        _userIdLabel.hidden = NO;
    }
    if (userInfo.nickName == nil || [userInfo.nickName isEqualToString:@"(null)"] || [userInfo.nickName isEqualToString:@"null"]) {
        _userNameLabel.text = @"";
    }else{
        _userNameLabel.text = userInfo.nickName;
    }
    if (userInfo.userName) {
        _userIdLabel.text = userInfo.userName;
    }
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
