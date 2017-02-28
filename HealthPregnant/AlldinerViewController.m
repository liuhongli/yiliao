//
//  AlldinerViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 17/2/28.
//  Copyright © 2017年 honely. All rights reserved.
//

#import "ThreeViewController.h"
#import "ToLunchTableViewCell.h"
#import "EatTableViewCell.h"
#import "FoodViewController.h"
#import "FoodDetailViewController.h"
#import "AlldinerViewController.h"

@interface AlldinerViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *questionSArray;
    NSArray *dinerArray;
}
@property (retain, nonatomic)UITableView *myTabV;

@end

@implementation AlldinerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"膳食调查";
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    dinerArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_shanshiPDic"];
    [_myTabV reloadData];
}
- (void)initTableView {
    
    _myTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _myTabV.delegate = self;
    _myTabV.dataSource = self;
    [self.view addSubview:_myTabV];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dinerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
            static NSString *cellIndefier = @"cell";
            EatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
            
            if (!cell) {
                
                cell = [[NSBundle mainBundle] loadNibNamed:@"EatTableViewCell" owner:self options:nil].lastObject;
            }
            
            NSDictionary *dic = dinerArray[indexPath.row];
            
            NSInteger dinType = [[dic objectForKey:@"updateTime"] integerValue];
            // 1早餐 2中 3晚 4加餐 5 修改
            switch (dinType) {
                case 1:
                {
                    cell.dinerT.text = @"早餐";
                }
                    break;
                case 2:
                {
                    cell.dinerT.text = @"中餐";
                }
                    break;
                case 3:
                {
                    cell.dinerT.text = @"晚餐";
                }
                    break;
                case 4:
                {
                    cell.dinerT.text = @"加餐";
                }
                    break;
                case 5:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
            cell.dinerEat.text = [dic objectForKey:@"caption"];
            cell.dinerWht.text = [dic objectForKey:@"defaultValue"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodDetailViewController *VC = [[FoodDetailViewController alloc] init];
    
    NSDictionary *dic = dinerArray[indexPath.row];
    
    VC.infoDic = [dic mutableCopy];
    
    VC.indexRow = indexPath.row;
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
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
