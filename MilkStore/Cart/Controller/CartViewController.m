//
//  CartViewController.m
//  MilkStore
//
//  Created by monan on 2017/2/27.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "CartViewController.h"
#import "CartViewCell.h"
#import "TotalView.h"
#import "OrderInfoViewController.h"
@interface CartViewController ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *cartArr;
@property (nonatomic,strong) TotalView *totalView;
@property (nonatomic,assign) float totalAmount;
@end

@implementation CartViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    _cartArr = [NSMutableArray array];
    _dataSource = [CartDao getCartInfoWithPhoneUDID:self.imei];
    for (CartModel *cartModel in _dataSource) {
        if (cartModel.isSelected) {
            [_cartArr addObject:cartModel];
        }
    }
    [self setAmount];
    [self.tableView reloadData];
    
    _totalView.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _totalView.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _totalAmount = 0.0;
    self.navigationItem.title = @"购物车";
    
    [self.tableView registerClass:[CartViewCell class] forCellReuseIdentifier:@"cell"];
    _totalView = [TotalView configBottomViewCountBlock:^{
        if (_cartArr.count == 0) {
            [self showHint:@"请选择商品"];
            return ;
        }
        OrderInfoViewController *vc = [[OrderInfoViewController alloc]initWithStyle:UITableViewStyleGrouped];
        vc.cartArr = _cartArr;
        [self.navigationController pushViewController:vc animated:YES];
    } selectAllBlock:^{
        [_cartArr removeAllObjects];
        [_cartArr addObjectsFromArray:_dataSource];
        for (CartModel *cartModel in _cartArr) {
            cartModel.isSelected = YES;
            [CartDao updateCartInfo:cartModel];
        }
        [self.tableView reloadData];
        [self setAmount];
    }];
}
- (void)setAmount{
    _totalAmount = 0;
    for (CartModel *cartModel in _cartArr) {
        _totalAmount += cartModel.price*cartModel.count;
    }
     [_totalView setTotalMoney:_totalAmount];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CartModel *cartModel = [_dataSource objectAtIndex:indexPath.section];
    [cell setCartModel:cartModel];
    cell.selectedBlock = ^(BOOL isSelected){
        if (isSelected) {
            [_cartArr addObject:cartModel];
        }else{
            [_cartArr removeObject:cartModel];
        }
        [self setAmount];
        
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [[DetailViewController alloc]initWithStyle:(UITableViewStyleGrouped)];
    CartModel *cartModel = [_dataSource objectAtIndex:indexPath.item];
    GoodInfoModel *goodInfoModel = [DataSource getGoodInfoWithGoodId:cartModel.goodsId];
    vc.goodModel = goodInfoModel;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CartModel *item = [_dataSource objectAtIndex:indexPath.section];
        [CartDao deleteCartInfoWithId:item.cartId];
        [_dataSource removeObjectAtIndex:indexPath.section];
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:indexPath.section];
        [tableView deleteSections:indexset withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
