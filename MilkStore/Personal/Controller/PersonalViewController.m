//
//  PersonalViewController.m
//  MilkStore
//
//  Created by monan on 2017/2/27.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalHeaderCell.h"
#import "PersonalCell.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end
@implementation PersonalViewController


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 6;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PersonalHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headercell" forIndexPath:indexPath];
        UserInfoModel *userInfo = [[UserInfoModel alloc]init];
        userInfo.userId = 1001;
        userInfo.userName = @"桂纶镁";
        userInfo.headerImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1309/04/c7/25263323_25263323_1378286758341_mthumb.jpg";
        cell.userInfo = userInfo;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UIImage *image = nil;
        NSString *text = nil;
        if (indexPath.row == 0) {
            image = [UIImage imageNamed:@"MoreMyAlbum_25x25_"];
            text = @"相册";
        }else if (indexPath.row == 1){
            image = [UIImage imageNamed:@"MoreMyFavorites_25x25_"];
            text = @"收藏";
        }else if (indexPath.row == 2){
            image = [UIImage imageNamed:@"MoreMyBankCard_25x25_"];
            text = @"钱包";
        }else if (indexPath.row == 3){
            image = [UIImage imageNamed:@"MoreGame_25x25_"];
            text = @"卡包";
        }else if (indexPath.row == 4){
            image = [UIImage imageNamed:@"MoreSetting_25x25_"];
            text = @"设置";
        }else{
            image = [UIImage imageNamed:@"MoreWeApp_25x25_"];
            text = @"表情";
        }
        [cell setImage:image text:text];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 35;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我";
    [self.tableView registerClass:[PersonalCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[PersonalHeaderCell class] forCellReuseIdentifier:@"headercell"];
    
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
