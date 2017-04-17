//
//  ChatViewController.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@property (nonatomic,strong) UserInfoModel *userInfo;
@property (nonatomic,strong) UserInfoModel *targetUserInfo;
@end

@implementation ChatViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _userInfo = [UserInfoDao getUserInfoWithUserId:self.userId];
    _targetUserInfo = [UserInfoDao getUserInfoWithUserName:self.targetId];
    self.title = _targetUserInfo.nickName;
}

//-(void)didSendMessage:(NSInteger)status content:(RCMessageContent *)messageContent{
//    //可以在这里修改将要发送的消息
//    if ([messageContent isMemberOfClass:[RCTextMessage class]]) {
//        RCTextMessage *msg = (RCTextMessage *)messageContent;
//        NSString *text = msg.content;
//        [self sendMessageWithMessage:text];
//    }
//}
//- (void)sendMessageWithMessage:(NSString *)message{
////    dispatch_async(dispatch_get_main_queue(), ^{
//        [_config request_UserIDwithSuccessBlock:^(NSString *str) {
//            [_apiRequest request_OpenAPIWithInfo:message successBlock:^(NSDictionary *dict) {
//                NSLog(@"apiResult =%@",dict);
//                NSString *text = [dict objectForKey:@"text"];
//                RCTextMessage *content = [[RCTextMessage alloc]init];
//                content.content = text;
//                content.senderUserInfo = [[RCUserInfo alloc]initWithUserId:@"1001" name:_targetUserInfo.nickName portrait:_targetUserInfo.headerImageUrl];
//                [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:[NSString stringWithFormat:@"%ld",_userInfo.userId] content:content pushContent:text pushData:text success:^(long messageId) {
//                    NSLog(@"发送成功。。");
//                } error:^(RCErrorCode nErrorCode, long messageId) {
//                    NSLog(@"发送失败。。");
//                }];
//            } failBlock:^(TRRAPIErrorType errorType, NSString *infoStr) {
//                NSLog(@"errorinfo = %@", infoStr);
//            }];
//        }failBlock:^(TRRAPIErrorType errorType, NSString *infoStr) {
//            NSLog(@"erroresult = %@", infoStr);
//        }];
////    });
//    
//}
//- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageContent {
//    //可以在这里修改将要发送的消息
//    if ([messageContent isMemberOfClass:[RCTextMessage class]]) {
//        RCTextMessage *msg = (RCTextMessage *)messageContent;
//        NSString *text = msg.content;
//        [self sendMessageWithMessage:text];
//    }
//    return messageContent;
//}

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
