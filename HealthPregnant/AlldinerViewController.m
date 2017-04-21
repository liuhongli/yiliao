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
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    dinerArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_shanshiSDic"];
    [_myTabV reloadData];
}
- (void)initTableView {
    
    _myTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _myTabV.delegate = self;
    _myTabV.dataSource = self;
    _myTabV.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_myTabV];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return dinerArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = dinerArray[section];
    NSMutableArray *dArray = [NSMutableArray array];
  
        NSArray *zaoArray = [dic objectForKey:@"foodTime0"];
        for (NSDictionary *dic in zaoArray) {
            [dArray addObject:dic];
        }
        NSArray *zhongArray = [dic objectForKey:@"foodTime1"];
        for (NSDictionary *dic in zhongArray) {
            [dArray addObject:dic];
        }
        NSArray *wanArray = [dic objectForKey:@"foodTime2"];
        for (NSDictionary *dic in wanArray) {
            [dArray addObject:dic];
        }
        NSArray *jiaArray = [dic objectForKey:@"foodTime3"];
        for (NSDictionary *dic in jiaArray) {
            [dArray addObject:dic];
        }
        

    return dArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    NSDictionary *dic = dinerArray[section];
    labe.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    labe.textColor = [UIColor colorWithString:@"4A4A4A"];
    labe.text = [NSString stringWithFormat:@"  %@",[dic objectForKey:@"addTime"]];
    return labe;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSDictionary *dicS = dinerArray[section];
    NSMutableArray *dArray = [NSMutableArray array];
    
    NSArray *zaoArray = [dicS objectForKey:@"foodTime0"];
    for (NSDictionary *dic in zaoArray) {
        [dArray addObject:dic];
    }
    NSArray *zhongArray = [dicS objectForKey:@"foodTime1"];
    for (NSDictionary *dic in zhongArray) {
        [dArray addObject:dic];
    }
    NSArray *wanArray = [dicS objectForKey:@"foodTime2"];
    for (NSDictionary *dic in wanArray) {
        [dArray addObject:dic];
    }
    NSArray *jiaArray = [dicS objectForKey:@"foodTime3"];
    for (NSDictionary *dic in jiaArray) {
        [dArray addObject:dic];
    }
    
    if (dArray.count < 1) {
        return 0.01;
    }
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
            static NSString *cellIndefier = @"cell";
            EatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
            
            if (!cell) {
                
                cell = [[NSBundle mainBundle] loadNibNamed:@"EatTableViewCell" owner:self options:nil].lastObject;
            }
    
    
            NSDictionary *dicS = dinerArray[indexPath.section];
            NSMutableArray *dArray = [NSMutableArray array];
            
            NSArray *zaoArray = [dicS objectForKey:@"foodTime0"];
            for (NSDictionary *dic in zaoArray) {
                [dArray addObject:dic];
            }
            NSArray *zhongArray = [dicS objectForKey:@"foodTime1"];
            for (NSDictionary *dic in zhongArray) {
                [dArray addObject:dic];
            }
            NSArray *wanArray = [dicS objectForKey:@"foodTime2"];
            for (NSDictionary *dic in wanArray) {
                [dArray addObject:dic];
            }
            NSArray *jiaArray = [dicS objectForKey:@"foodTime3"];
            for (NSDictionary *dic in jiaArray) {
                [dArray addObject:dic];
            }

            NSDictionary *indexDic = dArray[indexPath.row];
    
            NSInteger dinType = [[indexDic objectForKey:@"foodTYpe"] integerValue];
            // 1早餐 2中 3晚 4加餐
            switch (dinType) {
                case 1:
                {
                    cell.dinerT.text = @"早餐";
                }
                    break;
                case 2:
                {
                    cell.dinerT.text = @"午餐";
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
            cell.dinerEat.text = [indexDic objectForKey:@"caption"];
            cell.dinerWht.text = [NSString stringWithFormat:@"%@g",[indexDic objectForKey:@"defaultValue"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dicS = dinerArray[indexPath.section];
    NSMutableArray *dArray = [NSMutableArray array];
    
    NSArray *zaoArray = [dicS objectForKey:@"foodTime0"];
    for (NSDictionary *dic in zaoArray) {
        [dArray addObject:dic];
    }
    NSArray *zhongArray = [dicS objectForKey:@"foodTime1"];
    for (NSDictionary *dic in zhongArray) {
        [dArray addObject:dic];
    }
    NSArray *wanArray = [dicS objectForKey:@"foodTime2"];
    for (NSDictionary *dic in wanArray) {
        [dArray addObject:dic];
    }
    NSArray *jiaArray = [dicS objectForKey:@"foodTime3"];
    for (NSDictionary *dic in jiaArray) {
        [dArray addObject:dic];
    }
    
    if (dArray.count < 1) {
        return 0.01;
    }

    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodDetailViewController *VC = [[FoodDetailViewController alloc] init];
    
    NSDictionary *dic = dinerArray[indexPath.section];
    
    VC.infoDic = [dic mutableCopy];
    
    VC.indexRow = indexPath.row;
    VC.indexSection = indexPath.section;
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
