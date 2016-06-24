//
//  Provice.m
//  PickView
//
//  Created by 袁志浦 on 16/6/24.
//  Copyright © 2016年 北京内圈科技有限公司. All rights reserved.
//

#import "Provice.h"
#import "MJExtension/MJExtension.h"

@implementation Provice

+ (NSDictionary *)objectClassInArray{
    return @{@"citys" : [City class]};
}

@end


@implementation City

+ (NSDictionary *)objectClassInArray{
    return @{@"regions" : [Region class]};
}

@end


@implementation Region

@end

@implementation UnCodePlace

//根据地区码返回地址信息
+ (NSMutableString *)addressWithProviceCode:(NSString*)proCode withCityCode:(NSString*)citCode withRegionCode:(NSString*)regionCode{
    
    NSMutableString *str = [NSMutableString string];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"all" ofType:@"json"];
    NSString *s = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *dicArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [Provice mj_objectArrayWithKeyValuesArray:dicArray];
    
    for (Provice *provice in array) {
        
        if ([proCode isEqual:provice.code]) {
            [str appendString:provice.name];
        }
        
    }
    
    for (Provice *provice in array) {
        
        for (City *city in provice.citys) {
            if ([citCode isEqual:city.code]) {
                [str appendString:city.name];
            }
        }
        
    }
    
    
    for (Provice *provice in array) {
        
        for (City *city in provice.citys) {
            for (Region *region in city.regions) {
                if ([regionCode isEqual:region.code]) {
                    [str appendString:region.name];
                }
            }
        }
        
    }
    
    return str;
}

@end

