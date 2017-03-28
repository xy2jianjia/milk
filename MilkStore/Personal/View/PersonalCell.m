//
//  PersonalCell.m
//  MilkStore
//
//  Created by monan on 2017/3/27.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "PersonalCell.h"

@interface PersonalCell ()
@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UILabel *infoLabel;
@end

@implementation PersonalCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}
- (void)configViews{
    _imageV = [[UIImageView alloc]init];
    _imageV.frame = CGRectMake(10, 5, 25, 25);
    [self.contentView addSubview:_imageV];
    
    _infoLabel = [[UILabel alloc]init];
    _infoLabel.frame = CGRectMake(CGRectGetMaxX(_imageV.frame) + 10, CGRectGetMidY(_imageV.frame) - 10, 100, 20);
    _infoLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_infoLabel];
    
}
- (void)setImage:(UIImage *)image text:(NSString *)text{
    _imageV.image = image;
    _infoLabel.text = text;
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
