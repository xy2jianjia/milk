//
//  HttpOperation.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "HttpOperation.h"
#import<CommonCrypto/CommonDigest.h>
@implementation HttpOperation
+ (id)shareInstance{
    static HttpOperation *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HttpOperation alloc]init];
    });
    return manager;
}
- (id)getManager{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    return manger;
}
+ (void)asyncGetTokenWithUserInfo:(UserInfoModel *)userInfo completed:(void(^)(NSString *token ,NSInteger code,NSString *msg))completed{
    [[HttpOperation shareInstance] asyncGetTokenWithUserInfo:userInfo completed:completed];
}
- (void)asyncGetTokenWithUserInfo:(UserInfoModel *)userInfo completed:(void(^)(NSString *token ,NSInteger code,NSString *msg))completed{
    AFHTTPRequestOperationManager *manger = [self getManager];
    NSString *nonce = [NSString stringWithFormat:@"%ld",arc4random()%(1000000)];
    NSString * AppKey= @"vnroth0kvfpgo";
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    NSString *timestamp = [NSString stringWithFormat:@"%llu",theTime];
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@",@"Rthb6eDGle",nonce,timestamp];
    NSString *signature = [self sha1:str];
//    [manger.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manger.requestSerializer setValue:AppKey forHTTPHeaderField:@"App-Key"];
    [manger.requestSerializer setValue:nonce forHTTPHeaderField:@"nonce"];
    [manger.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manger.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
    
    NSString *userId =[NSString stringWithFormat:@"%ld",userInfo.userId];
    NSString *userName = userInfo.nickName;
    NSString *imageUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490713789020&di=394fe41a01f45b7371b8a506aa7de9fa&imgtype=0&src=http%3A%2F%2Fww1.sinaimg.cn%2Flarge%2F9838a740gw1exmia2ksr9j21kw0zk12o.jpg";
    NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",userName,@"name",imageUrl,@"portraitUri", nil];
    
    NSString *url = [NSString stringWithFormat:@"http://api.cn.ronghub.com/user/getToken.json"];
    url = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [manger POST:url parameters:temp success:^(AFHTTPRequestOperation *operation, id responseObject) {
//      成功后的处理
        NSError *err = nil;
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:&err];
        NSString *token = [info objectForKey:@"token"];
        NSInteger code = [[info objectForKey:@"code"] integerValue];
        completed(token,code,@"");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completed(nil,-1,@"error");
    }];
    
    
//    NSMutableURLRequest *request = [self postRequestWithURL:url ];
//    NSOperation *operation = [manger HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // 成功后的处理
//        NSError *err = nil;
//        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:&err];
//        NSString *token = [info objectForKey:@"token"];
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        // 失败后的处理
//    }];
//    [manger.operationQueue addOperation:operation];
}
//- (NSMutableURLRequest *)postRequestWithURL:(NSString *)url
//{
//    NSString *nonce = [NSString stringWithFormat:@"%ld",arc4random()%(1000000)];
//    NSString * AppKey= @"vnroth0kvfpgo";
//    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
//    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
//    NSString *timestamp = [NSString stringWithFormat:@"%llu",theTime];
//    
//    NSString *str = [NSString stringWithFormat:@"%@%@%@",@"Rthb6eDGle",nonce,timestamp];
//    NSString *signature = [self sha1:str];
//    
//    NSString *userId =@"1001";
//    NSString *userName = @"桂纶镁";
//    NSString *imageUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490622493408&di=82fabd2109363399317ea1265ecef71c&imgtype=0&src=http%3A%2F%2Fmxycsku.qiniucdn.com%2Fgroup5%2FM00%2FB2%2F34%2FwKgBf1VjAmqAIA3mAEqbpeBYMkU52.jpeg";
//    NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",userName,@"name",imageUrl,@"portraitUri", nil];
//    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:nonce,@"nonce",AppKey,@"App-Key",timestamp,@"Timestamp",signature,@"Signature", nil];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
////    [request setAllHTTPHeaderFields:para];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:AppKey forHTTPHeaderField:@"App-Key"];
//    [request setValue:nonce forHTTPHeaderField:@"nonce"];
//    [request setValue:timestamp forHTTPHeaderField:@"Timestamp"];
//    [request setValue:signature forHTTPHeaderField:@"Signature"];
//    [request setHTTPBody:[temp JSONData]];
//    
//    return request;
//}

//sha1加密方式
- (NSString *) sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
@end
