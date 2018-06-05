//
//  NSString+AdjustSize.m
//  YicePicker
//
//  Created by 音冰冰 on 2018/5/3.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import "NSString+AdjustSize.h"

@implementation NSString (AdjustSize)

- (CGSize)yice_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
    attr[NSFontAttributeName] = font;
    return [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
    
}

- (CGSize)yice_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    return [self yice_stringSizeWithFont:font maxWidth:maxWidth maxHeight:MAXFLOAT];
}

- (CGSize)yice_stringSizeWithFont:(UIFont *)font
{
    return [self yice_stringSizeWithFont:font maxWidth:MAXFLOAT maxHeight:MAXFLOAT];
}


@end
