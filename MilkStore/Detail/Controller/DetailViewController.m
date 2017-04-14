//
//  DetailViewController.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailImageGroupCell.h"
#import "DetailNameCell.h"
#import "DetailChooseCell.h"
#import "DetailAddressCell.h"
#import "BottomView.h"
#import "ChatViewController.h"
@interface DetailViewController ()
@property (nonatomic,strong) NSMutableArray *imageArr;

@end

@implementation DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [BottomView hideBottomView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArr = [NSMutableArray array];
    for (NSInteger index = 0; index < 5; index ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"1_%ld.jpg",(index + 1)]];
        [_imageArr addObject:image];
    }
    [self.tableView registerClass:[DetailImageGroupCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[DetailNameCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerClass:[DetailChooseCell class] forCellReuseIdentifier:@"cell3"];
    [self.tableView registerClass:[DetailAddressCell class] forCellReuseIdentifier:@"cell4"];
    
    [self configBottomView];
    
}
- (void)configBottomView{
    [BottomView configBottomViewWithCollectionBlock:^(BOOL flag) {
        ChatViewController *conversationVC = [[ChatViewController alloc]init];
        conversationVC.conversationType = ConversationType_PRIVATE;
        conversationVC.targetId = @"18172363603";
        conversationVC.title = @"酷乐创客服";
        [self.navigationController pushViewController:conversationVC animated:YES];
    } cartBlock:^(BOOL flag) {
        UserInfoModel *userInfo = [UserInfoDao getUserInfoWithUserId:[NSString stringWithFormat:@"%ld",self.userId]];
        CartModel *item = [[CartModel alloc]init];
        item.cartId = [self uuid];
        item.goodCharater = _goodModel.charater;
        item.goodsName = _goodModel.name;
        item.goodsId = _goodModel.id;
        item.goodImageUrl = _goodModel.image;
        item.price = _goodModel.price;
        item.count = 1;
        item.userId = userInfo.userId;
        item.udid = self.imei;
        
        [CartDao saveCartInfo:item userId:userInfo.userId];
        [self showHint:@"已添加到购物车"];
    } buyBlock:^(BOOL flag) {
        
    }];
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
    if (indexPath.row == 0) {
        return 250;
    }else if(indexPath.row == 1){
        return 110;
    }else if(indexPath.row == 2){
        return 30;
    }else{
        return 30;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DetailImageGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell setImageGroups:_imageArr];
        return cell;
    }else if(indexPath.row == 1){
        DetailNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.model = _goodModel;
        return cell;
    }else if(indexPath.row == 2){
        DetailChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.model = _goodModel;
        return cell;
    }else{
        DetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        return cell;
    }
    
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
