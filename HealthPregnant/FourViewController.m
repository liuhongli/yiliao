//
//  FourViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/2.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "FourViewController.h"
#import "ToLunchTableViewCell.h"
#import "AppDelegate.h"

@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UITableView *tableV;
    NSArray *titleArray;
    NSMutableDictionary *mymess;
    UIDatePicker *myDatePicker;
    
    UIView* backView;
    
    UIControl * control;
    UIPickerView * picker;
    UIDatePicker *datePicker;
    
    NSInteger youheight;

 UIView *j_actionV;
    
    NSArray *xueArray;
    NSArray *edArray;
    
    NSInteger rowNameSele;
    NSInteger rowIndeSele;

}

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    rowIndeSele = 0;
    xueArray  = @[@"A",@"B",@"o",@"AB"];
    edArray = @[@"小学",@"初中",@"高中",@"专科",@"本科",@"硕士",@"博士"];
    NSUserDefaults *userDetaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userdic = [userDetaults objectForKey:@"USERINFO"];
    
    
    mymess = [NSMutableDictionary dictionaryWithDictionary:userdic];
    
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
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:{
             
                if ([NSString stringWithFormat:@"%@",[mymess objectForKey:@"mobilePhone"]].length < 1) {
                    cell.subLab.text = @"未填写";
                }else {
                    cell.subLab.text = [NSString stringWithFormat:@"%@",[mymess objectForKey:@"mobilePhone"]];
                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }

           
            }
                break;
            case 1:{
                
                if ([NSString stringWithFormat:@"%@",[mymess objectForKey:@"name"]].length < 1) {
                    cell.subLab.text = @"未填写";
                }else {
                    cell.subLab.text = [NSString stringWithFormat:@"%@",[mymess objectForKey:@"name"]] ;
                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }
 
            }
                break;
            case 2:{
               
                if ([NSString dateString:[mymess objectForKey:@"birthDate"]].length < 1) {
                    cell.subLab.text = @"未填写";
                }else {
                    cell.subLab.text = [NSString dateString:[mymess objectForKey:@"birthDate"]];
                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }

                
            }
                break;
            case 3:{
              
                if ([NSString stringWithFormat:@"%@",[mymess objectForKey:@"height"]].length < 1) {
                    cell.subLab.text = @"未填写";
                }else {
                    cell.subLab.text = [NSString stringWithFormat:@"%@cm",[mymess objectForKey:@"height"]] ;
                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }

                
            }
                break;
            case 4:{
             
                if ([NSString stringWithFormat:@"%@",[mymess objectForKey:@"lastMenses"]].length < 1) {
                    cell.subLab.text = @"未填写";
                }else {
                    cell.subLab.text = [NSString stringWithFormat:@"%@",[NSString dateString:[mymess objectForKey:@"lastMenses"]]];
                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }

                
            }
                break;

                
            default:
                break;
        }
        
    }else if (indexPath.section == 1){
        
        
        switch (indexPath.row) {
           
            case 0:{
                
                if ([NSString stringWithFormat:@"%@",[mymess objectForKey:@"bloodType"]].length <1) {
                    cell.subLab.text = @"未填写";
                }else {
                    if ([[mymess objectForKey:@"bloodType"] integerValue] == 1) {
                        
                        cell.subLab.text = @"A型";
                    }
                    
                    if ([[mymess objectForKey:@"bloodType"] integerValue] == 2) {
                        
                        cell.subLab.text = @"B型";
                    }

                    if ([[mymess objectForKey:@"bloodType"] integerValue] == 3) {
                        
                        cell.subLab.text = @"o型";
                    }

                    if ([[mymess objectForKey:@"bloodType"] integerValue] == 4) {
                        
                        cell.subLab.text = @"AB型";
                    }

                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }
                
            }
                break;
            case 1:{
                
                if ([NSString stringWithFormat:@"%@",[mymess objectForKey:@"nationality"]].length < 1) {
                    cell.subLab.text = @"未填写";
                }else {
                    cell.subLab.text = [NSString stringWithFormat:@"%@",[mymess objectForKey:@"nationality"]];
                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }
                
                
            }
                break;
            case 2:{
                
                if ([NSString stringWithFormat:@"%@",[mymess objectForKey:@"profession"]].length <1) {
                    cell.subLab.text = @"未填写";
                }else {
                    cell.subLab.text = [NSString stringWithFormat:@"%@",[mymess objectForKey:@"profession"]];
                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }
                
                
            }
                break;
            case 3:{
                
                if ([NSString stringWithFormat:@"%@",[mymess objectForKey:@"email"]].length < 1) {
                    cell.subLab.text = @"未填写";
                }else {
                    cell.subLab.text = [NSString stringWithFormat:@"%@",[mymess objectForKey:@"email"]];
                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }
                
                
            }
                break;
                
            case 4:{
                
                if ([NSString stringWithFormat:@"%@", [mymess objectForKey:@"education"]].length < 1) {
                    cell.subLab.text = @"未填写";
                }else {
                    cell.subLab.text = [NSString stringWithFormat:@"%@", [mymess objectForKey:@"education"]];
                    cell.subLab.textColor =[UIColor colorWithHexString:@"FF8698" alpha:1];
                }
                
                
            }
                break;

                
            default:
                break;
        }
        
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
    if (indexPath.section == 0) {
        if ( indexPath.row ==2||indexPath.row == 4) {
            control.hidden =NO;
            backView.frame = CGRectMake(0,kScreenHeight- 216-44,kScreenWidth, 216+44);
            myDatePicker.tag = indexPath.section*10+indexPath.row+500;
            if (myDatePicker == nil) {
                
                
                
                backView = [[UIView alloc]init];
                
                backView.frame = CGRectMake(0,kScreenHeight- 216-44,kScreenWidth, 216+44);

                backView.backgroundColor = [UIColor colorWithHexString:@"FF8698" alpha:1];
                
                
                UIWindow *window  = [UIApplication sharedApplication].windows.firstObject;
                [window addSubview:backView];
                [window bringSubviewToFront:backView];
                
                
                control = [[UIControl alloc] initWithFrame:self.view.window.bounds];
                control.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                [self.view.window insertSubview:control belowSubview:backView];
                
                
                
                
                
                [control addTarget:self action:@selector(maskViewAction:) forControlEvents:UIControlEventTouchUpInside];

                
                myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 216)];
                myDatePicker.datePickerMode = UIDatePickerModeDate;
                myDatePicker.tag = indexPath.section*10+indexPath.row+500;
                myDatePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];

//                myDatePicker.center = self.view.center;
                [backView addSubview:myDatePicker];
                
                UIButton * cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
                [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
                [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
                [backView addSubview:cancelButton];
                [cancelButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton * sureButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 0, 60, 44)];
                [sureButton setTitle:@"确定" forState:UIControlStateNormal];
                sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
                [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [backView addSubview:sureButton];
                [sureButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];

                
            }
            
        }else if(indexPath.row == 0 || indexPath.row == 1) {
            if ([mymess objectForKey:@"500"]!= nil ||[mymess objectForKey:@"501"]!= nil){
                
            }
        
        }else if(indexPath.row == 3) {
            
            [self seleDataSource:1];
        }else {
            
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"编辑" message:@"请输入信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", @"取消", nil];
            alertView.tag = 500+indexPath.section*10+indexPath.row;
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView show];}
        
    }else {
        
     if(indexPath.row == 0 ) {
         [self seleDataSource:2];

        
     }else  if(indexPath.row == 4) {
       
         [self seleDataSource:3];
         
         
     }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"编辑" message:@"请输入信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", @"取消", nil];
        alertView.tag = 500+indexPath.section*10+indexPath.row;
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView show];

     }
    
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        switch (alertView.tag) {
            case 503:{
                
                UITextField * accoutNameField = [alertView textFieldAtIndex:0];
                
                [mymess setObject:accoutNameField.text forKey:@"height"];
                
                
            }
                break;

            case 510:{
              
                UITextField * accoutNameField = [alertView textFieldAtIndex:0];
                
                [mymess setObject:accoutNameField.text forKey:@"bloodType"];

        
            }
                break;
            case 511:{
                
                UITextField * accoutNameField = [alertView textFieldAtIndex:0];
                
                [mymess setObject:accoutNameField.text forKey:@"nationality"];

                
            }
                break;
            case 512:{
                
                UITextField * accoutNameField = [alertView textFieldAtIndex:0];
                
                [mymess setObject:accoutNameField.text forKey:@"profession"];

                
            }
                break;
            case 513:{
               
                UITextField * accoutNameField = [alertView textFieldAtIndex:0];
                
                [mymess setObject:accoutNameField.text forKey:@"email"];

                
            }
                break;
            case 514:{
                
                UITextField * accoutNameField = [alertView textFieldAtIndex:0];
                
                [mymess setObject:accoutNameField.text forKey:@"education"];

                
            }
                break;
                
            default:
                break;
        }
        [tableV reloadData];
    }
}

