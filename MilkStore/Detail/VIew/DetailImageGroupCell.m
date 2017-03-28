//
//  DetailImageGroupCell.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "DetailImageGroupCell.h"

@interface DetailImageGroupCell ()
@property(nonatomic,strong) SDCycleScrollView *sdCycleScrollView;
@end

@implementation DetailImageGroupCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}
- (void)configViews{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    _sdCycleScrollView = [[SDCycleScrollView alloc]init];
    _sdCycleScrollView.frame = self.bounds;
    [self.contentView addSubview:_sdCycleScrollView];
}
- (void)setImageGroups:(NSArray *)images{
    [_sdCycleScrollView setLocalizationImageNamesGroup:images];
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
