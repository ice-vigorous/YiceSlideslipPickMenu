//
//  YiceSlidelipPickCell.m
//  YiceSlideslipPick
//
//  Created by 音冰冰 on 2018/5/31.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import "YiceSlidelipPickCell.h"
#import "YiceSlidelipPickPch.h"

@implementation YiceSlidelipPickCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self viewConfigWithFrame:frame];
    }
    return self;
}

- (void)viewConfigWithFrame:(CGRect)frame
{
    self.label = [[UILabel alloc] init];
    self.label.layer.cornerRadius = yiceSlidelipPickCellUIValue()->ITEM_LABEL_CORNERRADIUS;
    self.label.layer.masksToBounds = YES;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = kPickerMenuCellUnselectedColor;
    self.label.font = [UIFont systemFontOfSize:yiceSlidelipPickCellUIValue()->ITEM_FONT];
    self.label.frame = CGRectMake(0, 0, yiceSlidelipPickCellUIValue()->ITEM_WIDTH, yiceSlidelipPickCellUIValue()->ITEM_HEIGHT);
    [self addSubview:self.label];
}

- (void)setContentString:(NSString *)contentString
{
    _contentString = [contentString copy];
    _label.text = _contentString;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    _label.backgroundColor = selected ? kPickerMenuCellSelectedColor : kPickerMenuCellUnselectedColor;
    _label.textColor = selected ? kPickerMenuSelectedTextColor : kPickerMenuUnselectedTextColor;
}

@end