//保存上传个人信息
- (void)savemess{
//http://test.kpjkgl.com:8090/pregnant/user/edit?mobilePhone=11111111&name=吴江&birthdate=1990-01-01&height=60&lastMenses=2016-01-01&bloodType=O&nationality=汉& profession=IT&email=161231233@qq.com&education=大学
    
    if (![mymess objectForKey:@"mobilePhone"] || ![mymess objectForKey:@"name"] ||![mymess objectForKey:@"birthDate"]||![mymess objectForKey:@"height"]||![mymess objectForKey:@"lastMenses"]||![mymess objectForKey:@"bloodType"]||![mymess objectForKey:@"nationality"]||![mymess objectForKey:@"profession"]||![mymess objectForKey:@"email"]||![mymess objectForKey:@"education"] ) {
        [Alert showWithTitle:@"请完善全部信息"];
        return;
    }
    
    NSDictionary *para = @{@"mobilePhone":[mymess objectForKey:@"mobilePhone"],@"name":[mymess objectForKey:@"name"],@"birthDate": [NSString dateString:[mymess objectForKey:@"birthDate"]],@"height":[mymess objectForKey:@"height"],@"lastMenses": [NSString dateString:[mymess objectForKey:@"lastMenses"]],@"bloodType":[mymess objectForKey:@"bloodType"],@"nationality":[mymess objectForKey:@"nationality"],@"profession":[mymess objectForKey:@"profession"],@"email":[mymess objectForKey:@"email"],@"education":[mymess objectForKey:@"education"]};
    [self showHUD:@"数据提交中..."];

    [RBaseHttpTool postWithUrl:@"user/edit" parameters:para sucess:^(id json){
        [super hideHUD];
   
        if ([[json objectForKey:@"success"] floatValue]== 1) {
            NSUserDefaults *userDetaults = [NSUserDefaults standardUserDefaults];
            
//            [userDetaults setBool:YES forKey:@"showGuide"];
            
            [userDetaults setObject:mymess forKey:@"USERINFO"];
            //将数据同步到本地的文件中
            [userDetaults synchronize];
            [tableV reloadData];
            [Alert showWithTitle:@"保存成功"];
        }else{
            [Alert showWithTitle:[NSString stringWithFormat:@"%@",[json objectForKey:@"message"]]];
            
        }
        
        
    } failur:^(NSError *error) {
        [super hideHUD];
        [Alert showWithTitle:[NSString stringWithFormat:@"%@",error.userInfo]];
        
        
    }];

}

