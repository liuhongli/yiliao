//
//  FoodViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/12/12.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "FoodViewController.h"
#import "VCTableViewCell.h"
#import "MKPAlertView.h"



@interface FoodViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *dataArray;
    
    NSInteger leftSelected;
    
    NSInteger rightSelected;
    
}

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) UITableView *rightTableView;


@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"膳食调查";
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] isKindOfClass:[NSDictionary class]]) {
        [Alert showWithTitle:@"尚未获取数据，请稍后重试..."];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    NSArray *result = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] objectForKey:@"result"];
    leftSelected = 0;
    dataArray = [NSMutableArray array];
    for (NSDictionary *dic in result) {
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"StapleFoodInspectionO"]) {
            [dataArray addObject:dic];
        }
        
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"BeanFoodInspectionO"]) {
            [dataArray addObject:dic];
        }
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"VegetableFoodInspectionO"]) {
            [dataArray addObject:dic];
        }
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"LivestockFoodInspectionO"]) {
            [dataArray addObject:dic];
        }
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"SeaFoodInspectionO"]) {
            [dataArray addObject:dic];
        }
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"FruitInspectionO"]) {
            [dataArray addObject:dic];
        }
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"EggMilkInspectionO"]) {
            [dataArray addObject:dic];
        }
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"DrinkOilFoodInspectionO"]) {
            [dataArray addObject:dic];
        }
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"NutInspectionO"]) {
            [dataArray addObject:dic];
        }
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"NurtureInspectionO"]) {
            [dataArray addObject:dic];
        }

    }
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == self.leftTableView)
    {
        return 1;
    }else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _leftTableView)
    {
        return dataArray.count;
    }else
    {
        
        NSArray *childArr = [dataArray[leftSelected] objectForKey:@"children"];
        return childArr.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == _leftTableView)
    {
        NSDictionary *dic = dataArray[indexPath.row];
        NSString *Remark = [dic objectForKey:@"name"];
        CGSize sizeH = [self countHeight:Remark font:FontApp  witd:80];
        NSLog(@"%@==%f",Remark,sizeH.height);
        return  sizeH.height + 20;
    }else
    {
        return 50;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(tableView == self.leftTableView)
    {
        UITableViewCell *cell;
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"leftTableView" forIndexPath:indexPath];
        NSDictionary *dic = dataArray[indexPath.row];
        NSString *Remark = [dic objectForKey:@"name"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",Remark];
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"4A4A4A" alpha:1];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        UIView *sepV = [[UIView alloc]initWithFrame:CGRectMake(cell.width-0.5, 0, 0.5, cell.height)];
        sepV.backgroundColor = [UIColor grayColor];
        sepV.alpha = 0.6;
        [cell.contentView addSubview:sepV];

        if (leftSelected == indexPath.row ) {
           
            cell.backgroundColor = [UIColor colorWithHexString:@"FF8698" alpha:1];
      
        }else{
          
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"FF8698" alpha:1];

        return cell;
        
    }else
    {
        VCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VCTableViewCell" forIndexPath:indexPath];
        
        NSDictionary *dic = dataArray[leftSelected];
        NSArray *childArr = [dic objectForKey:@"children"];
        NSDictionary *childDic = childArr[indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",[childDic objectForKey:@"caption"]];
        cell.titleLabel.numberOfLines = 0;
        cell.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];

        cell.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.tintColor = [UIColor colorWithHexString:@"FF8698" alpha:1];
        cell.titleLabel.textColor = [UIColor colorWithHexString:@"4A4A4A" alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        

        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.leftTableView)
    {
        leftSelected = indexPath.row;
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        NSIndexPath *ToIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.rightTableView selectRowAtIndexPath:ToIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
    }else{
        
        
        UITableViewCell*newCell = [tableView cellForRowAtIndexPath:indexPath];
        
        
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        if (indexPath.row != rightSelected) {
            NSIndexPath*oldIndexPath =[NSIndexPath indexPathForRow:rightSelected inSection:0];
            UITableViewCell*oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
            
            
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            
            
        }

        rightSelected =indexPath.row;

        NSDictionary *dic = dataArray[leftSelected];
        NSArray *childArr = [dic objectForKey:@"children"];
        NSDictionary *childDic = childArr[indexPath.row];
        
        if (_comeType == 5) {
            if (_block) {
                self.block(childDic);
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
        }
         MKPAlertView *alertView = [[MKPAlertView alloc]initWithTitle:[childDic objectForKey:@"caption"] type:2 sureBtn:@"确认" cancleBtn:@"取消"];
        alertView.resultIndex = ^(NSString * str) {
            // 回调 -- 处理
            NSLog(@"%@",str);
            if ([str isEqualToString:@"cancle"]) {
                return ;
            }

            NSIndexPath*oldIndexPath =[NSIndexPath indexPathForRow:rightSelected inSection:0];
            UITableViewCell*oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];

            oldCell.accessoryType=UITableViewCellAccessoryNone;
            NSDictionary *dic = dataArray[leftSelected];
            NSArray *childArr = [dic objectForKey:@"children"];
            NSDictionary *childDic = childArr[rightSelected];
            NSMutableDictionary *codeDic = [[NSMutableDictionary alloc] initWithDictionary:childDic];
            
            NSDate *theDate = [NSDate date];
            NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat =@"YYYY-MM-dd";
 
            [codeDic setObject:[dateFormatter stringFromDate:theDate] forKey:@"addTime"];
            [codeDic setObject:[dic objectForKey:@"tableName"] forKey:@"tableName"];
            [codeDic setObject:[NSString stringWithFormat:@"%ld",_comeType] forKey:@"foodTYpe"];
            [codeDic setObject:str forKey:@"defaultValue"];
            [self saveInfo:codeDic];
            [self.navigationController popViewControllerAnimated:YES];
        
        };
        [alertView showMKPAlertView];

    }
}

