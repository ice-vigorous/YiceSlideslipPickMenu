//
//  YiceSlidelipPickBackgroundView.m
//  YiceSlideslipPick
//
//  Created by 音冰冰 on 2018/5/31.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import "YiceSlidelipPickerMenu.h"
#import "YiceSlidelipPickCell.h"
#import "YiceSlidelipPickReusableView.h"
#import "YiceSlidelipPickPch.h"
@interface YiceSlidelipPickerMenu()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *viewBackground;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) UIButton *btnReset;
@property (nonatomic, strong) UIButton *btnSure;
@end
static NSString * const collectionCellID = @"collectionCellID";
static NSString * const headerID = @"headerID";
const NSUInteger kBaseHeaderTag = 1234;
@implementation YiceSlidelipPickerMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.2];
        self.frame = CGRectMake(0, 0, deviceWidth(), deviceHeight());
        UITapGestureRecognizer *backgroundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundTapClick:)];
        backgroundTap.delegate = self;
        [self addGestureRecognizer:backgroundTap];
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews
{
    [self addSubview:self.viewBackground];
    [self.viewBackground addSubview:self.mainCollectionView];
    [self.viewBackground addSubview:self.viewBottom];
}

-(UIView *)viewBackground
{
    if (_viewBackground == nil)
    {
        _viewBackground = [[UIView alloc] initWithFrame:CGRectMake(yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN, 0, deviceWidth() - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN, deviceHeight())];
        _viewBackground.backgroundColor = kPickerMenuSelectedTextColor;
        
    }
    return _viewBackground;
}

-(UICollectionView *)mainCollectionView
{
    if (_mainCollectionView == nil)
    {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.sectionInset = UIEdgeInsetsMake(yiceSlidelipPickMenuUIValue()->ITEM_LEFTMARGIN, yiceSlidelipPickMenuUIValue()->ITEM_TOPMARGIN, yiceSlidelipPickMenuUIValue()->ITEM_RIGHTMARGIN, yiceSlidelipPickMenuUIValue()->ITEM_BOTTOMMARGIN);
        flowLayout.headerReferenceSize=CGSizeMake(yiceSlidelipPickMenuUIValue()->HEADER_WIDTH, yiceSlidelipPickMenuUIValue()->HEADER_HEIGHT);
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, deviceWidth() - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN, deviceHeight() - 50) collectionViewLayout:flowLayout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.allowsMultipleSelection = YES;
        _mainCollectionView.autoresizesSubviews = NO;
        _mainCollectionView.alwaysBounceVertical = NO;
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        _mainCollectionView.backgroundColor = kPickerMenuSelectedTextColor;
        _mainCollectionView.bounces = NO;
        [_mainCollectionView registerClass:[YiceSlidelipPickCell class] forCellWithReuseIdentifier:collectionCellID];
        [_mainCollectionView registerClass:[YiceSlidelipPickReusableView class]
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                       withReuseIdentifier:@"headerID"];
    }
    return _mainCollectionView;
}

