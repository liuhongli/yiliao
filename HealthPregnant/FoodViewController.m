//
//  FoodViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/12/12.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "FoodViewController.h"
#import "VCTableViewCell.h"
#import "MKPAlertView.h"



@interface FoodViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *dataArray;
    
    NSInteger leftSelected;
    
    NSInteger rightSelected;
    
}

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) UITableView *rightTableView;


@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"膳食调查";
    
    NSArray *result = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] objectForKey:@"result"];
    leftSelected = 0;
    NSDictionary *dic0 = result[19];
    NSDictionary *dic1 = result[20];
    NSDictionary *dic2 = result[21];
    NSDictionary *dic3 = result[22];
    NSDictionary *dic4 = result[23];
    NSDictionary *dic5 = result[24];
    NSDictionary *dic6 = result[25];
    NSDictionary *dic7 = result[26];
    NSDictionary *dic8 = result[27];
    NSDictionary *dic9 = result[28];
    
    dataArray  = [NSMutableArray arrayWithObjects:dic0,dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9 ,nil];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == self.leftTableView)
    {
        return 1;
    }else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _leftTableView)
    {
        return dataArray.count;
    }else
    {
        
        NSArray *childArr = [dataArray[leftSelected] objectForKey:@"children"];
        return childArr.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == _leftTableView)
    {
        NSDictionary *dic = dataArray[indexPath.row];
        NSString *Remark = [dic objectForKey:@"name"];
        CGSize sizeH = [self countHeight:Remark font:FontApp  witd:80];
        NSLog(@"%@==%f",Remark,sizeH.height);
        return  sizeH.height + 20;
    }else
    {
        return 50;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(tableView == self.leftTableView)
    {
        UITableViewCell *cell;
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"leftTableView" forIndexPath:indexPath];
        NSDictionary *dic = dataArray[indexPath.row];
        NSString *Remark = [dic objectForKey:@"name"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",Remark];
        cell.textLabel.font = [UIFont systemFontOfSize:FontApp];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        UIView *sepV = [[UIView alloc]initWithFrame:CGRectMake(cell.width-0.5, 0, 0.5, cell.height)];
        sepV.backgroundColor = [UIColor grayColor];
        sepV.alpha = 0.6;
        [cell.contentView addSubview:sepV];

        if (leftSelected == indexPath.row ) {
           
            cell.backgroundColor = [UIColor colorWithHexString:@"FF8698" alpha:1];
      
        }else{
          
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"FF8698" alpha:1];

        return cell;
        
    }else
    {
        VCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VCTableViewCell" forIndexPath:indexPath];
        
        NSDictionary *dic = dataArray[leftSelected];
        NSArray *childArr = [dic objectForKey:@"children"];
        NSDictionary *childDic = childArr[indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",[childDic objectForKey:@"caption"]];
        cell.textLabel.numberOfLines = 0;
        
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.tintColor = [UIColor colorWithHexString:@"FF8698" alpha:1];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        

        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.leftTableView)
    {
        leftSelected = indexPath.row;
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        NSIndexPath *ToIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.rightTableView selectRowAtIndexPath:ToIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
    }else{
        
        
        UITableViewCell*newCell = [tableView cellForRowAtIndexPath:indexPath];
        
        
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        if (indexPath.row != rightSelected) {
            NSIndexPath*oldIndexPath =[NSIndexPath indexPathForRow:rightSelected inSection:0];
            UITableViewCell*oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
            
            
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            
            
        }

        rightSelected =indexPath.row;

        MKPAlertView *alertView = [[MKPAlertView alloc]initWithTitle:@"自定义UIAlertView" type:2 sureBtn:@"确认" cancleBtn:@"取消"];
        alertView.resultIndex = ^(NSString * str)
        {
            // 回调 -- 处理
            NSLog(@"%@",str);
            
                NSIndexPath*oldIndexPath =[NSIndexPath indexPathForRow:rightSelected inSection:0];
                UITableViewCell*oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];

                oldCell.accessoryType=UITableViewCellAccessoryNone;

            
            
        };
        [alertView showMKPAlertView];

    }
}


- (UITableView *)leftTableView
{
    if(_leftTableView == nil)
    {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*0.3, kScreenHeight) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftTableView"];
        _leftTableView.tableFooterView = [[UIView alloc]init];
        
    }
    return _leftTableView;
}
- (UITableView *)rightTableView
{
    if(_rightTableView == nil)
    {
        
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth*0.3, 0, kScreenWidth*0.7, kScreenHeight) style:UITableViewStylePlain];
        _rightTableView.delegate= self;
        _rightTableView.dataSource = self;
        
        
        [_rightTableView registerClass:[VCTableViewCell class] forCellReuseIdentifier:@"VCTableViewCell"];
        _rightTableView.tableFooterView = [[UIView alloc]init];
    }
    return _rightTableView;
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
