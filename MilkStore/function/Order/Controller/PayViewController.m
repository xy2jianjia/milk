//
//  PayViewController.m
//  MilkStore
//
//  Created by monan on 2017/4/14.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "PayViewController.h"
#import "PayCell.h"
@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(5, 0, 100, headerView.frame.size.height);
    nameLabel.text = @"订单金额";
    nameLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:nameLabel];
    
    UILabel *amountLabel = [[UILabel alloc]init];
    amountLabel.frame = CGRectMake(SCREEN_WIDTH - 110, 0, 100, headerView.frame.size.height);
    amountLabel.text = [NSString stringWithFormat:@"%.2f元",_orderModel.totalAmount];
    amountLabel.font = [UIFont systemFontOfSize:14];
    amountLabel.textAlignment = NSTextAlignmentRight;
    amountLabel.textColor = [UIColor redColor];
    [headerView addSubview:amountLabel];
    
    self.tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PayCell" owner:self options:nil] lastObject];
    NSString *name = nil;
    NSString *detail = nil;
    UIImage *image = nil;
    if (indexPath.row == 0) {
        name = @"微信支付";
        image = [UIImage imageNamed:@"wx"];
        detail = @"微信安全支付";
    }else if(indexPath.row == 1){
        name = @"支付宝支付";
        image = [UIImage imageNamed:@"alipay"];
        detail = @"支付宝安全支付";

    }else if(indexPath.row == 2){
        name = @"银联支付";
        image = [UIImage imageNamed:@"yinlian"];
        detail = @"中国银联在线支付服务";
        
    }else if(indexPath.row == 3){
        name = @"Apple Pay";
        image = [UIImage imageNamed:@"apple"];
        detail = @"初次使用请先设置Apple Pay";
        
    }
    [cell setImage:image name:name detail:detail];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showHudInView:self.view hint:@"请稍后."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHud];
        _orderModel.status = 1;
        [OrderDao updateCartInfo:_orderModel];
        [self showHint:@"支付成功"];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

@end
