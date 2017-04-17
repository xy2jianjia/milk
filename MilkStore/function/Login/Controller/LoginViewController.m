//
//  LoginViewController.m
//  MilkStore
//
//  Created by monan on 2017/3/29.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic,strong) UserInfoModel *userInfo;
@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _userInfo = [UserInfoDao getUserInfoWithUserId:self.userId];
    _userNameTextField.text = _userInfo.userName;
    _passwordTextField.text = _userInfo.password;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 5;
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"w_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(backAction)];
    
}
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (IBAction)loginAction:(id)sender {
    
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    if (![self validateMobile:userName]) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"填写正确的手机号" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return;
    }
    if (!password) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"填写正确的密码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        return;
    }
    
    UserInfoModel *userInfo = [UserInfoDao getUserInfoWithUserName:userName];
    if (userInfo) {
        if ([password isEqualToString:userInfo.password]) {
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
            
            [RongCloud initializationRC];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        }
    }else{
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户信息不存在，请先注册" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
    
}
- (IBAction)registerAction:(id)sender {
    
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (IBAction)weiboAction:(id)sender {
    
    
}
- (IBAction)qqAction:(id)sender {
    
    
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
