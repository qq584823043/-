//
//  CitySelectedViewController.h
//  城市选择器
//
//  Created by jun on 16/4/22.
//  Copyright © 2016年 jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@protocol CityDelegate <NSObject>
-(void)didSelectedCity:(AddressModel *)addressModel;
@end

@interface CitySelectedViewController : UIViewController
@property(nonatomic,assign)id<CityDelegate> delegate;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)NSMutableDictionary *dictionary;

/* 省*/
@property(nonatomic,copy)NSString *province;
/* 市*/
@property(nonatomic,copy)NSString *city;
/* 区*/
@property(nonatomic,copy)NSString *district;
@end
