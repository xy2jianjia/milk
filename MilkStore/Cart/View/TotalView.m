//
//  TotalView.m
//  MilkStore
//
//  Created by monan on 2017/4/11.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "TotalView.h"

@interface TotalView ()
@property (nonatomic,strong) UIButton *selectAllBtn;
@property (nonatomic,strong) UILabel *totalLabel;
@property (nonatomic,strong) UIButton *orderBtn;
@end


@implementation TotalView

+ (TotalView *)shareView{
    static dispatch_once_t onceToken;
    static TotalView *view = nil;
    dispatch_once(&onceToken, ^{
        view = [[TotalView alloc]init];
    });
    return view;
}
+ (TotalView *)configBottomViewCountBlock:(CountBlock )countBlock selectAllBlock:(SelectAllBlock)selectAllBlock{
    return [[TotalView shareView] configBottomViewCountBlock:countBlock selectAllBlock:selectAllBlock];
}
- (TotalView *)configBottomViewCountBlock:(CountBlock )countBlock selectAllBlock:(SelectAllBlock)selectAllBlock{
    _countBlock = countBlock;
    _selectAllBlock = selectAllBlock;
    return [self configViews];
}
- (TotalView *)configViews{
    self.hidden = NO;
    self.backgroundColor = kUIColorFromRGB(0xffffff);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 40-44, SCREEN_WIDTH, 40);
        _selectAllBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _selectAllBtn.frame = CGRectMake(0, 0, CGRectGetHeight(self.bounds) - 0, CGRectGetHeight(self.bounds) - 0);
        [_selectAllBtn setTitle:@"全选" forState:(UIControlStateNormal)];
        _selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_selectAllBtn setTitleColor:kUIColorFromRGB(0x000000) forState:(UIControlStateNormal)];
//        [_selectAllBtn setBackgroundImage:[UIImage imageNamed:@"shopdetail_wangwang"] forState:(UIControlStateNormal)];
        [_selectAllBtn addTarget:self action:@selector(collectionBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_selectAllBtn];
        
        _totalLabel = [[UILabel alloc ]init];
        _totalLabel.frame = CGRectMake(CGRectGetMaxX(_selectAllBtn.frame)+5, 0, (SCREEN_WIDTH - 30)/2, CGRectGetHeight(self.bounds));
        _totalLabel.text = @"合计：¥ 0.00";
        [self addSubview:_totalLabel];
        
        _orderBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _orderBtn.frame = CGRectMake(CGRectGetMaxX(_totalLabel.frame), 0, CGRectGetWidth(_totalLabel.frame), CGRectGetHeight(self.bounds));
        [_orderBtn setTitle:@"去结算" forState:(UIControlStateNormal)];
        [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _orderBtn.backgroundColor = [UIColor redColor];
        [_orderBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_orderBtn];
        
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        [keyWindow addSubview:self];
    });
    return self;
}
- (void)setTotalMoney:(CGFloat )totalMoney{
    _totalLabel.text = [NSString stringWithFormat:@"合计：¥ %.2f",totalMoney];
}
+ (void)hideBottomView{
    [[TotalView shareView] hideBottomView];
}
- (void)hideBottomView{
    self.hidden = YES;
}
- (void)collectionBtnAction{
    _selectAllBlock();
}

- (void)buyBtnAction{
    _countBlock();
}
@end
