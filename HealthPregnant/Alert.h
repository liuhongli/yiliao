//
//  RLoginController.h
//  JSClient
//
//  Created by  honely on 15/8/19.
//  Copyright (c) 2015年 honely. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AlertSystemCustomViewDelegate <NSObject>

- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface AlertSystemCustom : UIView<AlertSystemCustomViewDelegate>

@property (nonatomic, retain) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, retain) UIView *dialogView;    // Dialog's container view
@property (nonatomic, retain) UIView *containerView; // Container within the dialog (place your ui elements here)

@property (nonatomic, assign) id<AlertSystemCustomViewDelegate> delegate;
@property (nonatomic, retain) NSArray *buttonTitles;
@property (nonatomic, assign) BOOL useMotionEffects;

@property (copy) void (^onButtonTouchUpInside)(AlertSystemCustom *alertView, int buttonIndex) ;

- (id)init;
/*!
 DEPRECATED: Use the [CustomIOSAlertView init] method without passing a parent view.
 */
- (id)initWithParentView: (UIView *)_parentView __attribute__ ((deprecated));

- (void)show;
- (void)close;

- (IBAction)customIOS7dialogButtonTouchUpInside:(id)sender;
- (void)setOnButtonTouchUpInside:(void (^)(AlertSystemCustom *alertView, int buttonIndex))onButtonTouchUpInside;

- (void)deviceOrientationDidChange: (NSNotification *)notification;
- (void)dealloc;



@end

@interface Alert : NSObject
@property (nonatomic, assign) double delayInSeconds;
/**
 *  错误提示
 *
 *  @param title 标题
 *
 *  @return 提示框
 */
+ (void)showWithTitle:(NSString *)title;



/**
 *  提示 系统样式 无按钮
 *
 *  @param title   标题
 *  @param message 提示语
 */
+ (void)showWithTitle:(NSString *)title Message:(NSString *)message automaticllyDismiss:(BOOL)automatic;




@end
