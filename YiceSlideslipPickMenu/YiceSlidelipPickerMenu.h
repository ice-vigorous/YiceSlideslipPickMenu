//
//  YiceSlidelipPickBackgroundView.h
//  YiceSlideslipPick
//
//  Created by 音冰冰 on 2018/5/31.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YiceSlidelipPickCommonModel.h"
@class YiceSlidelipPickerMenu;

@protocol YiceSlidelipPickerMenuDataSource <NSObject>
@required
- (NSInteger)menu:(YiceSlidelipPickerMenu *)menu numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInMenu:(YiceSlidelipPickerMenu *)menu;
- (NSString *)menu:(YiceSlidelipPickerMenu *)menu titleForSection:(NSInteger)section;
@optional
- (YiceSlidelipPickCommonModel *)menu:(YiceSlidelipPickerMenu *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol YiceSlidelipPickerMenuDelegate <NSObject>

@optional
- (void)menu:(YiceSlidelipPickerMenu *)menu didSelectRowAtIndexPath:(NSIndexPath *)indexPath;//单选选中

- (void)menu:(YiceSlidelipPickerMenu *)menu didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;//单选取消选中

- (void)reloadDataWithMenu:(YiceSlidelipPickerMenu *)menu;

- (void)menu:(YiceSlidelipPickerMenu *)menu didSelectRowsAtIndexPaths:(NSArray<NSIndexPath *>*)indexPaths;//多选,这里不做延伸了，有兴趣的朋友自己拓展

- (void)menu:(YiceSlidelipPickerMenu *)menu submmitSelectedIndexPaths:(NSArray<NSIndexPath*>*)indexpaths;
@end

@interface YiceSlidelipPickerMenu : UIView

@property (nonatomic, assign) id<YiceSlidelipPickerMenuDataSource> datasource;
@property (nonatomic, assign) id<YiceSlidelipPickerMenuDelegate> delegate;

@end
