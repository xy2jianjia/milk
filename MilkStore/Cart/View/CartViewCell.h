//
//  CartViewCell.h
//  MilkStore
//
//  Created by monan on 2017/3/1.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedBlock)(BOOL isSelected);

@interface CartViewCell : UITableViewCell
@property (nonatomic,strong) SelectedBlock selectedBlock;
@property (nonatomic,strong) CartModel *cartModel;
@property (nonatomic,assign) BOOL isNeedHidden;
- (void)setCartModel:(CartModel *)cartModel;
@end
