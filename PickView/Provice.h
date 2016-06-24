//
//  Provice.h
//  PickView
//
//  Created by 袁志浦 on 16/6/24.
//  Copyright © 2016年 北京内圈科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class City,Region;

@interface Provice : NSObject

@property (nonatomic, strong) NSArray<City *> *citys;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *code;

@end

@interface City : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<Region *> *regions;

@property (nonatomic, copy) NSString *code;

@end

@interface Region : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *code;

@end

@interface UnCodePlace : NSObject

//根据code码返回地址信息(不需要详细的地址信息的时候只传需要的code码；比如只需要省份只传省的code即可)
+ (NSMutableString *)addressWithProviceCode:(NSString*)proCode withCityCode:(NSString*)citCode withRegionCode:(NSString*)regionCode;

@end