//
//  TwoViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/2.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "TwoViewController.h"
#import "RegistTableViewCell.h"
#import "ThreeDetailController.h"

@interface TwoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    NSArray *titleArray;
    NSArray *imageSArray;
    NSArray *questionSArray;
    
}
@property (retain, nonatomic)UITableView *myTabV;


@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.title = @"运动调查";
    questionSArray = @[@"日期",@"职业"];
    titleArray = @[@"睡眠时间调查",@"职业调查",@"运动调查"];
    imageSArray = @[@"首页_常规调查icon_dj",@"首页_运动调查icon_dj",@"首页_膳食调查icon_dj",@"首页_个人信息icon_dj",@"首页_分析结果icon_dj"];
    [self initTableView];
}
#pragma mark -------------------UITableView and delegate-------------------
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
        return questionSArray.count;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *cellIndefier = @"cell";
        RegistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        
        if (!cell) {
            
            cell = [[NSBundle mainBundle] loadNibNamed:@"RegistTableViewCell" owner:self options:nil].lastObject;
        }
        cell.nameLab.text = questionSArray[indexPath.row];
        cell.wTF.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else{
        if (indexPath.row == 0) {
            static NSString *cellIndetifer = @"cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifer];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifer];
            }
            cell.textLabel.text = @"常规检测";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else{
            
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
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/4*clow, 90*row, kScreenWidth/4, 90)];
                
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
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 60;
        }
        return 90*(titleArray.count/4+1)+20;
    }
    return 60;
}

- (void)didcliK:(UIButton *)button {

    ThreeDetailController *detailVC = [[ThreeDetailController alloc] init];
    
    switch (button.tag) {
        case 10:
        {
            
        }
            break;
            
        case 11:
        {

        }
            break;
            
        default:
            break;
    }
    
        [self.navigationController pushViewController:detailVC animated:YES];
    
}
#pragma mark -------------------textField delegat-------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return NO;
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
