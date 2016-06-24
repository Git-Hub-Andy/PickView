//
//  YZPPickView.m
//  PickView
//
//  Created by 袁志浦 on 16/6/23.
//  Copyright © 2016年 北京内圈科技有限公司. All rights reserved.
//

#import "YZPPickView.h"
#import "MJExtension/MJExtension.h"

@interface YZPPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

{
    NSMutableArray *_dataArray;
    UIPickerView *_pickerView;
}

@end

@implementation YZPPickView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [NSMutableArray arrayWithArray:[self AA]];
        //父类 UIView
        _pickerView = [[UIPickerView alloc]initWithFrame:self.bounds];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self addSubview:_pickerView];
    }
    return self;
}


- (void)setHasDefaul:(BOOL)hasDefaul{
    
    [self choosePlaceWithPickerView:_pickerView];
    
}
//UIPickerViewDataSource  必须实现的协议方法
//设置列的数目
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//设置某一列的行数目
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger selectedComponent0Row = [pickerView selectedRowInComponent:0];
    
    if (component == 0) {
        return _dataArray.count;
    }
    if (component == 1) {
        
        Provice *provice = _dataArray[selectedComponent0Row];
        return provice.citys.count;
        
    }
    if (component == 2) {
        NSInteger selectedRow = [pickerView selectedRowInComponent:1];
        
        Provice *provice = _dataArray[selectedComponent0Row];
        
        City *city = provice.citys[selectedRow];
        return city.regions.count;
    }
    return 0;

}

//--------------------UIPickerViewDelegate 协议 可选的方法
//设置某列某行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSInteger selectedComponent0Row = [pickerView selectedRowInComponent:0];
    
    if (component == 0) {
        
        Provice *provice = _dataArray[row];
        return provice.name;
    }
    if (component == 1) {
        
        Provice *provice = _dataArray[selectedComponent0Row];
        City *city = provice.citys[row];
        return city.name;
        
    }
    if (component == 2) {
        NSInteger selectedRow = [pickerView selectedRowInComponent:1];
        Provice *provice = _dataArray[selectedComponent0Row];
        City *city = provice.citys[selectedRow];
        Region *region = city.regions[row];
        return region.name;
    }
    return 0;
}

//当选中某一行的时候，pickerView 重新加载
//选中某列的某一行会调用的方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //刷新
    [pickerView  reloadAllComponents];
    //修改选中行 为 0行
    [pickerView selectRow:row inComponent:component animated:YES];
    
    [self choosePlaceWithPickerView:pickerView];

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
//自定义picker
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc]init];
        pickerLabel.font = [UIFont systemFontOfSize:14];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
    
}
////自定义宽度
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    if (component==0) {
//        return pickerView.bounds.size.width*0.6;
//    }
//    return pickerView.bounds.size.width*0.4;
//
//}


- (void)choosePlaceWithPickerView:(UIPickerView *)pickerView{
    NSInteger selectedComponent0Row = [pickerView selectedRowInComponent:0];
    Provice *provice = _dataArray[selectedComponent0Row];
    
    NSInteger selectedComponent1Row = [pickerView selectedRowInComponent:1];
    
    City *city = provice.citys[selectedComponent1Row];
    
    
    NSInteger selectedComponent2Row = [pickerView selectedRowInComponent:2];
    Region *reigon = city.regions[selectedComponent2Row];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectPickView:city:region:)]) {
        [_delegate didSelectPickView:provice city:city region:reigon];
    }
}
- (NSArray *)AA{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"all" ofType:@"json"];
    NSString *s = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *dicArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [Provice mj_objectArrayWithKeyValuesArray:dicArray];
    
    return array;
    
}
@end
