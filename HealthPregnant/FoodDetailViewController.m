//
//  FoodDetailViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 17/1/10.
//  Copyright © 2017年 honely. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "RegistTableViewCell.h"
#import "FoodViewController.h"
#import "MKPAlertView.h"

@interface FoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate> {
    
    NSArray *questionSArray;
    UITableView *table;
    
    UIView *m_actionV;
    UIView *j_actionV;
    UIDatePicker *datePicker;
    
    NSString *dateStr;//日期
    NSString *jobStr;//职业
    NSInteger jobSel;//默认职业
    
    NSString *canShiStr;//餐食

    
    NSArray *dinArray;
    NSInteger foodType;
    NSDictionary *replaceDic;


}

@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"膳食详情";
    replaceDic = [NSDictionary dictionary];
    questionSArray = @[@"日期",@"餐食",@"食物",@"重量"];
    dinArray = @[@"早餐",@"中餐",@"晚餐",@"加餐"];
    jobStr = @"早餐";
    [self initTableView];
}

- (void)initTableView {
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UIButton *buton  = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 40)];
    [buton setTitle:@"完成修改" forState:UIControlStateNormal];
    [buton addTarget:self action:@selector(postInfo) forControlEvents:UIControlEventTouchUpInside];
    [buton setBackgroundColor:BaseColor];
    [view addSubview:buton];
    table.tableFooterView = view;
    UIBarButtonItem *butItem = [[UIBarButtonItem alloc] initWithTitle:@"删除记录" style:UIBarButtonItemStylePlain target:self action:@selector(deleteInfo)];
    butItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = butItem;
    
}

