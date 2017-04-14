//
//  PayCell.m
//  MilkStore
//
//  Created by monan on 2017/4/14.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "PayCell.h"

@interface PayCell ()
@property (weak, nonatomic) IBOutlet UIImageView *payImageV;
@property (weak, nonatomic) IBOutlet UILabel *payNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *payDetailLabel;

@end

@implementation PayCell
- (void)setImage:(UIImage *)image name:(NSString *)name detail:(NSString *)detail{
    
    _payImageV.image = image;
    _payNameLabel.text = name;
    _payDetailLabel.text = detail;
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
