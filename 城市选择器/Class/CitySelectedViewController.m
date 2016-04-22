//
//  CitySelectedViewController.m
//  城市选择器
//
//  Created by jun on 16/4/22.
//  Copyright © 2016年 jun. All rights reserved.
//

#import "CitySelectedViewController.h"
#import "ChineseString.h"

@interface CitySelectedViewController (){
    NSMutableArray *_showArray;
    NSMutableArray *_suoyinArray;
}

@property (weak, nonatomic) IBOutlet UITableView *cityTableView;

@end

@implementation CitySelectedViewController

-(id)init{
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
        _showArray = [NSMutableArray array];
        _dictionary = [NSMutableDictionary dictionary];
        //        _province = @"";
        //        _city = @"";
        //        _district = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_dictionary.count) {
        for (NSString *key in [_dictionary allKeys]) {
            [_array addObject:[_dictionary objectForKey:key]];
        }
    }
    
    NSMutableArray *array0 = [NSMutableArray array];
    if ([[_array firstObject] isKindOfClass:[NSDictionary class]]) {
        for (NSDictionary *dict in _array) {
            [array0 addObjectsFromArray:dict.allKeys];
        }
    }else if ([[_array firstObject] isKindOfClass:[NSString class]]){
        [array0 addObjectsFromArray:_array];
    }
    
    _showArray = [ChineseString LetterSortArray:array0];
    _suoyinArray = [ChineseString IndexArray:array0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//显示每组名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_suoyinArray objectAtIndex:section];
}

//右侧索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _suoyinArray;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _showArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array1 = [_showArray objectAtIndex:section];
    return array1.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [[_showArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dict ;//= [_array objectAtIndex:indexPath.row];
    
    if ([[_array firstObject] isKindOfClass:[NSDictionary class]]) {
        for (NSDictionary *dicts in _array) {
            if ([[dicts.allKeys firstObject] isEqualToString:[[_showArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]]) {
                dict = [NSMutableDictionary dictionaryWithDictionary:dicts];
            }
        }
        
        CitySelectedViewController * cityVC = [[CitySelectedViewController alloc]init];
        if ([[dict objectForKey:[dict.allKeys objectAtIndex:0]] isKindOfClass:[NSDictionary class]]) {
            cityVC.dictionary = [dict objectForKey:[dict.allKeys objectAtIndex:0]];
            cityVC.delegate = self.delegate;
        } else if ([[dict objectForKey:[dict.allKeys objectAtIndex:0]] isKindOfClass:[NSArray class]]){
            cityVC.array = [dict objectForKey:[dict.allKeys objectAtIndex:0]];
            cityVC.delegate = self.delegate;
        }
        if (!self.province) {//选择省
            cityVC.province = [[_showArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        } else if (!self.city){
            cityVC.province = self.province;
            cityVC.city = [[_showArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        }
        [self.navigationController pushViewController:cityVC animated:YES];
        
    }else if ([[_array firstObject] isKindOfClass:[NSString class]]){
        self.district = [[_showArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        AddressModel *addressModel = [[AddressModel alloc]init];
        addressModel.province = self.province;
        addressModel.city = self.city;
        addressModel.district = self.district;
        [self.delegate didSelectedCity:addressModel];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
