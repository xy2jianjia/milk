//
//  RegisterViewController.m
//  MilkStore
//
//  Created by monan on 2017/4/10.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)registerAction:(id)sender {
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    BOOL userNameFlag = [self validateMobile:userName];
    if (!userNameFlag) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"填写正确的手机号" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return;
    }
    if (!password) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"填写正确的密码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return;
    }
    UserInfoModel *userInfo = [[UserInfoModel alloc]init];
    userInfo.userId = [self longDateFromString:[self stringFromDate:[NSDate date]]];
    userInfo.userName = userName;
    userInfo.password = password;
    userInfo.headerImageUrl = nil;
    [UserInfoDao saveUserInfo:userInfo];
    [self saveUserId:userInfo.userId];
//    [self dismissViewControllerAnimated:YES completion:^{
//
//    }];
    LoginViewController *vc = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
