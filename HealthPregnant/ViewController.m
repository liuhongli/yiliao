//
//  ViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/3/31.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SDCycleScrollView.h"

@interface ViewController ()<SDCycleScrollViewDelegate>{
    
    NSArray *titleArray;
    NSArray *imageSArray;
    UILabel *textLab;
}

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = YES;
    if (USERINFO) {
        NSDictionary *dic = USERINFO;
        textLab.hidden = YES;

    if ([dic objectForKey:@"lastUpdateTime"]) {
        NSString *dataStr = [NSString dateString:[dic objectForKey:@"lastUpdateTime"]];
        NSString *str = [NSString stringWithFormat:@"检测日期:%@",dataStr];
        textLab.text = str;
        textLab.hidden = NO;

    }
        
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    titleArray = @[@"常规调查",@"运动调查",@"膳食调查",@"个人信息",@"分析结果"];
    imageSArray = @[@"首页_常规调查icon_dj",@"首页_运动调查icon_dj",@"首页_膳食调查icon_dj",@"首页_个人信息icon_dj",@"首页_分析结果icon_dj"];
    [self initView];

}

- (void)initView {
    
    //滑动视图
    UIView *scrollView = [[UIView  alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight-135)];
    scrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scrollView];
    
    
    NSArray *images = @[[UIImage imageNamed:@"启动页.png"],
                        [UIImage imageNamed:@"banner2.jpg"]
                        ];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:scrollView.frame imagesGroup:images];
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 5.0;
    cycleScrollView.imageType = 3;
    [scrollView addSubview:cycleScrollView];
    

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight-200, kScreenWidth, 200)];
    imageView.alpha = 1;
    imageView.userInteractionEnabled = YES;
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:@"主页弧形底"];
    imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageView];
    NSString *yuaStr = @"检测日期:2017-04-27";
    CGSize orsize = [yuaStr sizeWithFont:[UIFont  systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT,15)];
    textLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-orsize.width/2, 30, orsize.width, 15)];
    textLab.font = [UIFont  systemFontOfSize:14];
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.textColor = [UIColor colorWithHexString:@"FF8698" alpha:1];
    [imageView addSubview:textLab];
    UIImageView *imageS = [[UIImageView alloc] initWithFrame:CGRectMake(textLab.width+3, 0, 15, 15)];
    imageS.image = [UIImage imageNamed:@"单选勾选框_dj"];
    [textLab addSubview:imageS];
    //标题
    for (int i = 0; i < titleArray.count; i ++) {
        
        //创建按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/5*i, 20, kScreenWidth/5, 150)];
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        //点击事件
        [button addTarget:self action:@selector(didcliK:) forControlEvents:UIControlEventTouchUpInside];
        
//        [button setBackgroundColor: rgb(100+20*i, 150, 30+30*i, 1)];
        button.tag = 10+i;
        [imageView addSubview:button];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth/5-50)/2, 50, 50, 50)];
        imageV.layer.cornerRadius = 25;
        imageV.clipsToBounds = YES;
        imageV.image = [UIImage imageNamed:imageSArray[i]];
        imageV.backgroundColor = [UIColor redColor];
        [button addSubview:imageV];
        
        UILabel *titleLa = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.bottom + 10, kScreenWidth/5, 20)];
        titleLa.textAlignment = NSTextAlignmentCenter;
        titleLa.font = [UIFont systemFontOfSize:13];
        titleLa.text  = titleArray[i];
        [button addSubview:titleLa];
    }
}

- (void)didcliK:(UIButton *)button {

    switch (button.tag) {
     
        case 10:
        {
            OneViewController *oneVC = [[OneViewController alloc] init];
            [self.navigationController pushViewController:oneVC animated:NO];
        }
            break;
      
        case 11  :
        {
            TwoViewController *twoVC = [[TwoViewController alloc] init];
            [self.navigationController pushViewController:twoVC animated:NO];
            
        }
            break;
     
        case 12:
        {
            ThreeViewController *threeVC = [[ThreeViewController alloc] init];
            [self.navigationController pushViewController:threeVC animated:NO];
        }
            break;
     
        case 13:
        {
            
            FourViewController *fourVC = [[FourViewController alloc] init];
            [self.navigationController pushViewController:fourVC animated:NO];
            
        }
            break;
       
        case 14:
        {
            FiveViewController *five = [[FiveViewController alloc] init];
            [self.navigationController pushViewController:five animated:NO];
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

@end
