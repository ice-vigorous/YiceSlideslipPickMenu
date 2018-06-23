//
//  ViewController.m
//  YiceSlideslipPick
//
//  Created by 音冰冰 on 2018/5/31.
//  Copyright © 2018年 音冰冰. All rights reserved.
//

#import "ViewController.h"
#import "YiceSlidelipPickerMenu.h"
#import "YiceSlidelipPickPch.h"
#import "YiceSlidelipPickCommonModel.h"
@interface ViewController ()<YiceSlidelipPickerMenuDelegate,YiceSlidelipPickerMenuDataSource>

@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) NSArray *mainKindArray;
@property (nonatomic, strong) NSArray *subKindArray;
@property (nonatomic, strong) YiceSlidelipPickerMenu *pickMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btnSearch];
    self.mainKindArray = @[@"服务",@"球队",@"城市",@"品牌"];
    self.subKindArray = [NSMutableArray arrayWithArray:@[[NSMutableArray arrayWithArray:@[[self creatPcikMenuItemModelWithString:@"打车"],[self creatPcikMenuItemModelWithString:@"坐飞机"],[self creatPcikMenuItemModelWithString:@"坐高铁"],[self creatPcikMenuItemModelWithString:@"上珠穆朗玛峰呐呐呐"],[self creatPcikMenuItemModelWithString:@"尼泊尔的小山丘"],[self creatPcikMenuItemModelWithString:@"瓜迪奥拉的曼城生涯"]]],[NSMutableArray arrayWithArray:@[[self creatPcikMenuItemModelWithString:@"皇马"],[self creatPcikMenuItemModelWithString:@"巴萨"],[self creatPcikMenuItemModelWithString:@"塞维利亚"],[self creatPcikMenuItemModelWithString:@"西班牙人"],[self creatPcikMenuItemModelWithString:@"凯尔特人"],[self creatPcikMenuItemModelWithString:@"莫斯科中央陆军"],[self creatPcikMenuItemModelWithString:@"拜仁"],[self creatPcikMenuItemModelWithString:@"多特蒙德"],[self creatPcikMenuItemModelWithString:@"里昂"],[self creatPcikMenuItemModelWithString:@"尼斯"],[self creatPcikMenuItemModelWithString:@"曼城"],[self creatPcikMenuItemModelWithString:@"曼联"],[self creatPcikMenuItemModelWithString:@"阿森纳"],[self creatPcikMenuItemModelWithString:@"切尔西"],[self creatPcikMenuItemModelWithString:@"热刺"]]],[NSMutableArray arrayWithArray:@[[self creatPcikMenuItemModelWithString:@"拉萨"],[self creatPcikMenuItemModelWithString:@"赤峰"],[self creatPcikMenuItemModelWithString:@"墨尔本"],[self creatPcikMenuItemModelWithString:@"迪士尼"],[self creatPcikMenuItemModelWithString:@"加利福利亚"],[self creatPcikMenuItemModelWithString:@"洛杉矶"],[self creatPcikMenuItemModelWithString:@"波士顿"],[self creatPcikMenuItemModelWithString:@"克利夫兰"],[self creatPcikMenuItemModelWithString:@"圣安东尼奥"],[self creatPcikMenuItemModelWithString:@"德克萨斯"],[self creatPcikMenuItemModelWithString:@"新奥尔良"],[self creatPcikMenuItemModelWithString:@"华盛顿"]]],[NSMutableArray arrayWithArray:@[[self creatPcikMenuItemModelWithString:@"克里斯蒂亚诺.罗纳尔多"],[self creatPcikMenuItemModelWithString:@"李奥纳多.梅西"],[self creatPcikMenuItemModelWithString:@"我是梅西，我现在慌得一B"],[self creatPcikMenuItemModelWithString:@"德罗巴欧冠绝平"],[self creatPcikMenuItemModelWithString:@"巴乔点球踢飞"],[self creatPcikMenuItemModelWithString:@"雷阿伦关键三分"],[self creatPcikMenuItemModelWithString:@"詹姆斯连砍25分"],[self creatPcikMenuItemModelWithString:@"诺维斯基暴打波什"],[self creatPcikMenuItemModelWithString:@"吉诺比利蛇形突破"],[self creatPcikMenuItemModelWithString:@"哈登欧洲后撤步"],[self creatPcikMenuItemModelWithString:@"奥尼尔猴子挂树"],[self creatPcikMenuItemModelWithString:@"加加内特anything is possible"]]]]];
    // Do any additional setup after loading the view, typically from a nib.
}

-(UIButton *)btnSearch
{
    if (_btnSearch == nil) {
        _btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(deviceWidth()/2.0 - 50, deviceHeight()/2.0 - 20, 100, 40)];
        _btnSearch.backgroundColor = [UIColor blueColor];
        [_btnSearch setTitle:@"search" forState:UIControlStateNormal];
        [_btnSearch addTarget:self action:@selector(mSearchClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSearch;
}
-(YiceSlidelipPickerMenu *)pickMenu
{
    if (_pickMenu==nil) {
        _pickMenu=[[YiceSlidelipPickerMenu alloc] init];
        _pickMenu.delegate = self;
        _pickMenu.datasource = self;
    }
    return _pickMenu;
}

-(void)mSearchClick{
    self.pickMenu.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[[UIApplication sharedApplication].delegate window] addSubview:self.pickMenu];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.pickMenu cache:YES];
    [UIView setAnimationDuration:0.3];
    self.pickMenu.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];
}

#pragma mark ---- pickDatasource
- (NSInteger)menu:(YiceSlidelipPickerMenu *)menu numberOfRowsInSection:(NSInteger)section{
    return ((NSArray*)(self.subKindArray[section])).count;
}
- (NSInteger)numberOfSectionsInMenu:(YiceSlidelipPickerMenu *)menu{
    return self.mainKindArray.count;
}
- (NSString *)menu:(YiceSlidelipPickerMenu *)menu titleForSection:(NSInteger)section{
    return self.mainKindArray[section];
}

- (YiceSlidelipPickCommonModel *)menu:(YiceSlidelipPickerMenu *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * arraySectionData = self.subKindArray[indexPath.section];
    return arraySectionData[indexPath.row];
}

#pragma mark ---- pickdelegate

- (void)menu:(YiceSlidelipPickerMenu *)menu didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中

    NSMutableArray <YiceSlidelipPickCommonModel *> *arrayModel = self.subKindArray[indexPath.section];
    for (YiceSlidelipPickCommonModel *model in arrayModel) {
        model.isSelected = @"";
    }
    YiceSlidelipPickCommonModel *model = arrayModel[indexPath.row];
    model.isSelected = @"YES";
    
}

- (void)menu:(YiceSlidelipPickerMenu *)menu didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    YiceSlidelipPickCommonModel *model = self.subKindArray[indexPath.section][indexPath.row];
    model.isSelected = @"";
}

- (void)reloadDataWithMenu:(YiceSlidelipPickerMenu *)menu{
    //重置
    for (NSMutableArray <YiceSlidelipPickCommonModel*> *array in self.subKindArray) {
        for (YiceSlidelipPickCommonModel *model in array) {
            model.isSelected = @"";
        }
    }
}

- (void)menu:(YiceSlidelipPickerMenu *)menu submmitSelectedIndexPaths:(NSArray<NSIndexPath *> *)indexpaths{
    //同步数据
}


-(YiceSlidelipPickCommonModel*)creatPcikMenuItemModelWithString:(NSString*)str{
    
    YiceSlidelipPickCommonModel*model = [YiceSlidelipPickCommonModel new];
    model.isSelected = @"";
    model.text = str;
    return model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
