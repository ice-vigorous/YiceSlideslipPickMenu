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
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];//添加侧滑手势
        pan.delegate = self;
        [self addGestureRecognizer:pan];//有问题
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
        _viewBackground = [[UIView alloc] initWithFrame:CGRectMake(yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN, 0, [UIScreen mainScreen].bounds.size.width - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN, [UIScreen mainScreen].bounds.size.height)];
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
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN, [UIScreen mainScreen].bounds.size.height - 50 - 20) collectionViewLayout:flowLayout];
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
                       withReuseIdentifier:headerID];
    }
    return _mainCollectionView;
}

-(UIView *)viewBottom
{
    if (_viewBottom == nil) {
        _viewBottom = [[UIView alloc] init];
        _viewBottom.backgroundColor = [UIColor whiteColor];
        _viewBottom.frame =  CGRectMake(0, CGRectGetMaxY(self.mainCollectionView.frame), [UIScreen mainScreen].bounds.size.width - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN, 50);
        
        _btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReset.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN)/2.0, 50);
        _btnReset.backgroundColor  = kPickerMenuCellUnselectedColor;
        [_btnReset setTitle:@"重置" forState:UIControlStateNormal];
        [_btnReset setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_btnReset addTarget:self action:@selector(resetPicker) forControlEvents:UIControlEventTouchUpInside];
        [_viewBottom addSubview:_btnReset];
        
        _btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSure.frame = CGRectMake(CGRectGetMaxX(_btnReset.frame), 0, ([UIScreen mainScreen].bounds.size.width - yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN)/2.0, 50);
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
        if (((YiceSlidelipPickCommonModel*)[self.datasource menu:self titleForSection:section]).isSelected.length>0)
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
//            NSLog(@"存在%ld------%ld",(long)header.tag,(long)indexPath.section);
        } else {
            header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
            header.tag = kBaseHeaderTag + indexPath.section;
//            NSLog(@"不存在%ld------%ld",(long)header.tag,(long)indexPath.section);
        }
        __weak typeof(header) weakHeader = header;
        __weak typeof(self) this = self;
        header.mainTitle.text = ((YiceSlidelipPickCommonModel*)[self.datasource menu:self titleForSection:indexPath.section]).text;
        header.isShowAll = ((YiceSlidelipPickCommonModel*)[self.datasource menu:self titleForSection:indexPath.section]).isSelected.length>0?YES:NO;
        header.mainTitle.frame = CGRectMake(10, 10, [((YiceSlidelipPickCommonModel*)[self.datasource menu:self titleForSection:indexPath.section]).text yice_stringSizeWithFont:[UIFont systemFontOfSize:yiceSlidelipPickMenuUIValue()->MAINTITLELABEL_FONT] maxWidth:[UIScreen mainScreen].bounds.size.width/2.0].width, 20);
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
            if ([self.datasource menu:self numberOfRowsInSection:indexPath.section] > 6) {
                header.arrowsIcon.image = [UIImage imageNamed:@"jiantou_up"];
            }else{
                header.arrowsIcon.image = [UIImage imageNamed:@" "];
            }
        }
        if ([collectionView indexPathsForSelectedItems]) {
            //判断有选中单位
            for (NSIndexPath * path in [collectionView indexPathsForSelectedItems]) {
                if (path.section == indexPath.section) {
                    header.selectedTitle.text = [self.datasource menu:self titleForRowAtIndexPath:path].text;
                    header.selectedTitle.textColor = [UIColor redColor];
                }
            }
        }
        header.btnClickBlock = ^(UIButton *btn) {
            //按钮点击
            weakHeader.isShowAll = !weakHeader.isShowAll;
            [this.delegate menu:this clickHeaderAtIndexPath:indexPath];
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
    //区头
    for (int i = 0; i< [self.datasource numberOfSectionsInMenu:self]; i++) {
        YiceSlidelipPickReusableView *header = [self.mainCollectionView viewWithTag:kBaseHeaderTag + i];
        header.isShowAll = NO;
    };
    //    
    //    //表尾
    //    self.dateFooter.startDate.text = @"";
    //    self.dateFooter.endDate.text = @"";
    
    //这里刷新一次会出现bug，所以刷新了两次
    [self.mainCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [self.mainCollectionView performSelector:@selector(reloadData) withObject:nil afterDelay:0.];
    
}

-(void)surePicker
{
    [self dismiss];
}

#pragma mark ----- 点击事件的处理

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 判断手势是否为 滑动手势
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGFloat translation = [(UIPanGestureRecognizer*)gestureRecognizer translationInView:self].y;
        if (translation!=0)
        {
            return NO;//竖直方向的滑动，不做响应
        }
        if ([gestureRecognizer locationInView:self].x>yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN) {
            [self dismiss];
        }
    }
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch =  [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.x) {
        if (point.x<yiceSlidelipPickMenuUIValue()->SCREEN_LEFTMARGIN) {
            [self dismiss];
        }
    }
}

- (void)dismiss{
    
    //做推回的动画
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
    [UIView setAnimationDuration:0.3];
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];
    [self synchrodata];
    
}

- (void)synchrodata{
    
    //数据提交
    //    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    if (self.footerTitle.length>0) {
    //        if (self.dateFooter.startDate.text.length>0) {
    //            [dic setValue:self.dateFooter.startDate.text forKey:@"startDate"];
    //        }
    //        if (self.dateFooter.endDate.text.length>0) {
    //            [dic setValue:self.dateFooter.endDate.text forKey:@"endDate"];
    //        }
    //    }
    [self.delegate menu:self submmitSelectedIndexPaths:[self.mainCollectionView indexPathsForSelectedItems]];
    
}

@end
