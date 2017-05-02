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

- (NSDictionary *)dataArray:(NSArray *)array {
    NSDictionary *dic = USERINFO;
    if (!dic) {
        [Alert showWithTitle:@"请重新登录"];
        return nil;
    }
    NSDate *theDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSMutableArray *generM = [NSMutableArray array];
    NSMutableArray *sportM = [NSMutableArray array];
    NSMutableArray *dietrM = [NSMutableArray array];
      for (int num = 0; num < array.count; num ++) {
        NSArray *contArray = array[num];
          
          NSLog(@"%ld",num);
          NSMutableDictionary *poscde1Dic = [NSMutableDictionary dictionary];

        for (int subNum = 0; subNum < contArray.count; subNum++) {
//            NSLog(@"subNum  == %ld",subNum);

            NSDictionary *dataDic = contArray[subNum];


            NSString *tableName = [dataDic objectForKey:@"tableName"];
            
            if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
                
                NSArray *chidArr = [dataDic objectForKey:@"children"];
                for (NSDictionary *chidDic in chidArr) {
                    NSInteger defaultValue = [[chidDic objectForKey:@"defaultValue"] integerValue];
                    if (defaultValue != 0) {
                        
                        [poscde1Dic setObject:[chidDic objectForKey:@"defaultValue"] forKey:[chidDic objectForKey:@"fieldName"]];
                    }
                }
             
            }
            
            if ([[dataDic objectForKey:@"code"] integerValue] == 1) {
                NSArray *chidArr = [dataDic objectForKey:@"children"];
                NSMutableDictionary *posDic = [NSMutableDictionary dictionary];
                for (NSDictionary *chidDic in chidArr) {
                    float defaultValue = [[chidDic objectForKey:@"defaultValue"] floatValue];
                    if (defaultValue != 0) {
                      [posDic setObject:[chidDic objectForKey:@"defaultValue"] forKey:[chidDic objectForKey:@"fieldName"]];
                    }
                }
                if (posDic.allKeys.count > 0) {
                    
                    
                    NSDictionary *parArr = @{@"field":posDic,@"foodTime":@"0",@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"inspectionOrder":@"1",@"recordTime":[dataDic objectForKey:@"addTime"],@"sign":@"1",@"tableName":tableName};
                    [sportM addObject:parArr];
                }

            }
            if ([[dataDic objectForKey:@"code"] integerValue] == 3) {
                NSArray *zaoA = [dataDic objectForKey:@"foodTime0"];
                NSMutableDictionary *zaoM = [NSMutableDictionary dictionary];
                for (NSDictionary *chidDic in zaoA) {
                    NSString *mst = [chidDic objectForKey:@"tableName"];
                    if (![zaoM objectForKey:mst]) {
                        [zaoM setObject:@[chidDic] forKey:mst];
                    }else{
                        NSMutableArray *zaoMUArr = [[zaoM objectForKey:mst] mutableCopy];
                        [zaoMUArr addObject:chidDic];
                        [zaoM setObject:zaoMUArr forKey:mst];
                    }
                }
                NSArray *zaoAllkeyArr = [zaoM allKeys];
                for (int i = 0; i < zaoAllkeyArr.count; i++) {
                    NSArray *subZarr = [zaoM objectForKey:zaoAllkeyArr[i]];
                    NSMutableDictionary *paraAADic = [NSMutableDictionary dictionary];
                    

                    tableName = [zaoAllkeyArr objectAtIndex:i];
                    for (NSDictionary *chidDic in subZarr) {
                        
                        NSInteger defaultValue = [[chidDic objectForKey:@"defaultValue"] integerValue];
                        if (defaultValue != 0) {
                            NSLog(@"1111");
                            [paraAADic setObject:[chidDic objectForKey:@"defaultValue"] forKey:[chidDic objectForKey:@"fieldName"]];
                            
                        }
                       
                        if (paraAADic.allKeys.count > 0) {
                            
                            NSLog(@"%@",[dataDic objectForKey:@"addTime"]);
                            
                            NSDictionary *parArr = @{@"field":paraAADic,@"foodTime":@"0",@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"inspectionOrder":@"1",@"recordTime":[dataDic objectForKey:@"addTime"],@"sign":@"1",@"tableName":tableName};
                            [dietrM addObject:parArr];
                        }
                        
                    }
                    

                    }
                
//中餐
                NSArray *zhonA = [dataDic objectForKey:@"foodTime1"];
                
                NSMutableDictionary *zhonM = [NSMutableDictionary dictionary];
                for (NSDictionary *chidDic in zhonA) {
                    NSString *mst = [chidDic objectForKey:@"tableName"];
                    if (![zhonM objectForKey:mst]) {
                        [zhonM setObject:@[chidDic] forKey:mst];
                    }else{
                        NSMutableArray *zaoMUArr = [[zhonM objectForKey:mst] mutableCopy];
                        [zaoMUArr addObject:chidDic];
                        [zhonM setObject:zaoMUArr forKey:mst];
                    }
                }
                NSArray *zhonAllkeyArr = [zhonM allKeys];
                for (int i = 0; i < zhonAllkeyArr.count; i++) {
                    NSArray *subZarr = [zhonM objectForKey:zhonAllkeyArr[i]];
                    NSMutableDictionary *paraBBDic = [NSMutableDictionary dictionary];

                    tableName = [zhonAllkeyArr objectAtIndex:i];
                    for (NSDictionary *chidDic in subZarr) {
                        
                        NSInteger defaultValue = [[chidDic objectForKey:@"defaultValue"] integerValue];
                        if (defaultValue != 0) {
                            NSLog(@"1111");
                            [paraBBDic setObject:[chidDic objectForKey:@"defaultValue"] forKey:[chidDic objectForKey:@"fieldName"]];
                            
                        }
                        
                        if (paraBBDic.allKeys.count > 0) {
                            
                            
                            NSDictionary *parArr = @{@"field":paraBBDic,@"foodTime":@"1",@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"inspectionOrder":@"1",@"recordTime":[dataDic objectForKey:@"addTime"],@"sign":@"1",@"tableName":tableName};
                            [dietrM addObject:parArr];
                        }
                        
                    }
                    
                    
                }
                
                
                //晚餐
                NSArray *wanA = [dataDic objectForKey:@"foodTime2"];
                
                NSMutableDictionary *wanM = [NSMutableDictionary dictionary];
                for (NSDictionary *chidDic in wanA) {
                    NSString *mst = [chidDic objectForKey:@"tableName"];
                    if (![wanM objectForKey:mst]) {
                        [wanM setObject:@[chidDic] forKey:mst];
                    }else{
                        NSMutableArray *zaoMUArr = [[wanM objectForKey:mst] mutableCopy];
                        [zaoMUArr addObject:chidDic];
                        [wanM setObject:zaoMUArr forKey:mst];
                    }
                }
                NSArray *wanAllkeyArr = [wanM allKeys];
                for (int i = 0; i < wanAllkeyArr.count; i++) {
                    NSArray *subZarr = [wanM objectForKey:wanAllkeyArr[i]];
                    tableName = [wanAllkeyArr objectAtIndex:i];
                    NSMutableDictionary *paraCCDic = [NSMutableDictionary dictionary];

                    for (NSDictionary *chidDic in subZarr) {
                        
                        NSInteger defaultValue = [[chidDic objectForKey:@"defaultValue"] integerValue];
                        if (defaultValue != 0) {
                            NSLog(@"1111");
                            [paraCCDic setObject:[chidDic objectForKey:@"defaultValue"] forKey:[chidDic objectForKey:@"fieldName"]];
                            
                        }
                        
                        if (paraCCDic.allKeys.count > 0) {
                            
                            NSDictionary *parArr = @{@"field":paraCCDic,@"foodTime":@"2",@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"inspectionOrder":@"1",@"recordTime":[dataDic objectForKey:@"addTime"],@"sign":@"1",@"tableName":tableName};
                            [dietrM addObject:parArr];
                        }
                        
                    }
                    
                    
                }
                

                
                
                //加餐
                NSArray *jiaA = [dataDic objectForKey:@"foodTime3"];
                
                NSMutableDictionary *jiaM = [NSMutableDictionary dictionary];
                for (NSDictionary *chidDic in jiaA) {
                    NSString *mst = [chidDic objectForKey:@"tableName"];
                    if (![jiaM objectForKey:mst]) {
                        [jiaM setObject:@[chidDic] forKey:mst];
                    }else{
                        NSMutableArray *zaoMUArr = [[jiaM objectForKey:mst] mutableCopy];
                        [zaoMUArr addObject:chidDic];
                        [jiaM setObject:zaoMUArr forKey:mst];
                    }
                }
                NSArray *jiaAllkeyArr = [jiaM allKeys];
                for (int i = 0; i < jiaAllkeyArr.count; i++) {
                    NSArray *subZarr = [jiaM objectForKey:jiaAllkeyArr[i]];
                    tableName = [jiaAllkeyArr objectAtIndex:i];
                    NSMutableDictionary *paraDDDic = [NSMutableDictionary dictionary];

                    for (NSDictionary *chidDic in subZarr) {
                        
                        NSInteger defaultValue = [[chidDic objectForKey:@"defaultValue"] integerValue];
                        if (defaultValue != 0) {
                            NSLog(@"1111");
                            [paraDDDic setObject:[chidDic objectForKey:@"defaultValue"] forKey:[chidDic objectForKey:@"fieldName"]];
                            
                        }
                        
                        if (paraDDDic.allKeys.count > 0) {
                            
                            NSDictionary *parArr = @{@"field":paraDDDic,@"foodTime":@"3",@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"inspectionOrder":@"1",@"recordTime":[dataDic objectForKey:@"addTime"],@"sign":@"1",@"tableName":tableName};
                            [dietrM addObject:parArr];
                        }
                        
                    }
                    
                    
                }


            
            }
            

         }
          
          if (poscde1Dic.allKeys.count > 0) {
              NSDictionary *dataDic = contArray[0];
              NSString *tableName = [dataDic objectForKey:@"tableName"];

              NSDictionary *parArr = @{@"field":poscde1Dic,@"foodTime":@"0",@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"inspectionOrder":@"1",@"recordTime":[dataDic objectForKey:@"addTime"],@"sign":@"1",@"tableName":tableName};
              [generM addObject:parArr];
          }
 
          

    }
    NSString *listStr;
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:[dic objectForKey:@"mobilePhone"] forKey:@"globalRecordNr"];
    [para setObject:[dateFormatter stringFromDate:theDate] forKey:@"recordTime"];
    if (generM.count > 0) {
        
        [para setObject:generM forKey:@"generalSurveyList"];
    }
    if (sportM.count > 0) {
        
        listStr = @"sportSurveyList";
        [para setObject:sportM forKey:@"sportSurveyList"];

    }
    if (dietrM.count > 0) {
        
        listStr = @"dietarySurveyList";
        [para setObject:dietrM forKey:@"dietarySurveyList"];

    }


    return para;
}
//显示加载
- (void)showHUD:(NSString *)title {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
}

//隐藏加载
- (void)hideHUD {
    [self.hud hide:YES];
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
