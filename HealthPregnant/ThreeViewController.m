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

@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *titleArray;
    NSArray *imageSArray;
    NSArray *questionSArray;
    
}
@property (retain, nonatomic)UITableView *myTabV;


@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"膳食调查";
    titleArray = @[@"早餐",@"午餐",@"晚餐",@"加餐"];
    imageSArray = @[@"首页_常规调查icon_dj",@"首页_运动调查icon_dj",@"首页_膳食调查icon_dj",@"首页_个人信息icon_dj",@"首页_分析结果icon_dj"];
    [self initTableView];
}

- (void)initTableView {
    _myTabV = [[UITableView alloc] initWithFrame:    CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
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
    return 22;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *cellIndetifer = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifer];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifer];
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
            imageV.image = [UIImage imageNamed:imageSArray[i]];
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
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else{
            
            static NSString *cellIndefier = @"cell";
            EatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
            
            if (!cell) {
                
                cell = [[NSBundle mainBundle] loadNibNamed:@"EatTableViewCell" owner:self options:nil].lastObject;
            }
            
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

- (void)didcliK:(UIButton *)button {
    FoodViewController *foodVC = [[FoodViewController alloc] init];
    
    switch (button.tag) {
        case 10:
        {
            foodVC.comeType = 0;
        }
            break;
            
        case 11:
        {
            foodVC.comeType = 1;
        }
            break;
        case 12:
        {
            foodVC.comeType = 2;
        }
            break;

            
        default:{
            foodVC.comeType = 3;
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
