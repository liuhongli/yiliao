//
//  FoodDetailViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 17/1/10.
//  Copyright © 2017年 honely. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "RegistTableViewCell.h"

@interface FoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray *questionSArray;
    UITableView *table;

}

@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"常规调查";
    questionSArray = @[@"日期",@"餐食",@"食物",@"重量"];
    [self initTableView];
}

- (void)initTableView {
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UIButton *buton  = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 40)];
    [buton setTitle:@"提交" forState:UIControlStateNormal];
    [buton addTarget:self action:@selector(postInfo) forControlEvents:UIControlEventTouchUpInside];
    [buton setBackgroundColor:BaseColor];
    [view addSubview:buton];
    table.tableFooterView = view;
    UIBarButtonItem *butItem = [[UIBarButtonItem alloc] initWithTitle:@"删除记录" style:UIBarButtonItemStylePlain target:self action:@selector(deleteInfo)];
    self.navigationController.navigationItem.rightBarButtonItem = butItem;
}

- (void)deleteInfo{
    
    
}

- (void)postInfo {
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
