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
    NSMutableDictionary *mymess;
}

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    mymess = [NSMutableDictionary dictionary];

    titleArray = @[@[@"手机号码",@"姓名",@"出生年月",@"身高",@"末次月经"],@[@"血型",@"民族",@"职业",@"E-Mail",@"文化程度"]];
    [self initTableView];
    
    UIView *rightview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savebtn.frame = CGRectMake(40, 0, 40, 40);
    [savebtn setTitle:@"保存" forState:UIControlStateNormal];
    [savebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [savebtn addTarget:self action:@selector(savemess) forControlEvents:UIControlEventTouchUpInside];
    [rightview addSubview:savebtn];
    
    UIBarButtonItem *buttonItem  = [[UIBarButtonItem alloc] initWithCustomView:rightview];
    self.navigationItem.rightBarButtonItem  = buttonItem;

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
    if ([mymess objectForKey:[NSString stringWithFormat:@"%ld", indexPath.section*10+indexPath.row+500]] ==nil) {
        cell.subLab.text = @"未填写";
    }else {
        cell.subLab.text = [mymess objectForKey:[NSString stringWithFormat:@"%ld", indexPath.section*10+indexPath.row+500]];
        cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
    }
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"编辑" message:@"请输入信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", @"取消", nil];
    alertView.tag = 500+indexPath.section*10+indexPath.row;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UITextField * accoutNameField = [alertView textFieldAtIndex:0];
        NSLog(@"%@",accoutNameField.text);
        [mymess setObject:accoutNameField.text forKey:[NSString stringWithFormat:@"%ld" ,(long)alertView.tag]];
        [tableV reloadData];
    }
}

//保存上传个人信息
- (void)savemess{
//http://test.kpjkgl.com:8090/pregnant/user/edit?mobilePhone=11111111&name=吴江&birthdate=1990-01-01&height=60&lastMenses=2016-01-01&bloodType=O&nationality=汉& profession=IT&email=161231233@qq.com&education=大学
    NSDictionary *para = @{@"mobilePhone":@"18911475023",@"name":@"1234",@"birthdate":@"1990-01-01",@"height":@"60",@"lastMenses":@"2016-01-01",@"bloodType":@"O",@"nationality":@"汉",@"profession":@"IT",@"email":@"161231233qq.com",@"education":@"大学"};
    
    [RBaseHttpTool postWithUrl:@"user/edit" parameters:para sucess:^(id json){
        
        if ([[json objectForKey:@"success"] floatValue]== 1) {
            NSUserDefaults *userDetaults = [NSUserDefaults standardUserDefaults];
            
            [userDetaults setBool:YES forKey:@"showGuide"];
            //将数据同步到本地的文件中
            [userDetaults synchronize];
            
            [Alert showWithTitle:@"保存成功"];
        }else{
            [Alert showWithTitle:[NSString stringWithFormat:@"%@",[json objectForKey:@"message"]]];
            
        }
        
        
    } failur:^(NSError *error) {
        
        [Alert showWithTitle:[NSString stringWithFormat:@"%@",error.userInfo]];
        
        
    }];

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
