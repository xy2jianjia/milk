//
//  NSObject+fontSize.h
//  IMCHUMO
//
//  Created by xy2 on 16/9/5.
//  Copyright © 2016年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (fontSize)
/**
 *  获取文字高度
 *
 *  @param string 内容
 *  @param size   内容所在容器size
 *  @param font   字体大小
 *
 *  @return 
 */
- (CGFloat)heightFromString:(NSString *)string containerSize:(CGSize )size font:(CGFloat )font;
/**
 *  获取文字宽度
 *
 *  @param string <#string description#>
 *  @param size   <#size description#>
 *  @param font   <#font description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)widthFromString:(NSString *)string containerSize:(CGSize )size font:(CGFloat )font;
/**
 *  获取文字size
 *
 *  @param string <#string description#>
 *  @param size   <#size description#>
 *  @param font   <#font description#>
 *
 *  @return <#return value description#>
 */
- (CGSize)sizeFromString:(NSString *)string containerSize:(CGSize )size font:(CGFloat )font;
/**
 *  获取文字frame
 *
 *  @param string <#string description#>
 *  @param size   <#size description#>
 *  @param font   <#font description#>
 *
 *  @return <#return value description#>
 */
- (CGRect)frameFromString:(NSString *)string containerSize:(CGSize )size font:(CGFloat )font;
@end