- (void)deleteInfo{
    
    NSMutableArray *changArray = [shanshiPDic mutableCopy];
    [changArray removeObjectAtIndex:_indexRow];
    
    NSUserDefaults *defaultS =  [NSUserDefaults standardUserDefaults];
    [defaultS setObject:changArray forKey:@"user_shanshiPDic"];
    [defaultS synchronize];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)postInfo {
    NSMutableArray *changArray = [shanshiSDic mutableCopy];

    UITextField *dateTF = [self.view viewWithTag:1000];
    UITextField *typeTF = [self.view viewWithTag:1001];

    UITextField *wghTF = [self.view viewWithTag:1003];
    NSString *nowType;
    if ([typeTF.text isEqualToString:@"早餐"]) {
        nowType = @"1";
    }else if ([typeTF.text isEqualToString:@"中餐"]) {
        
        nowType = @"2";
    }else if ([typeTF.text isEqualToString:@"晚餐"]) {
        nowType = @"3";
    }else    if ([typeTF.text isEqualToString:@"加餐"]) {
        
        nowType = @"4";
    }
    NSMutableArray *dArray = [NSMutableArray array];
    
    NSArray *zaoArray = [_infoDic objectForKey:@"foodTime0"];
    for (NSDictionary *dic in zaoArray) {
        [dArray addObject:dic];
    }
    NSArray *zhongArray = [_infoDic objectForKey:@"foodTime1"];
    for (NSDictionary *dic in zhongArray) {
        [dArray addObject:dic];
    }
    NSArray *wanArray = [_infoDic objectForKey:@"foodTime2"];
    for (NSDictionary *dic in wanArray) {
        [dArray addObject:dic];
    }
    NSArray *jiaArray = [_infoDic objectForKey:@"foodTime3"];
    for (NSDictionary *dic in jiaArray) {
        [dArray addObject:dic];
    }
    NSString *dinerType = [[dArray objectAtIndex:_indexRow] objectForKey:@"foodTYpe"];
    if ([dateTF.text isEqualToString:[_infoDic objectForKey:@"addTime"]] ) {
        //操作没有改变日期：修改就餐类型（添加、删除）、没有修改就餐类型（替换）
        if ([dinerType isEqualToString:nowType]) {
          //操作没改变早晚餐类型
            
            if (_indexRow < zaoArray.count) {
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime0"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }
                NSMutableDictionary *repDic = [[zaoArr objectAtIndex:_indexRow] mutableCopy];
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];

                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];


                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                [zaoArr  replaceObjectAtIndex:_indexRow withObject:repDic];
                [_infoDic setValue:zaoArr  forKey:@"foodTime0"];
                
            }else if (_indexRow < zaoArray.count+zhongArray.count) {
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime1"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }
                NSMutableDictionary *repDic = [[zaoArr objectAtIndex:_indexRow-zaoArray.count] mutableCopy];
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                [zaoArr  replaceObjectAtIndex:_indexRow-zaoArray.count withObject:repDic];
                [_infoDic setValue:zaoArr  forKey:@"foodTime1"];

            }else if (_indexRow < zaoArray.count+zhongArray.count+wanArray.count) {
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime2"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }
                
                NSMutableDictionary *repDic = [[zaoArr objectAtIndex:_indexRow-zaoArray.count-zhongArray.count] mutableCopy];
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                [zaoArr  replaceObjectAtIndex:_indexRow-zaoArray.count-zhongArray.count withObject:repDic];
                [_infoDic setValue:zaoArr  forKey:@"foodTime2"];

            }else if (_indexRow < zaoArray.count+zhongArray.count+wanArray.count+jiaArray.count) {
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime3"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }
                NSMutableDictionary *repDic = [[zaoArr objectAtIndex:_indexRow-zaoArray.count-zhongArray.count-wanArray.count] mutableCopy];
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                [zaoArr  replaceObjectAtIndex:_indexRow-zaoArray.count-zhongArray.count-wanArray.count withObject:repDic];
                [_infoDic setValue:zaoArr  forKey:@"foodTime3"];

            }

        }else{
            //操作改变早晚餐类型
            NSMutableDictionary *repDic = [[dArray objectAtIndex:_indexRow] mutableCopy];

            if ([typeTF.text isEqualToString:@"早餐"]) {
                
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime0"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"1"] forKey:@"foodTYpe"];
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                [zaoArr  addObject:repDic];
                [_infoDic setValue:zaoArr  forKey:@"foodTime0"];

            }else if ([typeTF.text isEqualToString:@"中餐"]) {
                
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime1"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }

                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"2"] forKey:@"foodTYpe"];

                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                [zaoArr  addObject:repDic];
                [_infoDic setValue:zaoArr  forKey:@"foodTime1"];


            }else if ([typeTF.text isEqualToString:@"晚餐"]) {
                
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime2"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }

                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    [repDic setObject:@"3" forKey:@"foodTYpe"];
                    
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                [zaoArr  addObject:repDic];
                [_infoDic setValue:zaoArr  forKey:@"foodTime2"];
                

                
            }else    if ([typeTF.text isEqualToString:@"加餐"]) {
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime3"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }

                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    [repDic setObject:@"4" forKey:@"foodTYpe"];

                    
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                [zaoArr  addObject:repDic];
                [_infoDic setValue:zaoArr  forKey:@"foodTime3"];
                

            }

            if (_indexRow < zaoArray.count) {
                
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime0"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }
                [zaoArr  removeObjectAtIndex:_indexRow];
                [_infoDic setValue:zaoArr  forKey:@"foodTime0"];

                
            }else if (_indexRow < zaoArray.count+zhongArray.count) {
                
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime1"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }
                [zaoArr removeObjectAtIndex:_indexRow-zaoArray.count];
                [_infoDic setValue:zaoArr  forKey:@"foodTime1"];
                
            }else if (_indexRow < zaoArray.count+zhongArray.count+wanArray.count) {
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime2"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }
                [zaoArr  removeObjectAtIndex:_indexRow-zaoArray.count-zhongArray.count];
                [_infoDic setValue:zaoArr  forKey:@"foodTime2"];

                
            }else if (_indexRow < zaoArray.count+zhongArray.count+wanArray.count+jiaArray.count) {
                
                NSMutableArray *zaoArr = [NSMutableArray array];
                NSArray *zaomArr = [_infoDic objectForKey:@"foodTime3"];
                if (zaomArr.count > 0) {
                    zaoArr = [zaomArr mutableCopy];
                }
                [zaoArr  removeObjectAtIndex:_indexRow-zaoArray.count-zhongArray.count-wanArray.count];
                [_infoDic setValue:zaoArr  forKey:@"foodTime3"];
            }

            
        }
       
        [changArray replaceObjectAtIndex:_indexSection withObject:_infoDic];

        
    }else{
    //日期不同:日期存在（添加进日餐）、日期不存在（添加一个日期）
        NSInteger sameNum = -1;
        for (int i = 0; i < changArray.count; i++) {
            NSString *timeStr = [[changArray objectAtIndex:i] objectForKey:@"addTime"];
            if ([dateTF.text isEqualToString:timeStr]) {
                sameNum = i;
            }
        }
        if (sameNum > 0) {
            
            
            NSMutableDictionary *repDic = [[dArray objectAtIndex:_indexRow] mutableCopy];
            
            if ([typeTF.text isEqualToString:@"早餐"]) {
                
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"1"] forKey:@"foodTYpe"];
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                
                NSMutableDictionary *chDic = [[changArray objectAtIndex:sameNum] mutableCopy];
                NSArray *chA = [chDic objectForKey:@"foodTime0"];
                NSMutableArray *chmA = [NSMutableArray array];
                if (chA.count > 0) {
                    chmA = [chA mutableCopy];
                }
                [chmA addObject:repDic];
                [chDic setObject:chmA forKey:@"foodTime0"];
                [changArray replaceObjectAtIndex:sameNum withObject:chDic];
            }else if ([typeTF.text isEqualToString:@"中餐"]) {
                
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"1"] forKey:@"foodTYpe"];
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                
                NSMutableDictionary *chDic = [[changArray objectAtIndex:sameNum] mutableCopy];
                NSArray *chA = [chDic objectForKey:@"foodTime1"];
                NSMutableArray *chmA = [NSMutableArray array];
                if (chA.count > 0) {
                    chmA = [chA mutableCopy];
                }
                [chmA addObject:repDic];
                [chDic setObject:chmA forKey:@"foodTime1"];
                [changArray replaceObjectAtIndex:sameNum withObject:chDic];
                
                
            }else if ([typeTF.text isEqualToString:@"晚餐"]) {
                
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"1"] forKey:@"foodTYpe"];
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                
                NSMutableDictionary *chDic = [[changArray objectAtIndex:sameNum] mutableCopy];
                NSArray *chA = [chDic objectForKey:@"foodTime2"];
                NSMutableArray *chmA = [NSMutableArray array];
                if (chA.count > 0) {
                    chmA = [chA mutableCopy];
                }
                [chmA addObject:repDic];
                [chDic setObject:chmA forKey:@"foodTime2"];
                [changArray replaceObjectAtIndex:sameNum withObject:chDic];
                
            }else    if ([typeTF.text isEqualToString:@"加餐"]) {
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"1"] forKey:@"foodTYpe"];
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                
                NSMutableDictionary *chDic = [[changArray objectAtIndex:sameNum] mutableCopy];
                NSArray *chA = [chDic objectForKey:@"foodTime3"];
                NSMutableArray *chmA = [NSMutableArray array];
                if (chA.count > 0) {
                    chmA = [chA mutableCopy];
                }
                [chmA addObject:repDic];
                [chDic setObject:chmA forKey:@"foodTime3"];
                [changArray replaceObjectAtIndex:sameNum withObject:chDic];
                
            }

        }else{
            //日期不存在（添加一个日期）
            NSMutableDictionary *repDic = [[dArray objectAtIndex:_indexRow] mutableCopy];
            
            if ([typeTF.text isEqualToString:@"早餐"]) {
                
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"1"] forKey:@"foodTYpe"];
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                
                NSMutableDictionary *chDic = [NSMutableDictionary dictionary];
                NSArray *chA = @[repDic];
                [chDic setObject:chA forKey:@"foodTime0"];
                [chDic setObject:dateTF.text forKey:@"addTime"];
                [chDic setObject:@"3" forKey:@"code"];
                [chDic setObject:[_infoDic objectForKey:@"tableName"] forKey:@"tableName"];
                [changArray addObject:chDic];
            }else if ([typeTF.text isEqualToString:@"中餐"]) {
                
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"1"] forKey:@"foodTYpe"];
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                
                NSMutableDictionary *chDic = [NSMutableDictionary dictionary];
                NSArray *chA = @[repDic];
                [chDic setObject:chA forKey:@"foodTime1"];
                [chDic setObject:dateTF.text forKey:@"addTime"];
                [chDic setObject:@"3" forKey:@"code"];
                [chDic setObject:[_infoDic objectForKey:@"tableName"] forKey:@"tableName"];
                [changArray addObject:chDic];
                
                
            }else if ([typeTF.text isEqualToString:@"晚餐"]) {
                
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"1"] forKey:@"foodTYpe"];
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                
                NSMutableDictionary *chDic = [NSMutableDictionary dictionary];
                NSArray *chA = @[repDic];
                [chDic setObject:chA forKey:@"foodTime2"];
                [chDic setObject:dateTF.text forKey:@"addTime"];
                [chDic setObject:@"3" forKey:@"code"];
                [chDic setObject:[_infoDic objectForKey:@"tableName"] forKey:@"tableName"];
                [changArray addObject:chDic];
                
            }else    if ([typeTF.text isEqualToString:@"加餐"]) {
                if (replaceDic.allKeys.count > 0) {
                    [repDic setValue:[replaceDic objectForKey:@"caption"] forKey:@"caption"];
                    [repDic setValue:[replaceDic objectForKey:@"code"] forKey:@"code"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"fieldName"] forKey:@"fieldName"];
                    [repDic setValue:[replaceDic objectForKey:@"remark"] forKey:@"remark"];
                    
                    [repDic setValue:[replaceDic objectForKey:@"1"] forKey:@"foodTYpe"];
                }
                [repDic setValue:wghTF.text forKey:@"defaultValue"];
                
                NSMutableDictionary *chDic = [NSMutableDictionary dictionary];
                NSArray *chA = @[repDic];
                [chDic setObject:chA forKey:@"foodTime3"];
                [chDic setObject:dateTF.text forKey:@"addTime"];
                [chDic setObject:@"3" forKey:@"code"];
                [chDic setObject:[_infoDic objectForKey:@"tableName"] forKey:@"tableName"];
                [changArray addObject:chDic];
                
            }

        }
        
        
        if (_indexRow < zaoArray.count) {
            
            NSMutableArray *zaoArr = [NSMutableArray array];
            NSArray *zaomArr = [_infoDic objectForKey:@"foodTime0"];
            if (zaomArr.count > 0) {
                zaoArr = [zaomArr mutableCopy];
            }
            [zaoArr  removeObjectAtIndex:_indexRow];
            [_infoDic setValue:zaoArr  forKey:@"foodTime0"];
            
            
        }else if (_indexRow < zaoArray.count+zhongArray.count) {
            
            NSMutableArray *zaoArr = [NSMutableArray array];
            NSArray *zaomArr = [_infoDic objectForKey:@"foodTime1"];
            if (zaomArr.count > 0) {
                zaoArr = [zaomArr mutableCopy];
            }
            [zaoArr removeObjectAtIndex:_indexRow-zaoArray.count];
            [_infoDic setValue:zaoArr  forKey:@"foodTime1"];
            
        }else if (_indexRow < zaoArray.count+zhongArray.count+wanArray.count) {
            NSMutableArray *zaoArr = [NSMutableArray array];
            NSArray *zaomArr = [_infoDic objectForKey:@"foodTime2"];
            if (zaomArr.count > 0) {
                zaoArr = [zaomArr mutableCopy];
            }
            [zaoArr  removeObjectAtIndex:_indexRow-zaoArray.count-zhongArray.count];
            [_infoDic setValue:zaoArr  forKey:@"foodTime2"];
            
            
        }else if (_indexRow < zaoArray.count+zhongArray.count+wanArray.count+jiaArray.count) {
            
            NSMutableArray *zaoArr = [NSMutableArray array];
            NSArray *zaomArr = [_infoDic objectForKey:@"foodTime3"];
            if (zaomArr.count > 0) {
                zaoArr = [zaomArr mutableCopy];
            }
            [zaoArr  removeObjectAtIndex:_indexRow-zaoArray.count-zhongArray.count-wanArray.count];
            [_infoDic setValue:zaoArr  forKey:@"foodTime3"];
        }
        [changArray replaceObjectAtIndex:_indexSection withObject:_infoDic];


        
    }
    
    NSUserDefaults *defaultS =  [NSUserDefaults standardUserDefaults];
    [defaultS setObject:changArray forKey:@"user_shanshiSDic"];
    [defaultS synchronize];

    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return questionSArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
            static NSString *cellIndefier = @"cell";
        RegistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        
        if (!cell) {
            
            cell = [[NSBundle mainBundle] loadNibNamed:@"RegistTableViewCell" owner:self options:nil].lastObject;
        }
        
        cell.nameLab.text = questionSArray[indexPath.row];
        cell.wTF.delegate = self;
        cell.wTF.tag = 1000 + indexPath.row;
    
    NSDictionary *dic = _infoDic;
    NSMutableArray *dArray = [NSMutableArray array];
    
    NSArray *zaoArray = [dic objectForKey:@"foodTime0"];
    for (NSDictionary *dic in zaoArray) {
        [dArray addObject:dic];
    }
    NSArray *zhongArray = [dic objectForKey:@"foodTime1"];
    for (NSDictionary *dic in zhongArray) {
        [dArray addObject:dic];
    }
    NSArray *wanArray = [dic objectForKey:@"foodTime2"];
    for (NSDictionary *dic in wanArray) {
        [dArray addObject:dic];
    }
    NSArray *jiaArray = [dic objectForKey:@"foodTime3"];
    for (NSDictionary *dic in jiaArray) {
        [dArray addObject:dic];
    }
    

    switch (indexPath.row) {
        case 0:
           
            cell.wTF.text = [[dArray objectAtIndex:_indexRow] objectForKey:@"addTime"];
            break;
        case 1:{
        
            NSInteger dinType = [[[dArray objectAtIndex:_indexRow] objectForKey:@"foodTYpe"] integerValue];
            // 1早餐 2中 3晚 4加餐 5 修改
            switch (dinType) {
                case 1:
                {
                    cell.wTF.text = @"早餐";
                }
                    break;
                case 2:
                {
                    cell.wTF.text = @"中餐";
                }
                    break;
                case 3:
                {
                    cell.wTF.text = @"晚餐";
                }
                    break;
                case 4:
                {
                    cell.wTF.text = @"加餐";
                }
                    break;
                default:
                    break;
            }
}
            
            break;
        case 2:
            
            cell.wTF.text = [[dArray objectAtIndex:_indexRow] objectForKey:@"caption"];
            break;
        case 3:
            
            cell.wTF.text = [[dArray objectAtIndex:_indexRow] objectForKey:@"defaultValue"];
            break;

        default:
            break;
    }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}


