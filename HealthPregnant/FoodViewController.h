//
//  FoodViewController.h
//  HealthPregnant
//
//  Created by 刘宏立 on 16/12/12.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "BaseViewController.h"


typedef void (^FoodBlock)(NSDictionary *dic);



@interface FoodViewController : BaseViewController


@property (nonatomic,copy)FoodBlock block;

@property(nonatomic,assign)NSInteger comeType; //1早餐 2中 3晚 4加餐 5 修改
@end
