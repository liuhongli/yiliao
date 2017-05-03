//
//  OneViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/3/31.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "OneViewController.h"
#import "RegistTableViewCell.h"
#import "OSIickViewController.h"
#import "JianceViewController.h"
#import "HabitViewController.h"

@interface OneViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSArray *titleArray;
    NSArray *imageSArray;
    NSArray *questionSArray;
    
    UIView *m_actionV;
    UIView *j_actionV;
    NSDictionary *dataDic;
    UIDatePicker *datePicker;
    UIPickerView *pickerView;
    
    NSString *dateStr;//日期
    NSInteger yunzSel;//孕周
    NSInteger yunqSel;//孕周
    
    NSInteger stRow;//1。孕周 2.孕早期
    
    NSArray *yunArray;

    NSDictionary *usinfoDic;


}
@property (weak, nonatomic) IBOutlet UITableView *myTabV;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"常规调查";
    NSUserDefaults *userDetaults = [NSUserDefaults standardUserDefaults];
    
    usinfoDic = [userDetaults objectForKey:@"USERINFO"];

    questionSArray = @[@"检测日期",@"孕周",@"孕期"];
    yunzSel = 0;
    yunqSel = 0;
    titleArray = @[@"主诉与病症",@"既往发现病史",@"实验室检测",@"饮食习惯",@"生活习惯"];
    imageSArray = @[@"首页_常规调查icon_dj",@"首页_运动调查icon_dj",@"首页_膳食调查icon_dj",@"首页_个人信息icon_dj",@"首页_分析结果icon_dj"];
    
    yunArray = @[@"孕早期",@"孕中期",@"孕晚期"];
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
        if (indexPath.row == 0) {
            cell.wTF.enabled = YES;

         cell.wTF.text = [NSString dateString:[usinfoDic objectForKey:@"lastUpdateTime"]];
        }else{
            cell.wTF.enabled = NO;

            
            NSString *lastS = [usinfoDic objectForKey:@"lastUpdateTime"];
            NSString *cretS = [usinfoDic objectForKey:@"lastMenses"];
            NSString * timeStampString = [NSString stringWithFormat:@"%@",lastS];
            NSTimeInterval _interval=[timeStampString doubleValue] /1000;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
            
            NSString * timeStampString2 = [NSString stringWithFormat:@"%@",cretS];
            NSTimeInterval _interval2=[timeStampString2 doubleValue] /1000;
            NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
            NSTimeInterval time = [date timeIntervalSinceDate:date2];
            
            //开始时间和结束时间的中间相差的时间
            int days;
            days = ((int)time)/(3600*24);  //一天是24小时*3600秒
            if (indexPath.row == 1){
            
            cell.wTF.text = [NSString stringWithFormat:@"%ld周",days/7];
            }else{
                NSInteger num = days/7;
                if (num <14) {
                    cell.wTF.text = @"孕早期";
                }else if (num < 28){
                    cell.wTF.text = @"孕中期";

                }else{
                    cell.wTF.text = @"孕晚期";

                }
            }
        }
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
            cell.textLabel.font = [UIFont fontWithName:@"PingFangSC" size:16];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.alpha = 0.7;

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
                titleLa.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
                titleLa.textColor = [UIColor colorWithString:@"4A4A4A"];
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
            jianceVC.mutilSetlecd = 2;
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
        
        j_actionV.hidden = YES;

        [self seleTime];
    }else if (textField.tag == 1001){
        stRow = 1;
        m_actionV.hidden = YES;

        [pickerView reloadAllComponents];
        [self seleJob];
        
    }else if (textField.tag == 1002){
        stRow = 2;
        m_actionV.hidden = YES;

        [pickerView reloadAllComponents];
        [self seleJob];

    }
    
    

    return NO;
}



