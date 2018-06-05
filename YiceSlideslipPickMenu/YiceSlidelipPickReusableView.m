//
//  YiceSlidelipPickReusableView.m
//  YiceSlideslipPick
//
//  Created by 音冰冰 on 2018/5/31.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import "YiceSlidelipPickReusableView.h"
#import "YiceSlidelipPickPch.h"

@implementation YiceSlidelipPickReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self viewConfigWith:frame];
    }
    return self;
}

- (void)viewConfigWith:(CGRect)frame
{
    self.btnBackground = [UIButton new];
    self.btnBackground.backgroundColor = kPickerMenuSelectedTextColor;
    self.btnBackground.frame = CGRectMake(0, 0, yiceSlidelipPickMenuUIValue()->HEADER_WIDTH, yiceSlidelipPickMenuUIValue()->HEADER_HEIGHT);
    [self.btnBackground addTarget:self action:@selector(selfClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnBackground];
    
    self.mainTitle = [[UILabel alloc] init];
    self.mainTitle.textAlignment = NSTextAlignmentLeft;
    self.mainTitle.textColor = kPickerMenuUnselectedTextColor;
    self.mainTitle.font = [UIFont systemFontOfSize:yiceSlidelipPickMenuUIValue()->MAINTITLELABEL_FONT];
    self.mainTitle.frame = CGRectZero;
    [self addSubview:self.mainTitle];
    
    self.selectedTitle = [[UILabel alloc] init];
    self.selectedTitle.textAlignment = NSTextAlignmentRight;
    self.selectedTitle.textColor = kPickerMenuUnselectedTextColor;
    self.selectedTitle.font = [UIFont systemFontOfSize:yiceSlidelipPickMenuUIValue()->SUBTITLELABEL_FONT];
    self.selectedTitle.frame = CGRectZero;
    [self addSubview:self.selectedTitle];
    
    self.arrowsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou_down"]];
    self.arrowsIcon.frame = CGRectMake(yiceSlidelipPickMenuUIValue()->HEADER_WIDTH - 7 - 20, 17.5, 7, 5);
    [self addSubview:self.arrowsIcon];
}

- (void)selfClick{
    //点击事件
    self.btnClickBlock(self.btnBackground);
    
}




@end
