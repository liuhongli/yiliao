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

@interface TwoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSArray *titleArray;
    NSArray *imageSArray;
    NSArray *questionSArray;
    UIView *m_actionV;
    UIView *j_actionV;
    NSDictionary *dataDic;
    UIDatePicker *datePicker;
    
    NSString *dateStr;//日期
    NSString *jobStr;//职业
    NSInteger dateSel;//默认日期
    NSInteger jobSel;//默认职业
    
    
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
    
    jobSel = 0;
    dateSel = 0;
    [self initTableView];
    
    NSArray *result = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] objectForKey:@"result"];
    dataDic = result[15];

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
        cell.wTF.tag = 1000+ indexPath.row;
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
    if (dateStr == nil) {
        
        [Alert showWithTitle:@"请选择日期"];
        return;
    }
    if (jobStr == nil) {
        
        [Alert showWithTitle:@"请选择职业"];
        return;
    }

    ThreeDetailController *detailVC = [[ThreeDetailController alloc] init];
    detailVC.dateStr = dateStr;
    detailVC.job = jobStr;
    switch (button.tag) {
        case 10:
        {
            detailVC.comeType = 0;
        }
            break;
            
        case 11:
        {

            detailVC.comeType = 1;
        }
            break;
            
        default:{
            
            detailVC.comeType = 2;
        }
            break;
    }
    
        [self.navigationController pushViewController:detailVC animated:YES];
    
}
#pragma mark -------------------textField delegat-------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 1000) {
        j_actionV.hidden = YES;

        [self seleTime];
        
    }else if (textField.tag == 1001){
        m_actionV.hidden = YES;
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
        // 设置显示最大时间（此处为当前时间）
        [datePicker setMaximumDate:[NSDate date]];
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
    dateFormatter.dateFormat = @"YYYY-MM-dd ";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);

    
    
    UITextField *textF = [self.view viewWithTag:1000];
    textF.text = [dateFormatter stringFromDate:theDate];
    
    dateStr = [dateFormatter stringFromDate:theDate];


}

- (void)datePickerValueChanged:(UIDatePicker *)datePickers {
    NSDate *theDate = datePickers.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd ";

//    UITextField *textF = [self.view viewWithTag:1000];
//    textF.text = [dateFormatter stringFromDate:theDate];
    dateStr = [dateFormatter stringFromDate:theDate];
    dateSel = 1;
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
        
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
        pickerView.showsSelectionIndicator = YES;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.backgroundColor = [UIColor whiteColor];

        [pickerView selectRow:0 inComponent:0 animated:YES];
        
        [j_actionV addSubview:pickerView];
        
        [self.view addSubview:j_actionV];
    }
    
    j_actionV.hidden = NO;

}

-(void)toolBaCanelClick{
    
    j_actionV.hidden = YES;
    
}
-(void)toolBaDoneClick{
    
    NSArray *array = [dataDic objectForKey:@"children"];
    NSString *captionS = [array[jobSel] objectForKey:@"caption"];
    
    UITextField *textF = [self.view viewWithTag:1001];
    textF.text = captionS;

    j_actionV.hidden = YES;
    jobStr  = captionS;

    
}

//组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *array = [dataDic objectForKey:@"children"];
    return array.count;
}

//初始化每个组件每一行数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *array = [dataDic objectForKey:@"children"];
    NSString *captionS = [array[row] objectForKey:@"caption"];
    return captionS;
}

//选中picker cell,save ArrayIndex
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    jobSel =  row;
    NSArray *array = [dataDic objectForKey:@"children"];
    NSString *captionS = [array[jobSel] objectForKey:@"caption"];

//    UITextField *textF = [self.view viewWithTag:1001];
//    textF.text = captionS;
    jobStr  = captionS;
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
