//
//  YZPPickView.h
//  PickView
//
//  Created by 袁志浦 on 16/6/23.
//  Copyright © 2016年 北京内圈科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provice.h"


@protocol YZPPickViewDelegate <NSObject>

- (void)didSelectPickView:(Provice*)provice city:(City *)city region:(Region *)region;

@end


@interface YZPPickView : UIView

@property(nonatomic,assign)id<YZPPickViewDelegate> delegate;

@property(nonatomic,assign)BOOL hasDefaul;

@end
