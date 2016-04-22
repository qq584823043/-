//
//  AddressModel.h
//  城市选择器
//
//  Created by jun on 16/4/22.
//  Copyright © 2016年 jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
/* 省*/
@property(nonatomic,copy)NSString *province;
/* 市*/
@property(nonatomic,copy)NSString *city;
/* 区*/
@property(nonatomic,copy)NSString *district;

@end
