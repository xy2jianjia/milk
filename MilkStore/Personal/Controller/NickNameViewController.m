//
//  NickNameViewController.m
//  MilkStore
//
//  Created by monan on 2017/4/10.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "NickNameViewController.h"

@interface NickNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveNickName)];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)saveNickName{
    NSString *nickName = self.nickNameTextField.text;
    if ([nickName length] == 0) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"填写昵称" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return;
    }
    UserInfoModel *userInfo = [UserInfoDao getUserInfoWithUserId:[NSString stringWithFormat:@"%ld",self.userId]];
    userInfo.nickName = nickName;
    [UserInfoDao updateUserInfo:userInfo];
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
