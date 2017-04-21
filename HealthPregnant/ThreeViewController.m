//
//  ThreeViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/2.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "ThreeViewController.h"
#import "ToLunchTableViewCell.h"
#import "EatTableViewCell.h"
#import "FoodViewController.h"
#import "FoodDetailViewController.h"
#import "AlldinerViewController.h"

@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *titleArray;
    NSArray *imageSArray;
    NSArray *questionSArray;
    NSArray *imageSeleArray;
    NSInteger selectInt;
    NSMutableArray *dinerArray;
}
@property (retain, nonatomic)UITableView *myTabV;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"膳食调查";
    selectInt = 0;
    dinerArray = [NSMutableArray array];
    titleArray = @[@"早餐",@"午餐",@"晚餐",@"加餐"];
    imageSArray = @[@"膳食_早餐icon_ct",@"膳食_午餐icon_ct",@"膳食_晚餐icon_ct",@"膳食_加餐icon_ct"];
    imageSeleArray = @[@"膳食_早餐icon_dj",@"膳食_午餐icon_dj",@"膳食_晚餐icon_dj",@"膳食_加餐icon_dj"];

        [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [dinerArray removeAllObjects];
 NSMutableArray  *dinArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"user_shanshiSDic"] mutableCopy];
    if (dinArray.count > 0) {
        NSDictionary *dic = dinArray[0];
        NSArray *zaoArray = [dic objectForKey:@"foodTime0"];
        for (NSDictionary *dic in zaoArray) {
            [dinerArray addObject:dic];
        }
        NSArray *zhongArray = [dic objectForKey:@"foodTime1"];
        for (NSDictionary *dic in zhongArray) {
            [dinerArray addObject:dic];
        }
        NSArray *wanArray = [dic objectForKey:@"foodTime2"];
        for (NSDictionary *dic in wanArray) {
            [dinerArray addObject:dic];
        }
        NSArray *jiaArray = [dic objectForKey:@"foodTime3"];
        for (NSDictionary *dic in jiaArray) {
            [dinerArray addObject:dic];
        }

    }
    [_myTabV reloadData];
}
- (void)initTableView {
   
    _myTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _myTabV.delegate = self;
    _myTabV.dataSource = self;
    
    [self.view addSubview:_myTabV];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return dinerArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *cellIndetifer = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifer];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifer];
        }
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
        //标题
        for (int i = 0; i < titleArray.count; i ++) {
            int row = i/4;
            int clow = i %4;
            NSLog(@"%d **** %d",row,clow);
            //创建按钮
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/4*clow, 95*row, kScreenWidth/4, 90)];
            
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            //点击事件
            [button addTarget:self action:@selector(didcliK:) forControlEvents:UIControlEventTouchUpInside];
            
            //        [button setBackgroundColor: rgb(100+20*i, 150, 30+30*i, 1)];
            button.tag = 10+i;
            [cell.contentView addSubview:button];
            
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth/4-50)/2, 20, 50, 50)];
            imageV.layer.cornerRadius = 25;
            imageV.clipsToBounds = YES;
            if (i == selectInt) {
                imageV.image = [UIImage imageNamed:imageSeleArray[i]];

            }else{
                imageV.image = [UIImage imageNamed:imageSArray[i]];
            }
            imageV.backgroundColor = [UIColor redColor];
            [button addSubview:imageV];
            
            UILabel *titleLa = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.bottom + 10, kScreenWidth/4, 20)];
            titleLa.textAlignment = NSTextAlignmentCenter;
            titleLa.font = [UIFont systemFontOfSize:13];
            titleLa.text  = titleArray[i];
            [button addSubview:titleLa];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    else{
        if (indexPath.row == 0) {
            static NSString *cellIndefier = @"cell1";
            ToLunchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
            
            if (!cell) {
                
                cell = [[NSBundle mainBundle] loadNibNamed:@"ToLunchTableViewCell" owner:self options:nil].lastObject;
            }
            cell.subLab.text = [NSString stringWithFormat:@"查看全部 >"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else{
            
            static NSString *cellIndefier = @"cell";
            EatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
            
            if (!cell) {
                
                cell = [[NSBundle mainBundle] loadNibNamed:@"EatTableViewCell" owner:self options:nil].lastObject;
            }
            
            NSDictionary *dic = dinerArray[indexPath.row - 1];
            
            NSInteger dinType = [[dic objectForKey:@"foodTYpe"] integerValue];
           // 1早餐 2中 3晚 4加餐 5 修改
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
            cell.dinerEat.text = [dic objectForKey:@"caption"];
            cell.dinerWht.text = [dic objectForKey:@"defaultValue"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;

            
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 90*(titleArray.count/4)+20;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            AlldinerViewController *vc = [[AlldinerViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            NSMutableArray  *dinArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"user_shanshiSDic"] mutableCopy];

            FoodDetailViewController *VC = [[FoodDetailViewController alloc] init];
            NSDictionary *dic = dinArray[0];
            
            VC.infoDic = [dic mutableCopy];
            
            VC.indexRow = indexPath.row-1;
            VC.indexSection = 0;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}
- (void)didcliK:(UIButton *)button {
    FoodViewController *foodVC = [[FoodViewController alloc] init];
    selectInt = button.tag- 10;
    
    switch (button.tag) {
        case 10:
        {
            foodVC.comeType = 1;
        }
            break;
            
        case 11:
        {
            foodVC.comeType = 2;
        }
            break;
        case 12:
        {
            foodVC.comeType = 3;
        }
            break;

            
        default:{
            foodVC.comeType = 4;
        }
            break;
    }

   [self.navigationController pushViewController:foodVC animated:YES];

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
