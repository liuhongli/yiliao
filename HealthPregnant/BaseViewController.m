//
//  BaseViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/2.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Target specifies product type 'com.apple.product-type.bundle.ui-testing', but there's no such product type for the 'iphoneos' platform
    
    
    [self _initMyNav];

}

- (void)_initMyNav
{
//     设置返回按钮的背景图片
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
    UIImage *img = [UIImage imageNamed:@"返回按钮_ct"];
   
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-20, 0, 44, 44);
    
    [backBtn setImage:img forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:backBtn];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    if (self.navigationController.viewControllers.count >1) {

        self.navigationItem.leftBarButtonItem = backItem;
    }
}

#pragma mark ---------------------label 计算高度-----------------


- (CGSize)countHeight:(NSString *)context font:(float)num  witd:(float)witd {
    
    
    CGSize size= [context boundingRectWithSize:CGSizeMake(witd, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:num]} context:nil].size;
    return size ;
}

#pragma mark ---------------------颜色转图片-----------------

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (NSDictionary *)listType:(NSInteger )type dataArray:(NSArray *)array {
    NSDictionary *dic = USERINFO;
    if (!dic) {
        [Alert showWithTitle:@"请重新登录"];
        return nil;
    }

    NSDictionary *dataDic = array[0];
    NSString *listStr;
    if (type == 0) {
     
        listStr = @"generalSurveyList";
        
    }
    if (type == 1) {
       
        listStr = @"sportSurveyList";
    }
    if (type == 2) {

        listStr = @"dietarySurveyList";
    }

    NSString *tableName = [dataDic objectForKey:@"tableName"];
    NSDate *theDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd ";
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    NSArray *chidArr = [dataDic objectForKey:@"children"];
    for (NSDictionary *chidDic in chidArr) {
        NSInteger defaultValue = [[chidDic objectForKey:@"defaultValue"] integerValue];
        if (defaultValue != 0) {
            
            [paraDic setObject:[chidDic objectForKey:@"defaultValue"] forKey:[chidDic objectForKey:@"fieldName"]];
            
        }    }
    

    
    NSArray *parArr =@[@{@"field":paraDic,@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"inspectionOrder":@"1",@"recordTime":[dateFormatter stringFromDate:theDate],@"sign":@"1",@"tableName":tableName}];
    
   NSDictionary *para = @{@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"recordTime":[dateFormatter stringFromDate:theDate],listStr:parArr};
    return para;
}

- (void)backBtnClick:(UIButton *)btn
{
    DLog(@"--- navigation did click left btn -> back---")
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