#pragma mark -------------------textField delegat-------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 1000) {
        j_actionV.hidden = YES;
        
        [self seleTime];
        
    }else if (textField.tag == 1001){
        m_actionV.hidden = YES;
        [self seleJob];
        
    }else if (textField.tag == 1002){
        
        FoodViewController *foodVc = [[FoodViewController alloc] init];
        foodVc.comeType = 5;
        foodVc.block = ^(NSDictionary *dic){
            UITextField *textF = [self.view viewWithTag:1002];
            textF.text = [dic objectForKey:@"caption"];
            replaceDic = dic;
        };
        [self.navigationController pushViewController:foodVc animated:YES];
        
    }else if (textField.tag == 1003){
        MKPAlertView *alertView = [[MKPAlertView alloc]initWithTitle:@"重量" type:2 sureBtn:@"确认" cancleBtn:@"取消"];
        alertView.resultIndex = ^(NSString * str)
        {
            // 回调 -- 处理
            NSLog(@"%@",str);
            if ([str isEqualToString:@"cancle"]) {
                return ;
            }
            
            UITextField *textF = [self.view viewWithTag:1003];
            textF.text = str;
            
        };
        [alertView showMKPAlertView];

        
        
    }


    return NO;
}

#pragma mark -------------------选择时间-------------------

