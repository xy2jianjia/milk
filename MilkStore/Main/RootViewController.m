//
//  RootViewController.m
//  MilkStore
//
//  Created by monan on 2017/2/27.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "RootViewController.h"
#import "ConversationController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configChildControllers];
}
- (void)configChildControllers{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    HomeLayout *layout = [[HomeLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    HomeViewController *homeVc = [[HomeViewController alloc]initWithCollectionViewLayout:layout];
    UINavigationController *nc1 = [[UINavigationController alloc]initWithRootViewController:homeVc];
    nc1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"home_normal"] selectedImage:[UIImage imageNamed:@"home_selected"]];
    
    
//    MessageViewController *messageVc = [[MessageViewController alloc]initWithStyle:(UITableViewStyleGrouped)];
    ConversationController *messageVc = [[ConversationController alloc]init];
    UINavigationController *nc2 = [[UINavigationController alloc]initWithRootViewController:messageVc];
    nc2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"message_normal"] selectedImage:[UIImage imageNamed:@"message_selected"]];
    
    CartViewController *cartVc = [[CartViewController alloc]initWithStyle:(UITableViewStyleGrouped)];
    UINavigationController *nc3 = [[UINavigationController alloc]initWithRootViewController:cartVc];
    nc3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[UIImage imageNamed:@"cart_normal"] selectedImage:[UIImage imageNamed:@"cart_selected"]];
    
    PersonalViewController *personalVc = [[PersonalViewController alloc]init];
    UINavigationController *nc4 = [[UINavigationController alloc]initWithRootViewController:personalVc];
    nc4.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"user_normal"] selectedImage:[UIImage imageNamed:@"user_selected"]];
    
    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [nc1.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
//    nc1.navigationBar.tintColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.tabBar.tintColor = [UIColor redColor];
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"w_tabbar_bg"]];
//    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.viewControllers = @[nc1,nc2,nc3,nc4];
    
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
