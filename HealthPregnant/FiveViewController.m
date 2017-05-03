//
//  FiveViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/2.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "FiveViewController.h"
#import "FoodViewController.h"
#import "HabitViewController.h"
#import "OSIickViewController.h"
#import "JianceViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "ResultViewController.h"
#import "AppDelegate.h"

@interface FiveViewController ()
{
    NSArray *titleArray;
    NSArray *imageSArray;//未勾选
    NSArray *imageArray;//勾选




}
@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"分析结果";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadmainview];

}
- (void)loadmainview{
    
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }

    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    lab.text = @"  调查结果";
    lab.font = [UIFont fontWithName:@"PingFangSC" size:16];
    lab.textColor = [UIColor colorWithString:@"4A4A4A"];
    lab.backgroundColor = [UIColor whiteColor];
    lab.alpha = 0.7;
    [self.view addSubview:lab];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 1)];
    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineview];
    
    UIView *btnview = [[UIView alloc]initWithFrame:CGRectMake(0, 61, kScreenWidth, 210)];
    btnview.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:btnview];
    
    
    titleArray = @[@"主诉与病症",@"既往及现病史",@"实验室检测",@"饮食习惯",@"生活习惯",@"膳食调查",@"运动调查"];
    imageSArray = @[@"分析_主诉与病症未勾选_ct",@"分析_既往及现病史未勾选_ct",@"分析_实验室检测未勾选_ct",@"分析_饮食习惯未勾选_ct",@"分析_生活习惯未勾选_ct",@"分析_膳食调查未勾选_ct",@"分析_运动调查未勾选_ct"];
    imageArray = @[@"分析_主诉与病症勾选_ct",@"分析_既往及现病史勾选_ct",@"分析_实验室检测勾选_ct",@"分析_饮食习惯勾选_ct",@"分析_生活习惯勾选_ct",@"分析_膳食调查勾选_ct",@"分析_运动调查勾选_ct"];
    
    //标题
    for (int i = 0; i < titleArray.count; i++) {
        int row = i/4;
        int clow = i %4;
        //创建按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/4*clow, 90*row, kScreenWidth/4, 90)];
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        //点击事件
        [button addTarget:self action:@selector(didcliK:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = 10+i;
        [btnview addSubview:button];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth/4-50)/2, 20, 50, 50)];