- (void)seleTime {
    if (m_actionV == nil) {
        
        m_actionV = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-260,kScreenWidth, 260)];
        UIToolbar   *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        
        [pickerDateToolbar setBackgroundImage:[self createImageWithColor:BaseColor] forToolbarPosition:0 barMetrics:0];
        pickerDateToolbar.tintColor = BaseColor;
        [pickerDateToolbar sizeToFit];
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        //
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(toolBarCanelClick)];
        
        [cancelBtn setTintColor:[UIColor whiteColor]];
        [barItems addObject:cancelBtn];
        //
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        //
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(toolBarDoneClick)];
        
        [doneBtn setTintColor:[UIColor whiteColor]];
        [barItems addObject:doneBtn];
        
        [pickerDateToolbar setItems:barItems animated:YES];
        [m_actionV addSubview:pickerDateToolbar];
        
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
        
        [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        // 设置时区
        [datePicker setTimeZone:[NSTimeZone localTimeZone]];
        
        // 设置当前显示时间
        [datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最大时间（此处为当前时间）
        [datePicker setMaximumDate:[NSDate date]];
        // 设置UIDatePicker的显示模式
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        // 当值发生改变的时候调用的方法
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [m_actionV addSubview:datePicker];
        
        [self.view addSubview:m_actionV];
    }
    
    m_actionV.hidden = NO;
    
    
}
-(void)toolBarCanelClick{
    
    m_actionV.hidden = YES;
    
}
-(void)toolBarDoneClick{
    
    m_actionV.hidden = YES;
    
    NSDate *theDate = datePicker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd ";
    
    
    UITextField *textF = [self.view viewWithTag:1000];
    textF.text = [dateFormatter stringFromDate:theDate];
    
    dateStr = [dateFormatter stringFromDate:theDate];
    
    
}

