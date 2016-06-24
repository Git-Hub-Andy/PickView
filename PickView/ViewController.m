//
//  ViewController.m
//  PickView
//
//  Created by 袁志浦 on 16/6/23.
//  Copyright © 2016年 北京内圈科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "YZPPickView.h"

@interface ViewController ()<YZPPickViewDelegate>
{
    UITextField *_placeTF;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _placeTF = [[UITextField alloc] init];
    _placeTF.frame = CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width-40, 30);
    _placeTF.borderStyle = UITextBorderStyleRoundedRect;
    _placeTF.userInteractionEnabled = NO;
    [self.view addSubview:_placeTF];
    
    YZPPickView *pickView = [[YZPPickView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 200)];
    pickView.delegate = self;
    pickView.hasDefaul = YES;
    [self.view addSubview:pickView];
}

- (void)didSelectPickView:(Provice*)provice city:(City *)city region:(Region *)region {
    NSLog(@"%@%@%@",provice.name,city.name,region.name);
    
    _placeTF.text = [NSString stringWithFormat:@"%@%@%@",provice.name,city.name,region.name];
    NSString *string =  [UnCodePlace addressWithProviceCode:provice.code withCityCode:city.code withRegionCode:region.code];
    
    NSLog(@"%@",string);
}




@end
