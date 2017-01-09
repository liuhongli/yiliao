//
//  FourViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/2.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "FourViewController.h"
#import "ToLunchTableViewCell.h"

@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *tableV;
    NSArray *titleArray;
}

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    

    titleArray = @[@[@"手机号码",@"姓名",@"出生年月",@"身高",@"末次月经"],@[@"血型",@"名族",@"职业",@"E-Mail",@"文化程度"]];
    [self initTableView];
}

- (void)initTableView{
    
    tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:    UITableViewStyleGrouped];
    tableV.dataSource = self;
    tableV.delegate = self;
    tableV.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableV];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return 5;
            
            break;
            
        default:
            
            return 5;

            break;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *cellIndefier = @"cell1";
    ToLunchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
    
    if (!cell) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"ToLunchTableViewCell" owner:self options:nil].lastObject;
    }
    
    NSArray *array = titleArray[indexPath.section];
    
    cell.titleLab.text = [NSString stringWithFormat:@"%@",array[indexPath.row]];
    
    cell.subLab.text = @"未填写";
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
  
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
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
