//
//  BaseViewController.h
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/2.
//  Copyright © 2016年 honely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface BaseViewController : UIViewController

@property(nonatomic,retain) MBProgressHUD *hud;

- (CGSize)countHeight:(NSString *)context font:(float)num  witd:(float)witd;//计算label高度
- (UIImage*) createImageWithColor: (UIColor*) color;//颜色转图片
- (NSDictionary *) dataArray:(NSArray *)array;

//显示加载
- (void)showHUD:(NSString *)title;
//隐藏加载
- (void)hideHUD;

@end
