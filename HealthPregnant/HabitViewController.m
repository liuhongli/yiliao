//
//  HabitViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/12.
//  Copyright (c) 2016年 honely. All rights reserved.
//

#import "HabitViewController.h"
#import <objc/runtime.h>

@interface HabitViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *dataArray;
}

@property (nonatomic,strong) NSMutableArray *interestArray;/*存放选中的按钮*/
@property (retain, nonatomic)UITableView *myTabV;

@end

@implementation HabitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.interestArray = [NSMutableArray new];
    dataArray = [NSMutableArray array];
    UIView *rightview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savebtn.frame = CGRectMake(40, 0, 40, 40);
    [savebtn setTitle:@"重置" forState:UIControlStateNormal];
    [savebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [savebtn addTarget:self action:@selector(reSave) forControlEvents:UIControlEventTouchUpInside];
    [rightview addSubview:savebtn];
    
    UIBarButtonItem *buttonItem  = [[UIBarButtonItem alloc] initWithCustomView:rightview];
    self.navigationItem.rightBarButtonItem  = buttonItem;

    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    
    if (_comeType == 1) {
        NSArray *arr = [defaut objectForKey:@"user_zhusuSDic"];
        if (arr.count > 0) {
            dataArray = [arr mutableCopy];
        }
        
    }else if (_comeType == 2) {
        
        NSArray *arr = [defaut objectForKey:@"user_yingshiSDic"];
        if (arr.count > 0) {
            dataArray = [arr mutableCopy];
        }

        
    }if (_comeType == 3) {
        
        NSArray *arr = [defaut objectForKey:@"user_shenghuoSDic"];
        if (arr.count > 0) {
            dataArray = [arr mutableCopy];
        }

    }
    if (dataArray.count <  1) {
      
        [self initData];
    }

    [self initTableView];
    [self initFootView];
}

- (void)reSave{
    [self initData];
    [_myTabV reloadData];
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    
    if (_comeType == 1) {
        
        [defaut setObject:dataArray forKey:@"user_zhusuSDic"];
        
    }else if (_comeType == 2) {
        
        [defaut setObject:dataArray forKey:@"user_yingshiSDic"];
        
    }if (_comeType == 3) {
        
        [defaut setObject:dataArray forKey:@"user_shenghuoSDic"];
        
    }
    
    [defaut synchronize];

    
}
- (void)initData{
    [dataArray removeAllObjects];
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] isKindOfClass:[NSDictionary class]]) {
        [Alert showWithTitle:@"尚未获取数据，请稍后重试..."];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    NSArray *result = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] objectForKey:@"result"];
    switch (_comeType) {
        case 1:
            [self dataZhu:result];
            break;
            
        case 2:
            [self dataYin:result];
            break;
            
        case 3:
            [self dataShen:result];
            break;
            
        default:
            break;
    }

}
- (void)dataZhu:(NSArray *)result{
    
    for (NSDictionary *dic in result) {
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"StatementSymptomRecord"]) {
            [dataArray addObject:dic];
        }
    }
    
    
}


- (void)dataYin:(NSArray *)result{
    
    for (NSDictionary *dic in result) {
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"DietHabitInspection"]) {
            [dataArray addObject:dic];
        }
    }

}
- (void)dataShen:(NSArray *)result{
    
    for (NSDictionary *dic in result) {
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"LifeHabbitInspection"]) {
            
            NSMutableDictionary *mdic1 =  [dic mutableCopy];
            NSArray *children = [mdic1 objectForKey:@"children"];
            NSMutableArray *m1 = [NSMutableArray array];
            for (int i = 0; i < children.count ;i++) {
                NSMutableDictionary *dic = [[children objectAtIndex:i] mutableCopy];
                [dic setObject:@"0" forKey:@"defaultValue"];
                [m1 addObject:dic];
            }
            [mdic1 setObject:m1 forKey:@"children"];

            [dataArray addObject:mdic1];
        }
    }
    


    
}

