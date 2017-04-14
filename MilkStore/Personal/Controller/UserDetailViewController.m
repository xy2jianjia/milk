//
//  UserDetailViewController.m
//  MilkStore
//
//  Created by monan on 2017/4/10.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "UserDetailViewController.h"
#import "PersonalHeaderCell.h"
#import "NickNameViewController.h"
@interface UserDetailViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) UserInfoModel *userInfo;
@end

@implementation UserDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _userInfo = [UserInfoDao getUserInfoWithUserId:[NSString stringWithFormat:@"%ld",self.userId]];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[PersonalHeaderCell class] forCellReuseIdentifier:@"headercell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 35;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PersonalHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headercell" forIndexPath:indexPath];
        UserInfoModel *userInfo = _userInfo;
        userInfo.headerImageUrl = [self getImage];
        cell.hideLabel = YES;
        cell.userInfo = userInfo;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if ([_userInfo.nickName isEqualToString:@"(null)"] || [_userInfo.nickName isEqualToString:@"null"] || _userInfo.nickName == nil) {
            cell.textLabel.text = @"修改昵称";
        }else{
            cell.textLabel.text = _userInfo.nickName;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self setHeaderImage];
    }else{
        NickNameViewController *vc = [[NickNameViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        self.navigationController.hidesBottomBarWhenPushed = YES;
    }
}
- (void)setHeaderImage{
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"本地相册",nil];
    myActionSheet.delegate = self;
    [myActionSheet showInView:self.view];
    [self.view bringSubviewToFront:myActionSheet];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //    self.chatBottom.hidden = YES;
    switch (buttonIndex){
        case 0:  //打开照相机拍照
            [self openCamera];
            break;
        case 1:  //打开本地相册
            [self openLocalPhoto];
            break;
        default:
            break;
    }
}
#pragma mark - 拍照
- (void)openCamera{
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.view.backgroundColor = kUIColorFromRGB(0x241b2a);
    imagePickerController.navigationBar.barTintColor = kUIColorFromRGB(0x241b2a);
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
}
#pragma mark - 本地相册
- (void)openLocalPhoto{
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.view.backgroundColor = kUIColorFromRGB(0x241b2a);
    imagePickerController.navigationBar.barTintColor = kUIColorFromRGB(0x241b2a);
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = nil;
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self saveImage:image];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)saveImage:(UIImage *)image{
    NSString *cache = [self cachePath];
    NSString *fullPath = [cache stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",self.imei]];
    NSData *fileData = UIImageJPEGRepresentation(image, 1);
    [fileData writeToFile:fullPath atomically:NO];
}
- (NSString *)cachePath{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    return cachePath;
}
- (NSString *)getImage{
    NSString *cache = [self cachePath];
    NSString *fullPath = [cache stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",self.imei]];
    //    UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
    return fullPath;
}

@end
