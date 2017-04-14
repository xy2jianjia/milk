//
//  OrderListViewController.m
//  MilkStore
//
//  Created by monan on 2017/4/14.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "OrderListViewController.h"
#import "CartViewCell.h"
#import "OrderListAmountCell.h"
@interface OrderListViewController ()
@property (nonatomic,strong) NSMutableArray *dataSource;
//@property (nonatomic,strong) NSMutableArray *cartArr;
@end

@implementation OrderListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    [self.tableView registerClass:[CartViewCell class] forCellReuseIdentifier:@"cartcell"];
    _dataSource = [OrderDao getOrderList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    OrderModel *item = [_dataSource objectAtIndex:section];
    NSArray *arr = [item.cartIds componentsSeparatedByString:@","];
    count = arr.count;
    return count + 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *item = [_dataSource objectAtIndex:indexPath.section];
    NSArray *arr = [item.cartIds componentsSeparatedByString:@","];
    if (arr.count == indexPath.row) {
        return 40;
    }
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *item = [_dataSource objectAtIndex:indexPath.section];
    NSArray *arr = [item.cartIds componentsSeparatedByString:@","];
    if (arr.count == indexPath.row) {
        OrderListAmountCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderListAmountCell" owner:self options:nil] lastObject];
        [cell setOrderModel:item];
        return cell;
    }else{
        CartViewCell *cartCell = [tableView dequeueReusableCellWithIdentifier:@"cartcell" forIndexPath:indexPath];
        NSArray *arr = [item.cartIds componentsSeparatedByString:@","];
        NSString *cartId = [arr objectAtIndex:indexPath.row ] ;
        CartModel *cartModel = [CartDao getCartInfoWithCartId:cartId];
        cartCell.isNeedHidden = YES;
        [cartCell setCartModel:cartModel];
        cartCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cartCell;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 40);
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor redColor];
    label.text = @"酷乐创牛奶专营店";
    return label;
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
