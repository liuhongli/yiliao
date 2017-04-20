//
//  BaseViewController.h
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/2.
//  Copyright © 2016年 honely. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController


- (CGSize)countHeight:(NSString *)context font:(float)num  witd:(float)witd;//计算label高度
- (UIImage*) createImageWithColor: (UIColor*) color;//颜色转图片
- (NSDictionary *)listType:(NSInteger )type dataArray:(NSArray *)array;
@end