- (void)maskViewAction:(UIControl *)contrl {
    [self cancle];
}


-(void)sure:(UIButton *)index{
    

        // 将选择的日期格式化
    NSDate *date = myDatePicker.date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:date];
    switch (myDatePicker.tag) {
        case 502:
        {
            [mymess setObject:dateStr forKey:@"birthDate"];
 
        }
            break;
        case 504:
        {
            [mymess setObject:dateStr forKey:@"lastMenses"];

        }
            break;

            
        default:
            break;
    }
    
    [self cancle];
    
    [tableV reloadData];

}

-(void)cancle {
    
    control.hidden =YES;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    [UIView animateWithDuration:0.5 animations:^{
        backView.frame = CGRectMake(0, rect.size.height, self.view.frame.size.width, 216+44);
    } completion:^(BOOL finished) {
        // [self.view removeFromSuperview];
    }];
}


#pragma mark -------------------选择数据-------------------
- (void)seleDataSource:(NSInteger)indexTag {
    UIPickerView *pickerView;
    if (j_actionV == nil) {
        
        j_actionV = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-260,kScreenWidth, 260)];
        UIToolbar   *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        
        [pickerDateToolbar setBackgroundImage:[self createImageWithColor:BaseColor] forToolbarPosition:0 barMetrics:0];
        pickerDateToolbar.tintColor = BaseColor;
        [pickerDateToolbar sizeToFit];
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        //
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(toolBarCanelClick)];
        
        [cancelBtn setTintColor:[UIColor whiteColor]];
        [barItems addObject:cancelBtn];
        //
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        //
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(toolBarDoneClick)];
        
        [doneBtn setTintColor:[UIColor whiteColor]];
        [barItems addObject:doneBtn];
        
        [pickerDateToolbar setItems:barItems animated:YES];
        [j_actionV addSubview:pickerDateToolbar];
        
        
        
        [self.view addSubview:j_actionV];
    }
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    [pickerView selectRow:0 inComponent:0 animated:YES];
    
    [j_actionV addSubview:pickerView];

    pickerView.tag = indexTag;
    [pickerView reloadAllComponents];
    j_actionV.hidden = NO;
    
}

