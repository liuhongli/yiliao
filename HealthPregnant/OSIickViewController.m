//
//  OSIickViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/7.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "OSIickViewController.h"
#import "OSlickTableViewCell.h"

@interface OSIickViewController ()<UITableViewDataSource,UITableViewDelegate,RJIWangDelegate>{
    
        NSMutableDictionary *dataDic;
}

@end

@implementation OSIickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"既往及现病史";
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] isKindOfClass:[NSDictionary class]]) {
        [Alert showWithTitle:@"尚未获取数据，请稍后重试..."];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    UIView *rightview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savebtn.frame = CGRectMake(40, 0, 40, 40);
    [savebtn setTitle:@"重置" forState:UIControlStateNormal];
    [savebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [savebtn addTarget:self action:@selector(reSave) forControlEvents:UIControlEventTouchUpInside];
    [rightview addSubview:savebtn];
    
    UIBarButtonItem *buttonItem  = [[UIBarButtonItem alloc] initWithCustomView:rightview];
    self.navigationItem.rightBarButtonItem  = buttonItem;
    
    


    NSArray *result = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] objectForKey:@"result"];

    
    
    NSDictionary *dic1;
    for (NSDictionary *dic in result) {
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"DiseaseHistoryRecord"]) {
            dic1 = dic;
        }
    }

    NSArray  *arr =  jiwangSDic;
    if (arr.count > 0) {
        dataDic = [[NSMutableDictionary alloc] initWithDictionary:arr[0]];

    }else{
    dataDic = [[NSMutableDictionary alloc] initWithDictionary:dic1];
    }
    [_tableView reloadData];
    [self initFootView];
}

- (void)reSave{
    NSArray *result = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] objectForKey:@"result"];
    
    NSDictionary *dic1;
    for (NSDictionary *dic in result) {
        if ([[dic objectForKey:@"tableName"] isEqualToString:@"DiseaseHistoryRecord"]) {
            dic1 = dic;
        }
    }

    
    dataDic = [[NSMutableDictionary alloc] initWithDictionary:dic1];
    [_tableView reloadData];
    NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
    [stand setObject:@[dataDic] forKey:@"user_jiwangSDic"];
    [stand synchronize];

}
- (void)initFootView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UIButton *buton  = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 40)];
    [buton setTitle:@"保存" forState:UIControlStateNormal];
    [buton addTarget:self action:@selector(postInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    [buton setBackgroundColor:[UIColor colorWithHexString:@"FF8698" alpha:1]];
    
    [view addSubview:buton];
    _tableView.tableFooterView = view;
    
}
#pragma mark ------------------ 提交信息 -------------------------
- (void)postInfo:(UIButton *)button {
 
    
    NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
    [stand setObject:@[dataDic] forKey:@"user_jiwangSDic"];
    [stand synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ---------------- tableView delegate ---------------


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *child = [dataDic objectForKey:@"children"];
    return child.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIndefier = @"cell";
    OSlickTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"OSlickTableViewCell" owner:self options:nil].lastObject;
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    NSArray *child = [dataDic objectForKey:@"children"];
    NSDictionary *dic = [child objectAtIndex:indexPath.row];
    cell.defaultValue = [NSString stringWithFormat:@"%@",[dic objectForKey:@"defaultValue"]];
    cell.headTitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"caption"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 55;
}

#pragma mark ---------------- cell 的 delegate ---------------
- (void)didUpdate:(NSString *)num atIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *children =[NSMutableArray arrayWithArray:[dataDic objectForKey:@"children"]];
    NSMutableDictionary *subDic = [[NSMutableDictionary alloc]initWithDictionary:[children objectAtIndex:indexPath.row]];
    if ([num isEqualToString:@"0"]) {
        
        

        

        [subDic setObject:@"1" forKey:@"defaultValue"];
      
    }else{
        
        [subDic setObject:@"0" forKey:@"defaultValue"];

    }
    
    
    
    [children replaceObjectAtIndex:indexPath.row withObject:subDic];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *theDate = [NSDate date];
    dateFormatter.dateFormat =@"YYYY-MM-dd";
    NSString *dataStr =  [dateFormatter stringFromDate:theDate];
    [dataDic setObject:children forKey:@"children"];
    [dataDic setObject:dataStr forKey:@"addTime"];
    [dataDic setObject:@"0" forKey:@"code"];

    [dataDic setObject:children forKey:@"children"];

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
