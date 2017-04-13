//
//  NSObject+Regular.m
//  IMCHUMO
//
//  Created by xy2 on 16/9/7.
//  Copyright © 2016年 xy2. All rights reserved.
//

#import "NSObject+Regular.h"

@implementation NSObject (Regular)
//微信号
- (BOOL) validateWX:(NSString *)WX
{
    NSString *wxRegex = @"^[0-9a-zA-Z_]+$";
    NSPredicate *wxTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", wxRegex];
    BOOL flag = [wxTest evaluateWithObject:WX];
    return flag;
}
//QQ号
- (BOOL) validateQQNUM:(NSString *)QQ
{
    NSString *qqRegex = @"^\\d+$";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", qqRegex];
    return [qqTest evaluateWithObject:QQ];
}
- (BOOL)includeChineseWithString:(NSString *)str{
    for(int i=0; i< [str length];i++)
    {
        int a =[str characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}
- (BOOL) validateNumber:(NSString *)number
{
    
    NSString *wxRegex = @"^[1-9]\\d*$";
    NSPredicate *wxTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", wxRegex];
    BOOL flag = [wxTest evaluateWithObject:number];
    return flag;
}

- (NSInteger )randomIndexWithMaxNumber:(NSInteger )max min:(NSInteger )min{
    
    NSInteger index = (arc4random() % (max-min+1))+min;
    return index;
    
}
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//验证密码
- (BOOL) validatePassWord:(NSString *)password
{
    //密码iu开头，数字
    NSString *passWordRegex=@"^iu\\d+$";
    NSPredicate *passwordTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passwordTest evaluateWithObject:password];
    
}
- (NSString * )parseURLWithString:(NSString *)string {
    if (!string || [string isKindOfClass:[NSNull class]] || string.length == 0 || [string isEqualToString:@""]) {
        return nil;
    } else{
        NSError *error = nil;
        NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
//        if (!arrayOfAllMatches || [arrayOfAllMatches isKindOfClass:[NSNull class]] || arrayOfAllMatches.count == 0 ) {
//            return NO;
//        } else {
//            return YES;
//        }
        
         //提取出 URL
         for (NSTextCheckingResult *match in arrayOfAllMatches) {
             NSString* substringForMatch = [string substringWithRange:match.range];
             NSLog(@"%@",substringForMatch);
             return substringForMatch;
         }
         return nil;
         
    }
}
- (NSString *)imei{
    NSString *imei = [JNKeychain loadValueForKey:BUNDLEID_FOR_KEY];
    if (!imei) {
        NSString *identifierForVendor = [[[UIDevice currentDevice].identifierForVendor UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [JNKeychain saveValue:identifierForVendor forKey:BUNDLEID_FOR_KEY];
        return identifierForVendor;
    }else{
        return imei;
    }
}
/**
 *  生成32位uuid
 *
 *  @return
 */
- (NSString *)uuid{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}
- (void)saveUserId:(NSInteger )userId{
    [[NSUserDefaults  standardUserDefaults] setInteger:userId forKey:@"userId"];
}
- (NSInteger)userId{
    return [[NSUserDefaults  standardUserDefaults] integerForKey:@"userId"];
}
@end