- (void)initFootView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UIButton *buton  = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 40)];
    [buton setTitle:@"保存" forState:UIControlStateNormal];
    [buton addTarget:self action:@selector(postInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    [buton setBackgroundColor:[UIColor colorWithHexString:@"FF8698" alpha:1]];

    [view addSubview:buton];
     _myTabV.tableFooterView = view;

}
#pragma mark ------------------ 提交信息 -------------------------


- (void)postInfo:(UIButton *)button {
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    
    if (_comeType == 1) {
        
        [defaut setObject:dataArray forKey:@"user_zhusuSDic"];
        
    }else if (_comeType == 2) {
        
        [defaut setObject:dataArray forKey:@"user_yingshiSDic"];
        
    }if (_comeType == 3) {
        
        [defaut setObject:dataArray forKey:@"user_shenghuoSDic"];
        
    }
    
    [defaut synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark ------------------tab V -------------------------


- (void)initTableView {
    _myTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _myTabV.backgroundColor = tabBackColor;
    _myTabV.delegate = self;
    _myTabV.dataSource = self;
    [self.view addSubview:_myTabV];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
      static  NSString *cellIndetifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifer];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifer];
        }
        NSDictionary *dic = dataArray[indexPath.section];
        cell.textLabel.text = [dic objectForKey:@"name"];
        cell.textLabel.font = [UIFont systemFontOfSize:FontApp];
        cell.textLabel.textColor =  [UIColor colorWithHexString:@"4A4A4A"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }else{
      
        static  NSString *cellIndetifer = @"cell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifer];
    
    if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifer];
        }
        for (UIView *view in cell.contentView.subviews) {

            
            [view removeFromSuperview];
            
        }
        
        NSDictionary *dic = dataArray[indexPath.section];
        NSArray *childArr = [dic objectForKey:@"children"];

        [self initTagView:cell.contentView indexPath:indexPath array:childArr];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        return cell;}
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40;
    }
    NSDictionary *dic = dataArray[indexPath.section];
    NSArray *childArr = [dic objectForKey:@"children"];

    CGFloat tagHeight = [self height:childArr width:(kScreenWidth - 40)]+35;
    
    NSLog(@"height = %f  section = %ld  row = %ld",tagHeight,indexPath.section,indexPath.row);
    return tagHeight;
}


#pragma mark ------------------tab 1 -------------------------


