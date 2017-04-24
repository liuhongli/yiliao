//
//  ThreeDetailController.h
//  HealthPregnant
//
//  Created by 刘宏立 on 16/5/3.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "BaseViewController.h"

@interface ThreeDetailController : BaseViewController
@property(nonatomic,assign)NSInteger comeType; //0睡眠时间 1职业 2运动

@property(nonatomic,copy)NSString *job;
@property(nonatomic,copy)NSString *dataStr;


@end
