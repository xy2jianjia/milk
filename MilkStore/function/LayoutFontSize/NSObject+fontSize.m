//
//  NSObject+fontSize.m
//  IMCHUMO
//
//  Created by xy2 on 16/9/5.
//  Copyright © 2016年 xy2. All rights reserved.
//

#import "NSObject+fontSize.h"

@implementation NSObject (fontSize)


// 文字宽度
- (CGFloat)heightFromString:(NSString *)string containerSize:(CGSize )size font:(CGFloat )font{
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.height;
}
- (CGFloat)widthFromString:(NSString *)string containerSize:(CGSize )size font:(CGFloat )font{
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}
- (CGSize)sizeFromString:(NSString *)string containerSize:(CGSize )size font:(CGFloat )font{
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil];
    return rect.size;
}
- (CGRect)frameFromString:(NSString *)string containerSize:(CGSize )size font:(CGFloat )font{
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil];
    return rect;
}
@end
