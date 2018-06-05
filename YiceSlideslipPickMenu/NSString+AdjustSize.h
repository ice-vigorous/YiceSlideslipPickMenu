//
//  NSString+AdjustSize.h
//  YicePicker
//
//  Created by 音冰冰 on 2018/5/3.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (AdjustSize)

- (CGSize)yice_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
- (CGSize)yice_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (CGSize)yice_stringSizeWithFont:(UIFont *)font;

@end