- (void)datePickerValueChanged:(UIDatePicker *)datePickers {
    NSDate *theDate = datePickers.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd ";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
//    UITextField *textF = [self.view viewWithTag:1000];
//    textF.text = [dateFormatter stringFromDate:theDate];
    dateStr = [dateFormatter stringFromDate:theDate];
}

#pragma mark -------------------选择职业-------------------
- (void)seleJob {
    if (j_actionV == nil) {
        
        j_actionV = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-260,kScreenWidth, 260)];
        UIToolbar   *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        
        [pickerDateToolbar setBackgroundImage:[self createImageWithColor:BaseColor] forToolbarPosition:0 barMetrics:0];
        pickerDateToolbar.tintColor = BaseColor;
        [pickerDateToolbar sizeToFit];
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        //
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(toolBaCanelClick)];
        
        [cancelBtn setTintColor:[UIColor whiteColor]];
        [barItems addObject:cancelBtn];
        //
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        //
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(toolBaDoneClick)];
        
        [doneBtn setTintColor:[UIColor whiteColor]];
        [barItems addObject:doneBtn];
        
        [pickerDateToolbar setItems:barItems animated:YES];
        [j_actionV addSubview:pickerDateToolbar];
        
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
        pickerView.showsSelectionIndicator = YES;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.backgroundColor = [UIColor whiteColor];
        
        [pickerView selectRow:0 inComponent:0 animated:YES];
        
        [j_actionV addSubview:pickerView];
        
        [self.view addSubview:j_actionV];
    }
    
    j_actionV.hidden = NO;
    
}

-(void)toolBaCanelClick{
    
    j_actionV.hidden = YES;
    
}
-(void)toolBaDoneClick{
    
    
    UITextField *textF = [self.view viewWithTag:1001];
    textF.text = jobStr;
    
    j_actionV.hidden = YES;
//    jobStr  = @"";
    
    
}

//组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return dinArray.count;
}

//初始化每个组件每一行数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *captionS = dinArray[row];
    return captionS;
}

//选中picker cell,save ArrayIndex
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    jobSel =  row;
    
    NSString *captionS = dinArray[row];
    
//    UITextField *textF = [self.view viewWithTag:1001];
//    textF.text = captionS;
    jobStr  = captionS;
}

//替换text居中
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
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
