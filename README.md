# YiceSlideslipPickMenu
仿照京东APP、互海通APP的侧滑搜索，感兴趣的可以参考下思路



###更新选中的cell和Header的代理方法
@protocol YiceSlidelipPickerMenuDataSource <NSObject>
@required
- (NSInteger)menu:(YiceSlidelipPickerMenu *)menu numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInMenu:(YiceSlidelipPickerMenu *)menu;
- (YiceSlidelipPickCommonModel *)menu:(YiceSlidelipPickerMenu *)menu titleForSection:(NSInteger)section;
@optional
- (YiceSlidelipPickCommonModel *)menu:(YiceSlidelipPickerMenu *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol YiceSlidelipPickerMenuDelegate <NSObject>

@optional
- (void)menu:(YiceSlidelipPickerMenu *)menu didSelectRowAtIndexPath:(NSIndexPath *)indexPath;//单选选中

- (void)menu:(YiceSlidelipPickerMenu *)menu didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;//单选取消选中

- (void)menu:(YiceSlidelipPickerMenu *)menu clickHeaderAtIndexPath:(NSIndexPath *)indexPath;//点击header(选中全部或取消全部)

- (void)reloadDataWithMenu:(YiceSlidelipPickerMenu *)menu;

- (void)menu:(YiceSlidelipPickerMenu *)menu didSelectRowsAtIndexPaths:(NSArray<NSIndexPath *>*)indexPaths;//多选,这里不做延伸了，有兴趣的朋友自己拓展

- (void)menu:(YiceSlidelipPickerMenu *)menu submmitSelectedIndexPaths:(NSArray<NSIndexPath*>*)indexpaths;
@end

###代理方法的实现参照我的demo

###代理方法的调用
1、header的标题
header.mainTitle.text = ((YiceSlidelipPickCommonModel*)[self.datasource menu:self titleForSection:indexPath.section]).text;

2.cell的内容
cell.contentString = ((YiceSlidelipPickCommonModel*)[self.datasource menu:self titleForRowAtIndexPath:indexPath]).text;
