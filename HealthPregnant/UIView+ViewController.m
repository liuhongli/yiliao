//
//  UIView+ViewController.m
//  XinWang
//
//  Created by sunlifei on 15/1/26.
//  Copyright (c) 2015年 com.ccigmall. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    
    do {
        
        // 判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}

@end
