//
//  MKPAlertView.m
//  自定义提示弹出框
//
//  Created by 图合天驷 on 16/12/20.
//  Copyright © 2016年 毛凯平. All rights reserved.
//

#import "MKPAlertView.h"
// AlertW 宽
#define AlertW 280

// 各个栏目之间的距离
#define MKPSpace 10.0

@interface MKPAlertView ()

/** 弹窗 */
@property(nonatomic,retain) UIView *alertView;
/** title */
@property(nonatomic,retain) UILabel *titleLbl;
/** 内容 */
@property(nonatomic,retain) UIView *contV;
/** 确认按钮 */
@property(nonatomic,retain) UIButton *sureBtn;
/** 取消按钮 */
@property(nonatomic,retain) UIButton *cancleBtn;
/** 横线 */
@property(nonatomic,retain) UIView *lineView;
/** 竖线 */
@property(nonatomic,retain) UIView *verLineView;
/** 输入框1 */
@property(nonatomic,retain) UITextField *inputtF;
/** 输入框2 */
@property(nonatomic,retain) UITextField *inputtF2;
@end

@implementation MKPAlertView

-(instancetype)initWithTitle:(NSString *)title type:(NSInteger)type sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle
{
    
    if(self == [super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        self.alertView = [[UIView alloc]init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.frame = CGRectMake(0, 0, AlertW, 100);
        self.alertView.layer.position = self.center;
        self.comeType = type;
        if(title)
        {
            self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*MKPSpace, 2*MKPSpace, AlertW-4*MKPSpace, 20) AndText:title andIsTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.titleLbl];
            
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            
            self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 2*MKPSpace, titleW, titleH);
        }
        
            self.contV = [[UIView alloc] init];
            
            self.contV.frame = self.titleLbl?CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+MKPSpace, AlertW,60):CGRectMake(0, 2*MKPSpace,  AlertW, 60);
        
        UILabel *leftflab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 80, 40)];
        leftflab.textAlignment = NSTextAlignmentRight;
               
        UILabel *rightlab = [[UILabel alloc] initWithFrame:CGRectMake(AlertW-80, 10, 80, 40)];
        rightlab.textAlignment = NSTextAlignmentLeft;
       
        if (_comeType == 1) {
            self.inputtF = [[UITextField alloc] initWithFrame:CGRectMake(AlertW/2-50, 15, 45, 30)];
            [self.inputtF becomeFirstResponder];
            self.inputtF.textAlignment = NSTextAlignmentCenter;
            self.inputtF.keyboardType = UIKeyboardTypeNumberPad;
            self.inputtF.borderStyle = UITextBorderStyleRoundedRect;

            self.inputtF2 = [[UITextField alloc] initWithFrame:CGRectMake(AlertW/2+5, 15, 45, 30)];
            [self.inputtF2 becomeFirstResponder];
            self.inputtF2.textAlignment = NSTextAlignmentCenter;
            self.inputtF2.keyboardType = UIKeyboardTypeNumberPad;
            self.inputtF2.borderStyle = UITextBorderStyleRoundedRect;
            [self.contV addSubview:self.inputtF2];

            leftflab.text = @"血压";
            rightlab.text = @"mmHg";

        }else{
            
        self.inputtF = [[UITextField alloc] initWithFrame:CGRectMake(AlertW/2-50, 15, 100, 30)];
        [self.inputtF becomeFirstResponder];
        self.inputtF.textAlignment = NSTextAlignmentCenter;
        self.inputtF.keyboardType = UIKeyboardTypeNumberPad;
        self.inputtF.borderStyle = UITextBorderStyleRoundedRect;
       
        leftflab.text = @"重量";
        leftflab.font =[UIFont fontWithName:@"PingFangSC-Regular" size:16];
        rightlab.text = @"克";
        rightlab.font  = [UIFont fontWithName:@"PingFangSC-Regular" size:16];

       
        }
        
        [self.contV addSubview:self.inputtF];
        [self.contV addSubview:leftflab];
        [self.contV addSubview:rightlab];
        
        
        [self.alertView addSubview:self.contV];
            

        
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = self.contV?CGRectMake(0, CGRectGetMaxY(self.contV.frame)+2*MKPSpace, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+2*MKPSpace, AlertW, 1);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        //两个按钮
        if (cancleTitle && sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        if (cancleTitle && sureTitle) {
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
        }
        
        if(sureTitle && cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, 40);
            // 该背景色
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:192/255.0 blue:203/255.0 alpha:0.2]] forState:UIControlStateNormal];
            // 改颜色
//            [self.sureBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //只有取消按钮
        if (cancleTitle && !sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        //只有确定按钮
        if(sureTitle && !cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //计算高度
        CGFloat alertHeight = cancleTitle?CGRectGetMaxY(self.cancleBtn.frame):CGRectGetMaxY(self.sureBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        
        [self addSubview:self.alertView];
    }
    return self;
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 弹出
-(void)showMKPAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

-(void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - 回调 只设置2 -- > 确定才回调
- (void)buttonEvent:(UIButton *)sender
{
    if (sender.tag == 2) {
        if (self.resultIndex) {
            if (_comeType == 1) {
                if (self.inputtF.text == nil || self.inputtF2.text == nil) {
                    [Alert showWithTitle:@"请正确输入"];
                    return;
                }
                NSString * str = [NSString stringWithFormat:@"%@/%@",self.inputtF.text,self.inputtF2.text];
                self.resultIndex(str);

            }else{
                
                if (self.inputtF.text == nil) {
                    [Alert showWithTitle:@"请正确输入"];
                    return;
                }

                self.resultIndex(self.inputtF.text);
            }
        }
    }else{
        if (self.resultIndex) {
            self.resultIndex(@"cancle");
        }

    }
    [self removeFromSuperview];
}

@end
