//
//  MKPAlertView.h
//  自定义提示弹出框
//
//  Created by 图合天驷 on 16/12/20.
//  Copyright © 2016年 毛凯平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertResult)(NSString  *inputWhat);

@interface MKPAlertView : UIView

/**  */
@property(nonatomic,copy) AlertResult resultIndex;
@property(nonatomic,assign) NSInteger comeType;// 1两个框   其他:默认单个


- (instancetype)initWithTitle:(NSString *)title type:(NSInteger)type sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

-(void)showMKPAlertView;

@end
