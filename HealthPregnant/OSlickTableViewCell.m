//
//  OSlickTableViewCell.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/7.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "OSlickTableViewCell.h"

@implementation OSlickTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    
    if ([_defaultValue isEqualToString:@"1"]) {
      
        _leftIMV.image = [UIImage imageNamed:@"单选勾选框_dj"];
        _rightIMV.image = [UIImage imageNamed:@"单选勾选框_ct"];

    }else{
        
        _leftIMV.image = [UIImage imageNamed:@"单选勾选框_ct"];
        _rightIMV.image = [UIImage imageNamed:@"单选勾选框_dj"];

    }
    
}

- (IBAction)butSelect:(UIButton *)sender {
    
    if (sender.tag  == 100) {
        
        _leftIMV.image = [UIImage imageNamed:@"单选勾选框_dj"];
        _rightIMV.image = [UIImage imageNamed:@"单选勾选框_ct"];
        
        [_delegate didUpdate:@"0" atIndexPath:_indexPath];
        
    }else{
        
        _leftIMV.image = [UIImage imageNamed:@"单选勾选框_ct"];
        _rightIMV.image = [UIImage imageNamed:@"单选勾选框_dj"];

        [_delegate didUpdate:@"1" atIndexPath:_indexPath];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
