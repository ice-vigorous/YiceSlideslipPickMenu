//
//  YiceSlidelipPickReusableView.h
//  YiceSlideslipPick
//
//  Created by 音冰冰 on 2018/5/31.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YiceSlidelipPickReusableView : UICollectionReusableView

@property (nonatomic, strong) UIButton *btnBackground;
@property (nonatomic, strong) UILabel *mainTitle;
@property (nonatomic, strong) UILabel *selectedTitle;
@property (nonatomic, assign) BOOL isShowAll;
@property (nonatomic, strong) UIImageView *arrowsIcon;//箭头
@property (nonatomic, strong) void(^btnClickBlock)(UIButton *btn);

@end