//        imageV.layer.cornerRadius = 25;
        imageV.clipsToBounds = YES;
        
        switch (4*row + clow) {
            case 0:
            {
                if (zhusuSDic == nil) {
                    imageV.image = [UIImage imageNamed:imageSArray[i]];
    
                }else{
                    imageV.image = [UIImage imageNamed:imageArray[i]];

                }
            }
                break;
            case 1:
            {
                if (jiwangSDic == nil) {
                    imageV.image = [UIImage imageNamed:imageSArray[i]];
    
                }else{
                    imageV.image = [UIImage imageNamed:imageArray[i]];

                }
            }
                break;
            case 2:
            {
                if (shiyanSDic == nil) {
                    imageV.image = [UIImage imageNamed:imageSArray[i]];

                }else{
                    imageV.image = [UIImage imageNamed:imageArray[i]];

                }
            }
                break;
            case 3:
            {
                if (yingshiSDic == nil) {
                    imageV.image = [UIImage imageNamed:imageSArray[i]];
   
                }else{
                    imageV.image = [UIImage imageNamed:imageArray[i]];

                }
            }
                break;
            case 4:
            {
                if (shenghuoSDic == nil) {
                    imageV.image = [UIImage imageNamed:imageSArray[i]];
       
                }else{
                    imageV.image = [UIImage imageNamed:imageArray[i]];

                }
            }
                break;
            case 5:
            {
                if (shanshiSDic == nil) {
                    imageV.image = [UIImage imageNamed:imageSArray[i]];
     
                }else{
                    imageV.image = [UIImage imageNamed:imageArray[i]];

                }
            }
                break;
            case 6:
            {
                if (yjobSDic == nil) {
                    imageV.image = [UIImage imageNamed:imageSArray[i]];
    
                }else{
                    imageV.image = [UIImage imageNamed:imageArray[i]];

                }
            }
                break;
            default:
                break;
        }
        
        [button addSubview:imageV];
        
        UILabel *titleLa = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.bottom + 10, kScreenWidth/4, 20)];
        titleLa.textAlignment = NSTextAlignmentCenter;
        titleLa.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        titleLa.textColor = [UIColor colorWithString:@"4A4A4A"];
        
        titleLa.text  = titleArray[i];
        [button addSubview:titleLa];
    }

    UIButton *sendbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendbtn.frame = CGRectMake(40, 290, kScreenWidth-80, 40);
    [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendbtn.backgroundColor = [UIColor colorWithHexString:@"FF8698" alpha:1];
    [sendbtn setTitle:@"提交并分析" forState:UIControlStateNormal];
    [sendbtn addTarget:self action:@selector(postInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: sendbtn];

}


- (void)postInfo:(UIButton *)button {
    if (!zhusuSDic||!zhusuSDic||!jiwangSDic||!shiyanSDic||!yingshiSDic||!shenghuoSDic||!shanshiSDic) {
        [Alert showWithTitle:@"请填写必要信息"];
        return;
    }
    
    if (!ysleepSDic||!yjsleepSDic||!yesleepSDic||!yjobSDic||!ytsleepSDic) {
        [Alert showWithTitle:@"请填写运动调查数据"];
        return;
    }
    NSLog(@"%@",ytsleepSDic);

    NSArray *yuArray = @[ysleepSDic,yjsleepSDic,yesleepSDic,yjobSDic,ytsleepSDic];
    NSMutableArray *yuM = [NSMutableArray array];
    NSMutableDictionary *yuDIc = [NSMutableDictionary dictionary];
    for (NSArray *arr in yuArray) {
        for (NSDictionary *dic in arr) {
            NSString *addTime = [dic objectForKey:@"addTime"];
            NSLog(@"%d",yuDIc.allKeys.count);
            if ([yuDIc objectForKey:addTime] == nil) {
                    [yuDIc setObject:@[dic] forKey:addTime];
            }else{
                NSMutableArray *ma = [[yuDIc objectForKey:addTime] mutableCopy];
                [ma addObject:dic];
                
                [yuDIc setObject:ma forKey:addTime];
            }

        }
    }
    NSArray *keyArray = [yuDIc allKeys];
    for (NSString *str in keyArray) {
        NSArray *subA = [yuDIc objectForKey:str];
        NSMutableDictionary *subMD = [NSMutableDictionary dictionary];
        NSMutableArray *child = [NSMutableArray array];
        for (NSDictionary *dic in subA) {
            [subMD setObject:[dic objectForKey:@"addTime"] forKey:@"addTime"];
            [subMD setObject:@"1" forKey:@"code"];

            [subMD setObject:[dic objectForKey:@"tableName"] forKey:@"tableName"];
            NSArray *subChidArr = [dic objectForKey:@"children"];
            for (NSDictionary *su in subChidArr) {
                [child addObject:su];
            }

        }
        [subMD setObject:child forKey:@"children"];
        [yuM addObject:subMD];
    }
    
    NSArray *arry = @[zhusuSDic,jiwangSDic,shiyanSDic,yingshiSDic,shenghuoSDic,shanshiSDic,yuM];
    NSDictionary *para = [self dataArray:arry];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] ;
    
    NSDictionary *para1 = @{@"jsonStr":jsonString};
    [self showHUD:@"数据提交中..."];
    [RBaseHttpTool postWithUrl:@"data/upload2" parameters:para1 sucess:^(id json) {
        [super hideHUD];
        NSInteger success = [[json objectForKey:@"success"] integerValue];
        
        if (success == 1) {
            [button setTitle:@"查看分析结果" forState:UIControlStateNormal];
            ResultViewController *vc = [[ResultViewController alloc]init];
            
            
            vc.orderId = [NSString stringWithFormat:@"%@",[[json objectForKey:@"result"] objectForKey:@"InspectionOrder"]];
            [self.navigationController pushViewController:vc animated:YES];
            AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [dele lodInfo];
        }else{
            
            [Alert showWithTitle:[json objectForKey:@"message"]];
            return ;
        }

    } failur:^(NSError *error) {
        [super hideHUD];
  
    }];
}


