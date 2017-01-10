//
//  ThreeDetailController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/5/3.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "ThreeDetailController.h"
#import "ToLunchTableViewCell.h"
#import "EatTableViewCell.h"
#import "FoodViewController.h"

@interface ThreeDetailController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UIView *j_actionV;
    NSDictionary *dataDic;

}

@end

@implementation ThreeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *result = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] objectForKey:@"result"];
    switch (_comeType) {
        case 0: {
            self.title = @"睡眠时间调查";

            dataDic = result[16];

       
        }
           break;
        case 1: {
            
            self.title = @"职业调查";
  
        }
            break;

            
        default: {
            
            self.title = @"运动调查";
            dataDic = result[18];

        }
            break;
    }
    
}
#pragma mark -------------------tableView delegate-------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return 22;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *cellIndefier = @"cell";
        ToLunchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        
        if (!cell) {
            
            [tableView registerNib:[UINib nibWithNibName:@"ToLunchTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndefier];
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        }
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        
        switch (_comeType) {
            case 0: {
                cell.titleLab.text = @"睡眠时间";
                
                
            }
                break;
            case 1: {
                
                cell.titleLab.text = @"工作时长";
                
            }
                break;
                
                
            default: {
                
                cell.titleLab.text = @"运动时长";
                
            }
                break;
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        

    }else{
        
        static NSString *cellIndefier = @"cell1";
        EatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        
        if (!cell) {

            [tableView registerNib:[UINib nibWithNibName:@"EatTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndefier];

            cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
            
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self seleDataSource];
    };
    
    
}
#pragma mark -------------------选择数据-------------------
- (void)seleDataSource {
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
        
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 216)];
        pickerView.showsSelectionIndicator = YES;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.backgroundColor = [UIColor whiteColor];
        [pickerView selectRow:1 inComponent:0 animated:YES];
        
        [j_actionV addSubview:pickerView];
        
        [self.view addSubview:j_actionV];
    }
    
    j_actionV.hidden = NO;
    
}

-(void)toolBarCanelClick{
    
    j_actionV.hidden = YES;
    
}
-(void)toolBarDoneClick{
    
    j_actionV.hidden = YES;
    
    
}


//组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_comeType == 2) {
        return 2;
    }
    return 1;
}

//每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (_comeType) {
        case 0: {
            NSArray *array = [dataDic objectForKey:@"children"];
            return array.count;
            
        }
            break;
        case 1: {
            
            return 24;
            
        }
            break;
            
            
        default: {
            
            if (component == 0) {
                NSArray *array = [dataDic objectForKey:@"children"];
                return array.count;

            }else{
                return 24;
            }
        }
            break;
    }

    return 0;
}

//初始化每个组件每一行数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *captionS;
    if (_comeType == 0) {
        
        NSArray *array = [dataDic objectForKey:@"children"];
        captionS = [array[row] objectForKey:@"caption"];

        
    }else if (_comeType == 1){
        
        captionS = [NSString stringWithFormat:@"%ld小时",row +1];
    }else if (_comeType == 2){
        
        if (component == 0) {
            
            NSArray *array = [dataDic objectForKey:@"children"];
            captionS = [array[row] objectForKey:@"caption"];

        }else if (component == 1){
            
            captionS = [NSString stringWithFormat:@"%ld小时",row +1];

        }
    }

    return captionS;
}

//选中picker cell,save ArrayIndex
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

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


@end