- (void)initTagView:(UIView *)view indexPath:(NSIndexPath*)indexPath array:(NSArray*)array{
    
    //第一个 label的起点
    CGSize size;
    
        size = CGSizeMake(15, 8);
        
       //间距
    CGFloat padding = 20.0;
    
    CGFloat width = kScreenWidth - 40;
    
    
    for (int i = 0; i < array.count; i ++) {
        NSString *caption = [array[i] objectForKey:@"caption"];
        NSUInteger deftV = [[array[i] objectForKey:@"defaultValue"] integerValue];
        CGFloat keyWorldWidth = [self getSizeByString:caption AndFontSize:FontApp].width+20;
        if (keyWorldWidth > width) {
            keyWorldWidth = width;
        }
        if (width - size.width < keyWorldWidth) {
            size.height += 35.0;
            size.width = 15.0;
        }
        //创建 label点击事件
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(size.width, size.height, keyWorldWidth, 35)];
        
        objc_setAssociatedObject(button, "firstObject", indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        NSString *index = [NSString stringWithFormat:@"%d",i];
        objc_setAssociatedObject(button, "secondObject", index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //起点 增加
        size.width += keyWorldWidth+padding;
        
        
        if (_mutilSetlecd == 1) {
            
            [button addTarget:self action:@selector(tagButtonSingleClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            
            [button addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        }

        

        [view addSubview:button];
        
        
        
        UIButton *seledButton = [[UIButton alloc] initWithFrame:CGRectMake(2, 8, 15, 15)];
        seledButton.tag =  indexPath.section * 10000 + i+10;
        if (_mutilSetlecd == 1) {
            
            [seledButton setBackgroundImage:[UIImage imageNamed:@"单选勾选框_ct"] forState:UIControlStateNormal];
            [seledButton setBackgroundImage:[UIImage imageNamed:@"单选勾选框_dj"] forState:    UIControlStateSelected];
        }else{
            
        [seledButton setBackgroundImage:[UIImage imageNamed:@"多选勾选框_ct"] forState:UIControlStateNormal];
            [seledButton setBackgroundImage:[UIImage imageNamed:@"多选勾选框_dj"] forState:    UIControlStateSelected];
        }
        
        if (deftV == 1) {
            if (_mutilSetlecd == 1) {
                
                [seledButton setBackgroundImage:[UIImage imageNamed:@"单选勾选框_dj"] forState:UIControlStateNormal];
                
            }else{
                
                [seledButton setBackgroundImage:[UIImage imageNamed:@"多选勾选框_dj"] forState:UIControlStateNormal];

            }
            
        }
        seledButton.userInteractionEnabled = NO;

        [button addSubview:seledButton];
        
        UILabel *Tlab = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, button.width-20, 30)];
        Tlab.text = caption;
        Tlab.textColor = [UIColor colorWithHexString:@"4A4A4A"];
        Tlab.font = [UIFont systemFontOfSize:FontApp];
        [button addSubview:Tlab];
        
        [view addSubview:button];

    }
    
}

//计算文字所占大小
- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(kScreenWidth-30,25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    size.width = size.width ;
    return size;
}

- (CGFloat)height:(NSArray *)array width:(CGFloat )viewWith {
    //第一个 label的起点
    CGSize size = CGSizeMake(15, 8);
    
    //间距
    CGFloat padding = 20.0;
    
    CGFloat width = viewWith;
    
    
    for (int i = 0; i < array.count; i ++) {
        NSString *caption = [array[i] objectForKey:@"caption"];

        CGFloat keyWorldWidth = [self getSizeByString:caption AndFontSize:FontApp].width+20;
        if (keyWorldWidth > width) {
            keyWorldWidth = width;
        }
        if (width - size.width < keyWorldWidth) {
            size.height += 35.0;
            size.width = 15.0;
        }
        
        //起点 增加
        size.width += keyWorldWidth+padding;
        
        
    }
    return size.height;
}


#pragma mark ------------------ 多选 -------------------------

- (void)tagButtonClick:(UIButton *)button {
    
    
    NSIndexPath *indexPath =  objc_getAssociatedObject(button, "firstObject");
    NSInteger index =  [objc_getAssociatedObject(button, "secondObject") integerValue];

    
    NSMutableDictionary *chageDic =  [[NSMutableDictionary alloc]initWithDictionary:dataArray[indexPath.section]];
    
    NSMutableArray *children =[NSMutableArray arrayWithArray:[chageDic objectForKey:@"children"]];
    NSMutableDictionary *subDic = [[NSMutableDictionary alloc]initWithDictionary:[children objectAtIndex:index]];
    NSUInteger deftV = [[subDic objectForKey:@"defaultValue"] integerValue];
    
    UIButton *butt = [self.view viewWithTag: indexPath.section* 10000 +index+10];
    if (deftV == 1) {
      
        [subDic setObject:@"0" forKey:@"defaultValue"];
        [butt setBackgroundImage:[UIImage imageNamed:@"多选勾选框_ct"] forState:UIControlStateNormal];
    }else{
        
        [butt setBackgroundImage:[UIImage imageNamed:@"多选勾选框_dj"] forState:UIControlStateNormal];
        [subDic setObject:@"1" forKey:@"defaultValue"];
    }
    [children replaceObjectAtIndex:index withObject:subDic];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *theDate = [NSDate date];
    dateFormatter.dateFormat =@"YYYY-MM-dd";
    NSString *dataStr =  [dateFormatter stringFromDate:theDate];
    [chageDic setObject:children forKey:@"children"];
    [chageDic setObject:dataStr forKey:@"addTime"];
    [chageDic setObject:@"0" forKey:@"code"];

    [dataArray replaceObjectAtIndex:indexPath.section withObject:chageDic];
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];

    if (_comeType == 1) {
    
        [defaut setObject:dataArray forKey:@"user_zhusuSDic"];
        
    }else if (_comeType == 2) {

        [defaut setObject:dataArray forKey:@"user_yingshiSDic"];

    }if (_comeType == 3) {
        
        [defaut setObject:dataArray forKey:@"user_shenghuoSDic"];

    }
    
    [defaut synchronize];
    
}

#pragma mark ------------------ 单选 -------------------------

- (void)tagButtonSingleClick:(UIButton *)button {
    
    
    NSIndexPath *indexPath =  objc_getAssociatedObject(button, "firstObject");
    NSInteger index =  [objc_getAssociatedObject(button, "secondObject") integerValue];
    
    
    NSMutableDictionary *chageDic =  [[NSMutableDictionary alloc]initWithDictionary:dataArray[indexPath.section]];
    
    NSMutableArray *children =[NSMutableArray arrayWithArray:[chageDic objectForKey:@"children"]];
    for (int i = 0; i < children.count; i++) {
    NSMutableDictionary *subDic = [[NSMutableDictionary alloc]initWithDictionary:[children objectAtIndex:i]];
        NSUInteger deftV = [[subDic objectForKey:@"defaultValue"] integerValue];
        UIButton *butt = [self.view viewWithTag: indexPath.section* 10000 +i+10];

        if (i ==  index) {
            if (deftV == 1) {
                
                [subDic setObject:@"0" forKey:@"defaultValue"];
                
                [butt setBackgroundImage:[UIImage imageNamed:@"单选勾选框_ct"] forState:UIControlStateNormal];
            }else{
                NSString *inde = [NSString stringWithFormat:@"%ld",index];
                [subDic setObject:inde forKey:@"defaultValue"];

               [butt setBackgroundImage:[UIImage imageNamed:@"单选勾选框_dj@2x"] forState:UIControlStateNormal];
               
            }

        }else{
            
            [subDic setObject:@"0" forKey:@"defaultValue"];
            

            [butt setBackgroundImage:[UIImage imageNamed:@"单选勾选框_ct"] forState:UIControlStateNormal];

        }
        
        [children replaceObjectAtIndex:i withObject:subDic];
        [chageDic setObject:children forKey:@"children"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSDate *theDate = [NSDate date];
        dateFormatter.dateFormat =@"YYYY-MM-dd";
        NSString *dataStr =  [dateFormatter stringFromDate:theDate];
        [chageDic setObject:children forKey:@"children"];
        [chageDic setObject:dataStr forKey:@"addTime"];
        [chageDic setObject:@"0" forKey:@"code"];

        [dataArray replaceObjectAtIndex:indexPath.section withObject:chageDic];

    }
    

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
