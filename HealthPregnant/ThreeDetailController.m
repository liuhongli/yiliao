//
//  ThreeDetailController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/5/3.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "ThreeDetailController.h"
#import "ToLunchTableViewCell.h"
#import "EatTableViewCell.h"
#import "FoodViewController.h"

@interface ThreeDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ThreeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"睡眠时间调查";
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return 22;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *cellIndefier = @"cell";
        ToLunchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        
        if (!cell) {
            
            [tableView registerNib:[UINib nibWithNibName:@"ToLunchTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndefier];
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        

    }else{
        
        static NSString *cellIndefier = @"cell1";
        EatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        
        if (!cell) {

            [tableView registerNib:[UINib nibWithNibName:@"EatTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndefier];

            cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
            
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)didcliK:(UIButton *)button {
    
    switch (button.tag) {
        case 10:
        {
          
            
        }
            break;
            
        case 11:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodViewController *vc = [[FoodViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
