//
//  OneViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/3/31.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "OneViewController.h"
#import "RegistTableViewCell.h"
#import "SickViewController.h"
#import "OSIickViewController.h"
#import "JianceViewController.h"
#import "HabitViewController.h"

@interface OneViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    NSArray *titleArray;
    NSArray *imageSArray;
    NSArray *questionSArray;
}
@property (weak, nonatomic) IBOutlet UITableView *myTabV;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"常规调查";
    questionSArray = @[@"调查日期",@"孕周",@"孕期"];

    titleArray = @[@"主诉与病症",@"既往发现病史",@"实验室检测",@"饮食习惯",@"生活习惯"];
    imageSArray = @[@"首页_常规调查icon_dj",@"首页_运动调查icon_dj",@"首页_膳食调查icon_dj",@"首页_个人信息icon_dj",@"首页_分析结果icon_dj"];
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
        cell.wTF.tag = 1000 + indexPath.row;
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
    
    switch (button.tag) {
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


        default:
            break;
    }
    
}

#pragma mark -------------------textField delegat-------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 1000) {
        
    }else if (textField.tag == 1001){
        
    }else if (textField.tag == 1002){
        
    }

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