- (void)saveInfo:(NSDictionary *)myDic {
  
    NSMutableArray *changArray = [NSMutableArray  array];
        
      NSMutableArray *cArray = [shanshiSDic mutableCopy];
        if (cArray.count > 0) {
            changArray = cArray;
        }
        //日期不同:日期存在（添加进日餐）、日期不存在（添加一个日期）
        NSInteger sameNum = -1;
    NSDate *theDate = [NSDate date];
    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"YYYY-MM-dd";
    
        for (int i = 0; i < changArray.count; i++) {
            NSString *timeStr = [[changArray objectAtIndex:i] objectForKey:@"addTime"];
            if ([[dateFormatter stringFromDate:theDate] isEqualToString:timeStr]) {
                sameNum = i;
            }
        }
        if (sameNum > -1) {
            
            

            
            if (_comeType == 1) {
                
                
                NSMutableDictionary *chDic = [[changArray objectAtIndex:sameNum] mutableCopy];
                NSArray *chA = [chDic objectForKey:@"foodTime0"];
                NSMutableArray *chmA = [NSMutableArray array];
                if (chA.count > 0) {
                    chmA = [chA mutableCopy];
                }
                [chmA addObject:myDic];
                [chDic setObject:chmA forKey:@"foodTime0"];
                [changArray replaceObjectAtIndex:sameNum withObject:chDic];
            }else if (_comeType == 2) {
                
                NSMutableDictionary *chDic = [[changArray objectAtIndex:sameNum] mutableCopy];
                NSArray *chA = [chDic objectForKey:@"foodTime1"];
                NSMutableArray *chmA = [NSMutableArray array];
                if (chA.count > 0) {
                    chmA = [chA mutableCopy];
                }
                [chmA addObject:myDic];
                [chDic setObject:chmA forKey:@"foodTime1"];
                [changArray replaceObjectAtIndex:sameNum withObject:chDic];
                
                
            }else if (_comeType == 3) {
                
                
                NSMutableDictionary *chDic = [[changArray objectAtIndex:sameNum] mutableCopy];
                NSArray *chA = [chDic objectForKey:@"foodTime2"];
                NSMutableArray *chmA = [NSMutableArray array];
                if (chA.count > 0) {
                    chmA = [chA mutableCopy];
                }
                [chmA addObject:myDic];
                [chDic setObject:chmA forKey:@"foodTime2"];
                [changArray replaceObjectAtIndex:sameNum withObject:chDic];
                
            }else    if (_comeType == 4) {

                NSMutableDictionary *chDic = [[changArray objectAtIndex:sameNum] mutableCopy];
                NSArray *chA = [chDic objectForKey:@"foodTime3"];
                NSMutableArray *chmA = [NSMutableArray array];
                if (chA.count > 0) {
                    chmA = [chA mutableCopy];
                }
                [chmA addObject:myDic];
                [chDic setObject:chmA forKey:@"foodTime3"];
                [changArray replaceObjectAtIndex:sameNum withObject:chDic];
                
            }
            
        }else{
            //日期不存在（添加一个日期）
            if (_comeType == 1) {
                
                NSMutableDictionary *chDic = [NSMutableDictionary dictionary];
                NSArray *chA = @[myDic];
                [chDic setObject:chA forKey:@"foodTime0"];
                [chDic setObject:[dateFormatter stringFromDate:theDate] forKey:@"addTime"];
                [chDic setObject:@"3" forKey:@"code"];
                [chDic setObject:[myDic objectForKey:@"tableName"] forKey:@"tableName"];
                [changArray addObject:chDic];
            }else if (_comeType == 2) {
                
                NSMutableDictionary *chDic = [NSMutableDictionary dictionary];
                NSArray *chA = @[myDic];
                [chDic setObject:chA forKey:@"foodTime1"];
                [chDic setObject:[dateFormatter stringFromDate:theDate] forKey:@"addTime"];
                [chDic setObject:@"3" forKey:@"code"];
                [chDic setObject:[myDic objectForKey:@"tableName"] forKey:@"tableName"];
                [changArray addObject:chDic];
                
                
            }else if (_comeType == 3) {
                
                NSMutableDictionary *chDic = [NSMutableDictionary dictionary];
                NSArray *chA = @[myDic];
                [chDic setObject:chA forKey:@"foodTime2"];
                [chDic setObject:[dateFormatter stringFromDate:theDate] forKey:@"addTime"];
                [chDic setObject:@"3" forKey:@"code"];
                [chDic setObject:[myDic objectForKey:@"tableName"] forKey:@"tableName"];
                [changArray addObject:chDic];
                
            }else    if (_comeType == 4) {
                NSMutableDictionary *chDic = [NSMutableDictionary dictionary];
                NSArray *chA = @[myDic];
                [chDic setObject:chA forKey:@"foodTime3"];
                [chDic setObject:[dateFormatter stringFromDate:theDate] forKey:@"addTime"];
                [chDic setObject:@"3" forKey:@"code"];
                [chDic setObject:[myDic objectForKey:@"tableName"] forKey:@"tableName"];
                [changArray addObject:chDic];
                
            }
            
        }
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"addTime" ascending:NO]];
    [changArray sortUsingDescriptors:sortDescriptors];
    NSUserDefaults *defaultS =  [NSUserDefaults standardUserDefaults];
    [defaultS setObject:changArray forKey:@"user_shanshiSDic"];
    [defaultS synchronize];
    
    
}

- (UITableView *)leftTableView
{
    if(_leftTableView == nil)
    {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*0.3, kScreenHeight) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftTableView"];
        _leftTableView.tableFooterView = [[UIView alloc]init];
        
    }
    return _leftTableView;
}
- (UITableView *)rightTableView
{
    if(_rightTableView == nil)
    {
        
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth*0.3, 0, kScreenWidth*0.7, kScreenHeight) style:UITableViewStylePlain];
        _rightTableView.delegate= self;
        _rightTableView.dataSource = self;
        
        
        [_rightTableView registerClass:[VCTableViewCell class] forCellReuseIdentifier:@"VCTableViewCell"];
        _rightTableView.tableFooterView = [[UIView alloc]init];
    }
    return _rightTableView;
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
