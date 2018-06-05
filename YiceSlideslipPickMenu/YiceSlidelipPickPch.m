//
//  YiceSlidelipPickPch.m
//  YiceSlideslipPick
//
//  Created by 音冰冰 on 2018/5/31.
//  Copyright © 2018年 音冰冰. All rights reserved.;
//

#import "YiceSlidelipPickPch.h"

@interface YiceSlidelipPickPch()

@property (nonatomic, assign) YICESLIDELIPPICK_CELL_UI_VALUE *menuCellUIValue;
@property (nonatomic, assign) YICESLIDELIPPICK_BOTTOM_UI_VALUE *menuBottomUIValue;
@property (nonatomic, assign) YICESLIDELIPPICK_MENU_UI_VALUE *menuUIValue;
@end

@implementation YiceSlidelipPickPch

+ (instancetype)sharedInstance
{
    static YiceSlidelipPickPch *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YiceSlidelipPickPch alloc] init];
    });
    return sharedInstance;
}

-(YICESLIDELIPPICK_MENU_UI_VALUE *)menuUIValue
{
    static YICESLIDELIPPICK_MENU_UI_VALUE menuUIValue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menuUIValue.ANIMATION_DURATION = 0.5f;
        menuUIValue.SCREEN_LEFTMARGIN = 38.f;
        menuUIValue.HEADER_WIDTH = deviceWidth() - 38.f;
        menuUIValue.HEADER_HEIGHT = 40.f;
        menuUIValue.MAINTITLELABEL_FONT = 16.f;
        menuUIValue.SUBTITLELABEL_FONT = 12.f;
        menuUIValue.ITEM_LEFTMARGIN = 13.f;
        menuUIValue.ITEM_TOPMARGIN = 15.f;
        menuUIValue.ITEM_RIGHTMARGIN = 13.f;
        menuUIValue.ITEM_BOTTOMMARGIN = 15.f;
        menuUIValue.ITEM_SECTION_DEFAULT_COUNT = 6.f;
        _menuUIValue = &menuUIValue;
    });
    return _menuUIValue;
}

-(YICESLIDELIPPICK_BOTTOM_UI_VALUE *)menuBottomUIValue
{
    static YICESLIDELIPPICK_BOTTOM_UI_VALUE menuBottomUIValue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menuBottomUIValue.BOTTOM_FONT = 18.f;
        menuBottomUIValue.BOTTOM_HEIGHT = 50.f;
        _menuBottomUIValue = &menuBottomUIValue;
    });
    return _menuBottomUIValue;
}

-(YICESLIDELIPPICK_CELL_UI_VALUE *)menuCellUIValue
{
    static YICESLIDELIPPICK_CELL_UI_VALUE menuCellUIValue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menuCellUIValue.ITEM_FONT = 13.f;
        menuCellUIValue.ITEM_HEIGHT = 32.f;
        menuCellUIValue.ITEM_WIDTH = (deviceWidth() - 38.0 - 13.f*4)/3;
        menuCellUIValue.ITEM_LABEL_CORNERRADIUS = 5.f;
        menuCellUIValue.ITEMSIZE = CGSizeMake(menuCellUIValue.ITEM_WIDTH, menuCellUIValue.ITEM_HEIGHT);
        _menuCellUIValue = & menuCellUIValue;
    });
    return _menuCellUIValue;
}

@end

YICESLIDELIPPICK_MENU_UI_VALUE *yiceSlidelipPickMenuUIValue(){
    return [[YiceSlidelipPickPch sharedInstance] menuUIValue];
}

YICESLIDELIPPICK_CELL_UI_VALUE *yiceSlidelipPickCellUIValue(){
    return [[YiceSlidelipPickPch sharedInstance] menuCellUIValue];
}

YICESLIDELIPPICK_BOTTOM_UI_VALUE *yiceSlidelipPickBottomUIValue(){
    return [[YiceSlidelipPickPch sharedInstance] menuBottomUIValue];
}

CGFloat deviceWidth() {
    static CGFloat width;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        width = [[UIScreen mainScreen] bounds].size.width;
    });
    return width;
}

CGFloat deviceHeight() {
    static CGFloat height;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        height = [[UIScreen mainScreen] bounds].size.height;
    });
    return height;
}
