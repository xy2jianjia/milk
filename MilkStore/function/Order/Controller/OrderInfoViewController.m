//
//  OrderInfoViewController.m
//  MilkStore
//
//  Created by monan on 2017/4/13.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "OrderInfoReceiverCell.h"
#import "CartViewCell.h"
#import "OrderInfoPayTypeCell.h"
#import "OderInfoInvoiceCell.h"
#import "OrderInfoAmountCell.h"
#import "SaveOrderView.h"
#import "NickNameViewController.h"
#import "PayViewController.h"
@interface OrderInfoViewController ()
@property (nonatomic,assign) float amount;
@property (nonatomic,strong) SaveOrderView *saveOrderView;
@property (nonatomic,strong) UserInfoModel *userInfo ;
@end

@implementation OrderInfoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    _saveOrderView.hidden = NO;
    _userInfo = [UserInfoDao getUserInfoWithUserId:self.userId];
    NSIndexSet *index = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationFade];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _saveOrderView.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [self.tableView registerClass:[CartViewCell class] forCellReuseIdentifier:@"cartcell"];
    
    _amount = 0.0;
    for (CartModel *cartModel in _cartArr) {
        _amount += cartModel.price*cartModel.count;
    }
    _saveOrderView = [SaveOrderView configBottomViewSaveOrderBlock:^{
        if (!_userInfo) {
            [self showHint:@"请先登录"];
            RegisterViewController *vc = [[RegisterViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            return ;
        }
        NSMutableString *str = [NSMutableString string];
        for (NSInteger i = 0; i < _cartArr.count; i ++) {
            CartModel *cartModel = [_cartArr objectAtIndex:i];
            if (i == _cartArr.count - 1) {
                [str appendFormat:@"%@",cartModel.cartId];
            }else{
                [str appendFormat:@"%@,",cartModel.cartId];
            }
        }
        OrderModel *orderModel = [[OrderModel alloc]init];
        orderModel.orderId = [self uuid];
        orderModel.receiverName = [_userInfo.nickName length] == 0 ?_userInfo.userName:_userInfo.nickName;
        orderModel.receiverTel = _userInfo.userName;
        orderModel.address = @"广西南宁市大学东路188号广西民族大学";
        orderModel.payType = 1;// 1、在线支付
        orderModel.invoice = @"不开发票";
        orderModel.totalAmount = _amount;
        orderModel.freight = 0;
        orderModel.cartIds = str;
        orderModel.time = [self stringFromDate:[NSDate date]];
        orderModel.status = 0;
        [OrderDao saveOrderInfo:orderModel];
        PayViewController *vc = [[PayViewController alloc]initWithStyle:UITableViewStyleGrouped];
        vc.orderModel = orderModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 || section == 3) {
        return 2;
    }else if(section == 1){
        return _cartArr.count;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        OrderInfoReceiverCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderInfoReceiverCell" owner:self options:nil] lastObject];
        NSString *nickName = _userInfo.nickName;
        [cell setNickName:nickName address:@"广西南宁市大学东路188号广西民族大学" phone:_userInfo.userName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if(indexPath.section == 1){
        CartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartcell" forIndexPath:indexPath];
        CartModel *cartModel = [_cartArr objectAtIndex:indexPath.row];
        cell.isNeedHidden = YES;
        [cell setCartModel:cartModel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            OrderInfoPayTypeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderInfoPayTypeCell" owner:self options:nil] lastObject];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else{
            OderInfoInvoiceCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OderInfoInvoiceCell" owner:self options:nil] lastObject];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }else{
        OrderInfoAmountCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderInfoAmountCell" owner:self options:nil] lastObject];
        if (indexPath.row == 0) {
            [cell setTitle:@"商品金额" amount:_amount];
        }else{
            [cell setTitle:@"运费" amount:0.0];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (!_userInfo) {
            [self showHint:@"请先登录"];
            RegisterViewController *vc = [[RegisterViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            return ;
        }
        NSString *nickName = _userInfo.nickName;
        if ([nickName length] == 0 || nickName == nil || [nickName isEqualToString:@"(null)"] || [nickName isEqualToString:@"null"]) {
            NickNameViewController *vc = [[NickNameViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else if(indexPath.section == 1){
        return 80;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            return 72;
        }else{
            return 40;
        }
    }else{
        return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