-(UIView *)viewBottom
{
    if (_viewBottom == nil) {
        _viewBottom = [[UIView alloc] init];
        _viewBottom.backgroundColor = [UIColor whiteColor];
        _viewBottom.frame =  CGRectMake(0, self.mainCollectionView.frame.size.height, deviceWidth() - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN, 50);
        
        _btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReset.frame = CGRectMake(0, 0, (deviceWidth() - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN)/2.0, 50);
        _btnReset.backgroundColor  = kPickerMenuCellUnselectedColor;
        [_btnReset setTitle:@"重置" forState:UIControlStateNormal];
        [_btnReset setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_btnReset addTarget:self action:@selector(resetPicker) forControlEvents:UIControlEventTouchUpInside];
        [_viewBottom addSubview:_btnReset];
        
        _btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSure.frame = CGRectMake(CGRectGetMaxX(_btnReset.frame), 0, (deviceWidth() - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN)/2.0, 50);
        _btnSure.backgroundColor = kPickerMenuCellSelectedColor;
        [_btnSure setTitle:@"确定" forState:UIControlStateNormal];
        [_btnSure addTarget:self action:@selector(surePicker) forControlEvents:UIControlEventTouchUpInside];
        [_viewBottom addSubview:_btnSure];
    }
    return _viewBottom;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //选中
    [self.delegate menu:self didSelectRowAtIndexPath:indexPath];
    [UIView performWithoutAnimation:^{
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [self.delegate menu:self didDeselectRowAtIndexPath:indexPath];
    [UIView performWithoutAnimation:^{
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YiceSlidelipPickCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.contentString = ((YiceSlidelipPickCommonModel*)[self.datasource menu:self titleForRowAtIndexPath:indexPath]).text;
    if ([((YiceSlidelipPickCommonModel*)[self.datasource menu:self titleForRowAtIndexPath:indexPath]).isSelected isEqualToString:@"YES"])
    {
        cell.selected = YES;
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }else{
        cell.selected = NO;
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.datasource numberOfSectionsInMenu:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.datasource menu:self numberOfRowsInSection:section] > 6)
    {
        YiceSlidelipPickReusableView *header = [collectionView viewWithTag:kBaseHeaderTag+section];
        if (header.isShowAll)
        {
            //是展示全部
            return [self.datasource menu:self numberOfRowsInSection:section];
        }else{
            return 6;
        }
    }
    return [self.datasource menu:self numberOfRowsInSection:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return yiceSlidelipPickCellUIValue()->ITEMSIZE;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        YiceSlidelipPickReusableView *header;
        if ([collectionView viewWithTag:kBaseHeaderTag + indexPath.section]) {
            //如果存在，则不需要初始化，只需要在原有的基础上赋值
            header = [collectionView viewWithTag:kBaseHeaderTag + indexPath.section];
        } else {
            header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        }
        __weak typeof(header) weakHeader = header;
        header.tag = kBaseHeaderTag + indexPath.section;
        header.mainTitle.text = [self.datasource menu:self titleForSection:indexPath.section];
        header.mainTitle.frame = CGRectMake(10, 10, [[self.datasource menu:self titleForSection:indexPath.section] yice_stringSizeWithFont:[UIFont systemFontOfSize:yiceSlidelipPickMenuUIValue()->MAINTITLELABEL_FONT] maxWidth:deviceWidth()/2.0].width, 20);
        header.selectedTitle.frame = CGRectMake(CGRectGetMaxX(header.mainTitle.frame) + 10, 10, yiceSlidelipPickMenuUIValue()->HEADER_WIDTH - CGRectGetWidth(header.mainTitle.frame) - 20 - 20 - 7 - 10, 20);
        if (!header.isShowAll){
            //如果不是展示全部
            if ([self.datasource menu:self numberOfRowsInSection:indexPath.section] > 6) {
                header.selectedTitle.textColor = kPickerMenuUnselectedTextColor;
                header.selectedTitle.text = @"全部";
                header.arrowsIcon.image = [UIImage imageNamed:@"jiantou_down"];
            }else{
                header.selectedTitle.text = @"";
                header.arrowsIcon.image = [UIImage imageNamed:@" "];
            }
        }else{
            //如果是展示全部暂时先不做处理
            header.arrowsIcon.image = [UIImage imageNamed:@"jiantou_up"];
            
        }
        if ([collectionView indexPathsForSelectedItems]) {
            //判断有选中单位
            for (NSIndexPath * path in [collectionView indexPathsForSelectedItems]) {
                if (path.section == indexPath.section) {
                    //
                    header.selectedTitle.text = [self.datasource menu:self titleForRowAtIndexPath:path].text;
                    header.selectedTitle.textColor = [UIColor redColor];
                }
            }
        }
        header.btnClickBlock = ^(UIButton *btn) {
            //按钮点击
            weakHeader.isShowAll = !weakHeader.isShowAll;
            [UIView performWithoutAnimation:^{
                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
            }];
        };
        return header;
    }
    return nil;
}

-(void)resetPicker{
    [self.delegate reloadDataWithMenu:self];
    for (int i = 0; i< [self.datasource numberOfSectionsInMenu:self]; i++) {
        YiceSlidelipPickReusableView *header = [self.mainCollectionView viewWithTag:kBaseHeaderTag + i];
        header.isShowAll = NO;
    };
    
    //这里刷新一次会出现bug，所以刷新了两次
    [self.mainCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [self.mainCollectionView performSelector:@selector(reloadData) withObject:nil afterDelay:0.];
    
}

-(void)surePicker{
    [self removeFromSuperview];
}

#pragma mark ----- 点击事件的处理

-(void)backGroundTapClick:(UIGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self];
    if (point.x<yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN) {
        [self removeFromSuperview];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"YiceSlidelipPickerMenu"]) {
        return YES;
    }
    return NO;
}

@end
