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


@interface FiveViewController ()
{
    NSArray *titleArray;
    NSArray *imageSArray;



}
@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"分析结果";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadmainview];
    
    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://test.kpjkgl.com:8083/chart.aspx?basicid=15900001111&order=1"]]];
//    [self.view addSubview:webView];
}

- (void)loadmainview{

    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    lab.text = @"  调查结果";
    lab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lab];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 1)];
    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineview];
    
    UIView *btnview = [[UIView alloc]initWithFrame:CGRectMake(0, 61, kScreenWidth, 210)];
    btnview.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:btnview];
    
    
    titleArray = @[@"主诉与病症",@"既往及现病史",@"实验室检测",@"饮食习惯",@"生活习惯",@"膳食调查",@"运动调查"];
    imageSArray = @[@"分析_主诉与病症未勾选_ct",@"分析_既往及现病史未勾选_ct",@"分析_实验室检测未勾选_ct",@"分析_饮食习惯未勾选_ct",@"分析_生活习惯未勾选_ct",@"分析_膳食调查未勾选_ct",@"分析_运动调查未勾选_ct"];
    
    //标题
    for (int i = 0; i < titleArray.count; i++) {
        int row = i/4;
        int clow = i %4;
        NSLog(@"%d **** %d",row,clow);
        //创建按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/4*clow, 90*row, kScreenWidth/4, 90)];
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        //点击事件
        [button addTarget:self action:@selector(didcliK:) forControlEvents:UIControlEventTouchUpInside];
        
        //        [button setBackgroundColor: rgb(100+20*i, 150, 30+30*i, 1)];
        button.tag = 10+i;
        [btnview addSubview:button];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth/4-50)/2, 20, 50, 50)];
        imageV.layer.cornerRadius = 25;
        imageV.clipsToBounds = YES;
        imageV.image = [UIImage imageNamed:imageSArray[i]];
        //        imageV.backgroundColor = [UIColor redColor];
        [button addSubview:imageV];
        
        UILabel *titleLa = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.bottom + 10, kScreenWidth/4, 20)];
        titleLa.textAlignment = NSTextAlignmentCenter;
        titleLa.font = [UIFont systemFontOfSize:13];
        titleLa.text  = titleArray[i];
        [button addSubview:titleLa];
    }

    UIButton *sendbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendbtn.frame = CGRectMake(40, 290, kScreenWidth-80, 40);
    [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendbtn.backgroundColor = [UIColor colorWithHexString:@"FF8698" alpha:1];
    [sendbtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview: sendbtn];

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
            jianceVC.mutilSetlecd = 1;
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