#pragma mark -------------------选择时间-------------------
- (void)seleTime {
    if (m_actionV == nil) {
        
        m_actionV = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-260,kScreenWidth, 260)];
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
        [m_actionV addSubview:pickerDateToolbar];
        
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
        
        [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        // 设置时区
        [datePicker setTimeZone:[NSTimeZone localTimeZone]];
        
        // 设置当前显示时间
        [datePicker setDate:[NSDate date] animated:YES];
        [datePicker setMinimumDate:[NSDate date]];
        // 设置UIDatePicker的显示模式
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        // 当值发生改变的时候调用的方法
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [m_actionV addSubview:datePicker];
        
        [self.view addSubview:m_actionV];
    }
    
    m_actionV.hidden = NO;
    
    
}
-(void)toolBarCanelClick{
    
    m_actionV.hidden = YES;
    
}
-(void)toolBarDoneClick{
    
    m_actionV.hidden = YES;
    
    NSDate *theDate = datePicker.date;
    
    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"YYYY-MM-dd";
    
    
    UITextField *textF = [self.view viewWithTag:1000];
    textF.text = [dateFormatter stringFromDate:theDate];
    NSDate *date = [NSDate date];
    NSTimeInterval time = [theDate timeIntervalSinceDate:date];
    int days;
    days = ((int)time)/(3600*24);
    if (days < 0) {
        [Alert showWithTitle:@"检测日期不能为过去时间"];
        return;
    }
    NSMutableDictionary *muDic = [usinfoDic mutableCopy];
    NSUserDefaults *userDetaults = [NSUserDefaults standardUserDefaults];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[theDate timeIntervalSince1970]*1000];

    [muDic setObject:timeSp forKey:@"lastUpdateTime"];
    
    [userDetaults setObject:muDic forKey:@"USERINFO"];
    
    [userDetaults synchronize];
    usinfoDic = muDic;
    [_myTabV reloadData];
}

- (void)datePickerValueChanged:(UIDatePicker *)datePickers {
    NSDate *theDate = datePickers.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"YYYY-MM-dd";
    
    //    UITextField *textF = [self.view viewWithTag:1000];
    //    textF.text = [dateFormatter stringFromDate:theDate];
    dateStr = [dateFormatter stringFromDate:theDate];
}

#pragma mark -------------------选择职业-------------------
- (void)seleJob {
    if (j_actionV == nil) {
        
        j_actionV = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-260,kScreenWidth, 260)];
        UIToolbar   *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        
        [pickerDateToolbar setBackgroundImage:[self createImageWithColor:BaseColor] forToolbarPosition:0 barMetrics:0];
        pickerDateToolbar.tintColor = BaseColor;
        [pickerDateToolbar sizeToFit];
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        //
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(toolBaCanelClick)];
        
        [cancelBtn setTintColor:[UIColor whiteColor]];
        [barItems addObject:cancelBtn];
        //
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        //
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(toolBaDoneClick)];
        
        [doneBtn setTintColor:[UIColor whiteColor]];
        [barItems addObject:doneBtn];
        
        [pickerDateToolbar setItems:barItems animated:YES];
        [j_actionV addSubview:pickerDateToolbar];
        
        
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
        pickerView.showsSelectionIndicator = YES;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.backgroundColor = [UIColor whiteColor];
        
        
        [j_actionV addSubview:pickerView];
        
        [self.view addSubview:j_actionV];
    }
    
    if (stRow == 1) {
        
        [pickerView selectRow:yunzSel inComponent:0 animated:YES];

    }else{
        
        [pickerView selectRow:yunqSel inComponent:0 animated:YES];

    }


    j_actionV.hidden = NO;
    
}

-(void)toolBaCanelClick{
    
    j_actionV.hidden = YES;
    
}
-(void)toolBaDoneClick{
    if (stRow == 1) {
        UITextField *textF = [self.view viewWithTag:1001];
        
        

        textF.text = [NSString stringWithFormat:@"%ld周",yunzSel];;

    }else{
        
        UITextField *textF = [self.view viewWithTag:1002];

        textF.text = yunArray[yunqSel];
    }
    
    j_actionV.hidden = YES;
    
    
}

//组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (stRow == 1) {
        return 50;
    }
    return yunArray.count;
}

//初始化每个组件每一行数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *captionS;
    if (stRow == 1) {
        captionS = [NSString stringWithFormat:@"%ld周",row];
    }else{
        
        captionS = yunArray[row];
    }
    return captionS;
}

//选中picker cell,save ArrayIndex
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (stRow == 1) {
        yunzSel = row;
    }else{
        yunqSel =  row;
    }
//    NSArray *array = [dataDic objectForKey:@"children"];
//    NSString *captionS = [array[jobSel] objectForKey:@"caption"];
    
    //    UITextField *textF = [self.view viewWithTag:1001];
    //    textF.text = captionS;
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
