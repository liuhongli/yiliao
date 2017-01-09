//
//  FiveViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/2.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "FiveViewController.h"

@interface FiveViewController ()

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"分析结果";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://test.kpjkgl.com:8083/chart.aspx?basicid=15900001111&order=1"]]];
    [self.view addSubview:webView];
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
