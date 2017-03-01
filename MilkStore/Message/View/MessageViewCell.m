//
//  MessageViewCell.m
//  MilkStore
//
//  Created by monan on 2017/3/1.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "MessageViewCell.h"


@interface MessageViewCell ()

/**
 头像
 */
@property (nonatomic,strong) UIImageView *headerImageV;

/**
 昵称
 */
@property (nonatomic,strong) UILabel *nameLabel;

/**
 消息
 */
@property (nonatomic,strong) UILabel *messageLabel;

/**
 时间
 */
@property (nonatomic,strong) UILabel *timeLabel;

/**
 提醒数字
 */
@property (nonatomic,strong) UILabel *badgeLabel;
@end

@implementation MessageViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}
- (void)configViews{
    CGFloat width = 50;
    _headerImageV = [[UIImageView alloc]init];
    _headerImageV.frame = CGRectMake(5, 10, width, width);
    _headerImageV.image = [UIImage imageNamed:@"guilunmei"];
    _headerImageV.clipsToBounds = YES;
    _headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageV.layer.cornerRadius = 5;
    [self.contentView addSubview:_headerImageV];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.frame = CGRectMake(SCREEN_WIDTH - 10 - 50, CGRectGetMinY(_headerImageV.frame), 50 , 20);
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.text = @"19:09";
    [self.contentView addSubview:_timeLabel];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageV.frame) + 10, CGRectGetMinY(_headerImageV.frame),SCREEN_WIDTH - width - CGRectGetWidth(_nameLabel.frame), 20);
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.text = @"创维（Skyworth）55H9A";
    _nameLabel.numberOfLines = 1;
    [self.contentView addSubview:_nameLabel];
    
    _messageLabel = [[UILabel alloc]init];
    _messageLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageV.frame) + 10, CGRectGetMaxY(_nameLabel.frame)+10, CGRectGetWidth(_nameLabel.frame) , 20);
    _messageLabel.numberOfLines = 0;
    _messageLabel.font = [UIFont systemFontOfSize:12];
    _messageLabel.textColor = [UIColor lightGrayColor];
    _messageLabel.text = @"颜色：薄荷绿  尺码：170/92A";
    [self.contentView addSubview:_messageLabel];
    
    
    
    
    _badgeLabel = [[UILabel alloc]init];
    _badgeLabel.text = @"56";
    _badgeLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageV.frame) - 8, CGRectGetMinY(_headerImageV.frame) - 8, 16, 16);
    _badgeLabel.font = [UIFont systemFontOfSize:9];
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.backgroundColor = [UIColor redColor];
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    _badgeLabel.layer.cornerRadius = 8;
    _badgeLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:_badgeLabel];
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
