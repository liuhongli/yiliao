//
//  RAnserModel.h
//  JSClient
//
//  Created by 刘宏立 on 15/9/21.
//  Copyright (c) 2015年 honely. All rights reserved.
//

#import "RBaseModel.h"

@interface RAnserModel : RBaseModel
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSArray *answer_options;
@property(nonatomic,assign) BOOL isSelected;

@property(nonatomic,strong) NSString *answer_id;
@property(nonatomic,strong) NSString *numId;
@property(nonatomic,strong) NSString *options;


@end