- (void)didcliK:(UIButton *)btn{
    FoodViewController *foodVC = [[FoodViewController alloc] init];

    switch (btn.tag) {
        case 10:
        {
            
            HabitViewController *jianceVC = [[HabitViewController alloc] init];
            jianceVC.title = @"主诉病症";
            jianceVC.mutilSetlecd = 2;
            jianceVC.comeType = 1;
            [self.navigationController pushViewController:jianceVC animated:NO];
            
            
        }
            break;
            
        case 11:
        {
            OSIickViewController *osciVC = [[OSIickViewController alloc] init];
            [self.navigationController pushViewController:osciVC animated:NO];
        }
            break;
            
        case 12:
        {
            JianceViewController *jianceVC = [[JianceViewController alloc] init];
            [self.navigationController pushViewController:jianceVC animated:NO];
        }
            break;
            
        case 13:
        {
            HabitViewController *jianceVC = [[HabitViewController alloc] init];
            jianceVC.title = @"饮食习惯";
            jianceVC.mutilSetlecd = 2;
            jianceVC.comeType = 2;
            [self.navigationController pushViewController:jianceVC animated:NO];
        }
            break;
            
        case 14:
        {
            
            HabitViewController *jianceVC = [[HabitViewController alloc] init];
            jianceVC.title = @"生活习惯";
            jianceVC.mutilSetlecd = 1;
            jianceVC.comeType = 3;
            [self.navigationController pushViewController:jianceVC animated:NO];
            
        }
            break;
        case 15:
        {
            ThreeViewController *threevs =[[ThreeViewController alloc]init];
            [self.navigationController pushViewController:threevs animated:YES];
            
        }
            
            break;
        case 16:
        {
            TwoViewController *threevs =[[TwoViewController alloc]init];
            [self.navigationController pushViewController:threevs animated:YES];

        
        }
            
            break;
        default:
            break;
    }
    
}

//提交检测信息
- (void)sendmess{

    //去数据进行数据处理
/*    NSLog(@"%@,%@,%@,%@,%@,%@,%@",zhusuSDic,jiwangSDic,shiyanPDic,yingshiPDic,shenghuoPDic,shanshiPDic,yundongPDic);
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    NSLog(@"%@",zhusuSDic);
 NSDictionary *dic =  [self  dataArray:@[zhusuSDic,zhusuSDic]];
    NSLog(@"%@",dic);
    NSMutableArray *arr = [NSMutableArray array];
    if (zhusuPDic != nil) {
        [mudic setObject:[zhusuPDic objectForKey:@"generalSurveyList"] forKey:@"generalSurveyList"];
        [arr addObject:zhusuPDic];
        
    }
    if (jiwangSDic != nil) {
        
    }
    if (shiyanPDic != nil) {
    }
    if (yingshiPDic != nil) {
    }
    if (shenghuoPDic != nil) {
    }
    if (shanshiPDic != nil) {
    }
    if (yundongPDic != nil) {
    }*/

    //转json
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:nil options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] ;

    NSDictionary *para1 = @{@"jsonStr":jsonString};

 
    
    
    //KEY=jsonStr; VALUE={"dietarySurveyList":[{"field":{"StapleFoodRoundGrainedRice":"8"},"foodTime":"0","globalRecordNr":"15900001111","inspectionOrder":"1","recordTime":"2017-01-16","sign":"1","tableName":"StapleFoodInspectionO"},{"field":{"StapleFoodWheatFlourEmbryoIntake":"2"},"foodTime":"3","globalRecordNr":"15900001111","inspectionOrder":"1","recordTime":"2017-01-16","sign":"1","tableName":"StapleFoodInspectionO"}],"generalSurveyList":[{"field":{"ImmuneOralUlcersTag":"1","SkinRoughSkinTag":"1"},"globalRecordNr":"15900001111","inspectionOrder":"1","recordTime":"2016-11-22","sign":"1","tableName":"StatementSymptomRecord"},{"field":{"BloodHypotensionTag":"1"},"globalRecordNr":"15900001111","inspectionOrder":"1","recordTime":"2016-11-22","sign":"1","tableName":"DiseaseHistoryRecord"},{"field":{"FundalHeight":"49","HighBloodPressure":"1 ","LowBloodPressure":" 3 "},"globalRecordNr":"15900001111","inspectionOrder":"1","recordTime":"2016-11-22","sign":"1","tableName":"PhysiqueCheckRecord"},{"field":{"LongTimeNoStaple":"1"},"globalRecordNr":"15900001111","inspectionOrder":"1","recordTime":"2016-11-22","sign":"1","tableName":"DietHabitInspection"},{"field":{"SmokeHabit":"1","NourishmentYesOrNo":"1","CoffeeHabit":"3","StayUpAllNight":"1","WineHabit":"1"},"globalRecordNr":"15900001111","inspectionOrder":"1","recordTime":"2016-11-22","sign":"1","tableName":"LifeHabbitInspection"}],"globalRecordNr":"15900001111","recordTime":"2016-11-22","sportSurveyList":[{"field":{"ProfessionTime":"4","Agriculture":"1","stepCountExceed6000":"1","SleepExceed10Hour":"1"},"globalRecordNr":"15900001111","inspectionOrder":"1","recordTime":"2017-01-16","sign":"1","tableName":"SportConditionInspectionO"}]}

    [RBaseHttpTool postWithUrl:@"data/upload2" parameters:para1 sucess:^(id json) {
        
        NSLog(@"%@",json);
    } failur:^(NSError *error) {
        
    }];
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