-(void)toolBarCanelClick{
    
    j_actionV.hidden = YES;
    
}
-(void)toolBarDoneClick{
    //待修改
    j_actionV.hidden = YES;
    
    [self seleRow:rowIndeSele component:0];
}


//组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (pickerView.tag == 1) {
        return 120;
    }
    
    if (pickerView.tag == 2) {
        return xueArray.count;
    }

    if (pickerView.tag == 3) {
        return edArray.count;
    }

    return 0;
}

//初始化每个组件每一行数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *captionS;
    if (pickerView.tag == 1) {
        
        captionS = [NSString stringWithFormat:@"%ld",150+row];
    }
    
    if (pickerView.tag == 2) {
        captionS = [NSString stringWithFormat:@"%@",xueArray[row]];
    }
    
    if (pickerView.tag == 3) {
        captionS = [NSString stringWithFormat:@"%@",edArray[row]];
    }

    return captionS;
}

//选中picker cell,save ArrayIndex
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    rowIndeSele = row;
    rowNameSele = pickerView.tag;


}


- (void)seleRow:(NSInteger)row component:(NSInteger)component{
    
    NSString *str;
    if (rowNameSele == 1) {
        str = [NSString stringWithFormat:@"%ld",150+rowIndeSele];
        [mymess setObject:str forKey:@"height"];

    }
    
    if (rowNameSele == 2) {
        str = [NSString stringWithFormat:@"%ld",rowIndeSele];

        [mymess setObject:str forKey:@"bloodType"];

    }

    if (rowNameSele == 3) {
        str = [NSString stringWithFormat:@"%@",edArray[rowIndeSele]];

        [mymess setObject:str forKey:@"education"];
    }
    [tableV reloadData];
    
}

//替换text居中
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
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
