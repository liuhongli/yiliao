//
//  RegistViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/7.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistTableViewCell.h"

@interface RegistViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate> {
    
    NSArray *titleArray;
    NSInteger lastTag;
    UIView* backView;
    UIControl * control;
    UIPickerView * picker;
    UIDatePicker *datePicker;
    
        NSInteger youheight;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (weak, nonatomic) IBOutlet UITableView *myTabV;
@property(nonatomic,strong) UIActionSheet *m_actionSheet;
@end

@implementation RegistViewController
@synthesize m_actionSheet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    lastTag = 0;
    self.title = @"个人基本信息";
    titleArray = @[@"手机号码",@"姓名",@"出生年月",@"身高",@"末次月经"];
    self.tabV.tableFooterView = [[UIView alloc] init];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self cancle];
}
- (IBAction)clickButton:(UIButton *)sender {
    UITextField *mobTF = (UITextField *)[self.view viewWithTag:1000];
    UITextField *nameTF = (UITextField *)[self.view viewWithTag:1001];
    UITextField *birthTF = (UITextField *)[self.view viewWithTag:1002];
    UITextField *hightTF = (UITextField *)[self.view viewWithTag:1003];
    UITextField *scTF = (UITextField *)[self.view viewWithTag:1004];
    if (![NSString isValidateMobile:mobTF.text]) {
        [Alert showWithTitle:@"请输入正确的手机号"];
        return;
    }
    if (nameTF.text.length < 1 || birthTF.text.length < 1 || hightTF.text.length < 1 || scTF.text.length < 1) {
        [Alert showWithTitle:@"信息未填写完成，请填写完成后重试"];
        return;
    }
    NSDictionary *para = @{@"mobilePhone":mobTF.text,@"name":nameTF.text,@"birthdate":birthTF.text,@"height":hightTF.text,@"lastMenses":scTF.text};
    
    NSUserDefaults *defet = [NSUserDefaults standardUserDefaults];
    [defet setObject:para  forKey:@"USERINFO"];
    //将数据同步到本地的文件中
    [defet synchronize];

   [RBaseHttpTool postWithUrl:@"user/register" parameters:para sucess:^(id json) {
        

       
       if ([[json objectForKey:@"success"] floatValue]== 1) {
           NSUserDefaults *userDetaults = [NSUserDefaults standardUserDefaults];
           
           [userDetaults setBool:YES forKey:@"showGuide"];
           //将数据同步到本地的文件中
           [userDetaults synchronize];

           [Alert showWithTitle:@"注册成功"];
       }else{
           [Alert showWithTitle:[NSString stringWithFormat:@"%@",[json objectForKey:@"message"]]];
           
       }
       [self.navigationController popViewControllerAnimated:YES];

       
    } failur:^(NSError *error) {
        
        [Alert showWithTitle:[NSString stringWithFormat:@"%@",error.userInfo]];

        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return titleArray.count;
}

#pragma mark 解决虚拟键盘挡住UITextField的方法  UITextField Delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
        [textField resignFirstResponder];
    
    if (textField.tag  == 1000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入手机号" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成", nil];
        alert.alertViewStyle =    UIAlertViewStylePlainTextInput;
        alert.tag = 0;
        [alert show];
    }else if (textField.tag  == 1001) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入姓名" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成", nil];
        alert.alertViewStyle =    UIAlertViewStylePlainTextInput;
        alert.tag = 1;
        [alert show];
    }else if (textField.tag  == 1002) {
        [self age:2];
    
    }else if (textField.tag  == 1003) {
        
        [self age:3];
    }else {
        [self age:4];
    }

    
}

- (void)age:(NSInteger)tag{
    if (backView == nil || control == nil ||picker== nil || datePicker == nil) {
    
        backView = [[UIView alloc]init];
        
        
        backView.backgroundColor = [UIColor colorWithHexString:@"FF8698" alpha:1];
        
        
        UIWindow *window  = [UIApplication sharedApplication].windows.firstObject;
        [window addSubview:backView];
        [window bringSubviewToFront:backView];

        
        control = [[UIControl alloc] initWithFrame:self.view.window.bounds];
        control.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view.window insertSubview:control belowSubview:backView];

   
    

    
    [control addTarget:self action:@selector(maskViewAction:) forControlEvents:UIControlEventTouchUpInside];


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
    [sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        
            picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 216)];
            picker.delegate = self;
            picker.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            picker.dataSource = self;
            [backView addSubview:picker];
            //    backView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            picker.backgroundColor = [UIColor whiteColor];
            [picker selectRow:160 inComponent:0 animated:YES];
             youheight = 160;

            
            datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 216)];
            datePicker.backgroundColor = [UIColor whiteColor];
           [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];

            [datePicker setDatePickerMode:UIDatePickerModeDate];
            [backView addSubview:datePicker];
            
            
        
        
}
    backView.frame = CGRectMake(0,kScreenHeight- 216-44,kScreenWidth, 216+44);

    if (tag == 3) {
        picker.hidden = NO;
        datePicker.hidden = YES;
    }else {
        datePicker.hidden = NO;

        picker.hidden = YES;
    }
    control.hidden = NO;

    picker.tag = tag;
    datePicker.tag = tag;
    

}
//　　点击完成可以获取picker选中值

- (void)maskViewAction:(UIControl *)contrl {
    [self cancle];
}


-(void)sure{
    
    if (datePicker.tag == 3) {
        UITextField *textfield = (UITextField *)[self.view viewWithTag:datePicker.tag+1000];
        NSString *hightString = [NSString stringWithFormat:@"%ld",youheight];
        textfield.text = hightString;

    }else {
        UITextField *textfield = (UITextField *)[self.view viewWithTag:datePicker.tag+1000];
        // 将选择的日期格式化
        NSDate *date = datePicker.date;
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [fmt stringFromDate:date];

        textfield.text = dateStr;

    }
    [self cancle];
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



#pragma mark pickview delegate
//组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 250;
}

//初始化每个组件每一行数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string = [NSString stringWithFormat:@"%ld",row];
    return string;
}

//选中picker cell,save ArrayIndex
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    youheight = row;
    NSLog(@"选中%ld",row);

}

#pragma mark ------------------ alertView delegate ------------------


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UITextField *textfield = (UITextField *)[self.view viewWithTag:alertView.tag+1000];
    [textfield resignFirstResponder];
    if (buttonIndex == 1) {
        if (alertView.tag == 0) {
            UITextField *tf =[alertView textFieldAtIndex:0];
            textfield.text = tf.text;
        }else if (alertView.tag == 1) {
            UITextField *tf =[alertView textFieldAtIndex:0];
            textfield.text = tf.text;
        }

    
    
    }
}


#pragma mark ------------------ tableView ------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIndefier = @"cell";
    RegistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
    
    if (!cell) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"RegistTableViewCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameLab.text = titleArray[indexPath.row];
    cell.wTF.delegate = self;
    cell.wTF.tag = indexPath.row+1000;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
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
