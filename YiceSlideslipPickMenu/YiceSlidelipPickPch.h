//
//  YiceSlidelipPickPch.h
//  YiceSlideslipPick
//
//  Created by 音冰冰 on 2018/5/31.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+AdjustSize.h"

#define kRGBColorFromHex(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]

#define kPickerMenuCellUnselectedColor             kRGBColorFromHex(0xF8F8F8)
#define kPickerMenuCellSelectedColor               kRGBColorFromHex(0x3296E1)
#define kPickerMenuUnselectedTextColor             kRGBColorFromHex(0x0D0D0D)
#define kPickerMenuSelectedTextColor               kRGBColorFromHex(0xFFFFFF)
#define WS(weakSelf)                              __weak typeof(self) weakSelf = self

typedef struct {
    
    CGFloat ANIMATION_DURATION;
    CGFloat SCREEN_LEFTMARGIN;
    CGFloat HEADER_HEIGHT;
    CGFloat HEADER_WIDTH;
    CGFloat MAINTITLELABEL_FONT;
    CGFloat SUBTITLELABEL_FONT;
    CGFloat ITEM_LEFTMARGIN;
    CGFloat ITEM_TOPMARGIN;
    CGFloat ITEM_RIGHTMARGIN;
    CGFloat ITEM_BOTTOMMARGIN;
    NSInteger ITEM_SECTION_DEFAULT_COUNT;
    
}YICESLIDELIPPICK_MENU_UI_VALUE;

typedef struct {
    
    CGFloat ITEM_HEIGHT;
    CGFloat ITEM_WIDTH;
    CGFloat ITEM_FONT;
    CGFloat ITEM_LABEL_CORNERRADIUS;
    CGSize ITEMSIZE;
    
}YICESLIDELIPPICK_CELL_UI_VALUE;

typedef struct {
    
    CGFloat BOTTOM_HEIGHT;
    CGFloat BOTTOM_FONT;
    
}YICESLIDELIPPICK_BOTTOM_UI_VALUE;

CGFloat deviceWidth();
CGFloat deviceHeight();

YICESLIDELIPPICK_MENU_UI_VALUE *yiceSlidelipPickMenuUIValue();
YICESLIDELIPPICK_CELL_UI_VALUE *yiceSlidelipPickCellUIValue();
YICESLIDELIPPICK_BOTTOM_UI_VALUE *yiceSlidelipPickBottomUIValue();


@interface YiceSlidelipPickPch : NSObject

@end
