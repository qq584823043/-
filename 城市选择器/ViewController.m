//
//  ViewController.m
//  城市选择器
//
//  Created by jun on 16/4/22.
//  Copyright © 2016年 jun. All rights reserved.
//

#import "ViewController.h"
#import "CitySelectedViewController.h"

@interface ViewController ()<CityDelegate>
/* 省*/
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
/* 市*/
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
/* 区*/
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectCity:(id)sender {
    NSString *pathString = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
    NSMutableDictionary *  dict = [[NSMutableDictionary  alloc]  initWithContentsOfFile:pathString] ;
    
    CitySelectedViewController *v = [[CitySelectedViewController alloc]init];
    v.dictionary = dict;
    v.delegate = self;
    [self.navigationController pushViewController:v animated:YES];
}

#pragma mark - city delegate
-(void)didSelectedCity:(AddressModel *)addressModel{
    self.provinceLabel.text = addressModel.province;
    self.cityLabel.text = addressModel.city;
    self.districtLabel.text = addressModel.district;
}

@end
