//
//  OSlickTableViewCell.h
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/7.
//  Copyright © 2016年 honely. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RJIWangDelegate <NSObject>


- (void)didUpdate:(NSString *)num atIndexPath:(NSIndexPath *)indexPath;

@end

@interface OSlickTableViewCell : UITableViewCell

@property(nonatomic,weak)id<RJIWangDelegate>delegate;

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSString *defaultValue;


@property (weak, nonatomic) IBOutlet UILabel *headTitle;
@property (weak, nonatomic) IBOutlet UIImageView *leftIMV;
@property (weak, nonatomic) IBOutlet UIImageView *rightIMV;

@end
