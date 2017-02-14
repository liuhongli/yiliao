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
    
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    
    if (_comeType == 1) {
        
        dataArray = [defaut objectForKey:@"user_zhusuSDic"];
        
    }else if (_comeType == 2) {
        
        dataArray = [defaut objectForKey:@"user_yingshiSDic"];

        
    }if (_comeType == 3) {
        
        dataArray = [defaut objectForKey:@"user_shenghuoSDic"];

        
    }
    if (dataArray.count <  1) {
      
        [self initData];
    }

    [self initTableView];
    [self initFootView];
}
- (void)initData{
    
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
    
    
    NSDictionary *dic1 = result[0];
    NSDictionary *dic2 = result[1];
    NSDictionary *dic3 = result[2];
    NSDictionary *dic4 = result[3];
    NSDictionary *dic5 = result[4];
    
    dataArray = [[NSMutableArray alloc] initWithObjects:dic1,dic2,dic3,dic4,dic5,nil];
    
}


- (void)dataYin:(NSArray *)result{
    
    NSDictionary *dic1 = result[7];
    NSDictionary *dic2 = result[8];
    NSDictionary *dic3 = result[9];
    dataArray = [[NSMutableArray alloc] initWithObjects:dic1,dic2,dic3,nil];

}
- (void)dataShen:(NSArray *)result{
    
    NSDictionary *dic1 = result[10];
    NSDictionary *dic2 = result[11];
    NSDictionary *dic3 = result[12];
    NSDictionary *dic4 = result[13];
    NSDictionary *dic5 = result[14];
    NSDictionary *dic6 = result[7];
    NSDictionary *dic7 = result[8];
    NSDictionary *dic8 = result[9];


    
    dataArray = [[NSMutableArray alloc] initWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,nil];

    
}

- (void)initFootView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UIButton *buton  = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 40)];
    [buton setTitle:@"提交" forState:UIControlStateNormal];
    [buton addTarget:self action:@selector(postInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    [buton setBackgroundColor:[UIColor colorWithHexString:@"FF8698" alpha:1]];

    [view addSubview:buton];
     _myTabV.tableFooterView = view;

}
#pragma mark ------------------ 提交信息 -------------------------


- (void)postInfo:(UIButton *)button {
    
    NSDictionary *para ;
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in dataArray) {
       
        NSArray *chidArr = [dic objectForKey:@"children"];
        for (NSDictionary *chidDic in chidArr) {
            NSInteger defaultValue = [[chidDic objectForKey:@"defaultValue"] integerValue];
            if (defaultValue == 1) {
                [paraDic setObject:@"1" forKey:[chidDic objectForKey:@"fieldName"]];
            }
        }
    }
    
    NSString *tableName = [dataArray[0] objectForKey:@"tableName"];
    NSDictionary *dic = USERINFO;
    
    NSDate *theDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd ";
    
    
    NSArray *parArr =@[@{@"field":paraDic,@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"inspectionOrder":@"1",@"recordTime":[dateFormatter stringFromDate:theDate],@"sign":@"1",@"tableName":tableName}];
    para = @{@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"recordTime":[dateFormatter stringFromDate:theDate],@"generalSurveyList":parArr};
    
    [RBaseHttpTool postWithUrl:@"data/upload2" parameters:para sucess:^(id json) {
        
        
        NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
        
        if (_comeType == 1) {
            
            [defaut setObject:para forKey:@"user_zhusuPDic"];
            
        }else if (_comeType == 2) {
            
            [defaut setObject:para forKey:@"user_yingshiPDic"];
            
        }if (_comeType == 3) {
            
            [defaut setObject:para forKey:@"user_shenghuoPDic"];
            
        }
        
        [defaut synchronize];

        NSInteger success = [[json objectForKey:@"success"] integerValue];
        [Alert showWithTitle:[json objectForKey:@"message"]];

        if (success == 1) {
            [Alert showWithTitle:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failur:^(NSError *error) {
        
        [Alert showWithTitle:[NSString stringWithFormat:@"%@",error.userInfo]];
        
        
    }];

    
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
    [chageDic setObject:children forKey:@"children"];
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
                
                [subDic setObject:@"1" forKey:@"defaultValue"];

               [butt setBackgroundImage:[UIImage imageNamed:@"单选勾选框_dj@2x"] forState:UIControlStateNormal];
               
            }

        }else{
            
            [subDic setObject:@"0" forKey:@"defaultValue"];
            

            [butt setBackgroundImage:[UIImage imageNamed:@"单选勾选框_ct"] forState:UIControlStateNormal];

        }
        
        [children replaceObjectAtIndex:i withObject:subDic];
        [chageDic setObject:children forKey:@"children"];
        [dataArray replaceObjectAtIndex:indexPath.section withObject:chageDic];

    }
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
