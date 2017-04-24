//
//  JianceViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/12.
//  Copyright (c) 2016年 honely. All rights reserved.
//

#import "JianceViewController.h"
#import "RegistTableViewCell.h"
#import "TZImagePickerController.h"
#import "UIImageView+WebCache.h"
#import "MKPAlertView.h"
#import "SDWebImageManager.h"
#define myWithd 90
#define myheight 90
#define myDistance  20 //间距


@interface JianceViewController ()<UITableViewDataSource,UITableViewDelegate,TZImagePickerControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    
    NSArray *titleArray;
    NSArray *imageSArray;
    NSArray *questionSArray;
    UIImageView *SIMAGE;
    
    NSInteger seleImage;//b超 血常规 尿常规
    NSMutableDictionary *imageDic;//图片存储
    UIView *j_actionV;//宫高选择
    NSMutableDictionary *dataDic;//数据

    NSInteger xueSel;//宫高选择
}
@property (retain, nonatomic)UITableView *myTabV;


@end

@implementation JianceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实验室检测";
    questionSArray = @[@"血压",@"宫高"];
    titleArray = @[@"B超",@"血常规",@"尿常规"];
    imageSArray = @[@"首页_常规调查icon_dj",@"首页_运动调查icon_dj",@"首页_膳食调查icon_dj"];
    imageDic = [NSMutableDictionary dictionary];
    xueSel = 0;
    seleImage = 1000;
    NSArray *result = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ALLData"] objectForKey:@"result"];
    dataDic = [[NSMutableDictionary alloc] initWithDictionary:result[6]];

    UIImage *image0 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"seleImage0"];
    if (image0) {
        [imageDic setObject:image0 forKey:@"1000"];
    }
    UIImage *image1 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"seleImage1"];
    if (image1) {
        [imageDic setObject:image1 forKey:@"1001"];
    }

    UIImage *image2 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"seleImage2"];
    if (image2) {
        [imageDic setObject:image2 forKey:@"1002"];
    }

    [self initTableView];
    
    
    
}

- (void)initTableView {

    _myTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _myTabV.delegate = self;
    _myTabV.dataSource = self;
    
    
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,100)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, kScreenWidth-40, 40)];
    button.titleLabel.textColor= [UIColor whiteColor];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"界面底部大按钮_ct"] forState:UIControlStateNormal];
    [footview addSubview:button];
    
    _myTabV.tableFooterView = footview;
    [self.view addSubview:_myTabV];
    
}
- (void)saveInfo {

    if (imageDic.allKeys.count < 3) {
        [Alert showWithTitle:@"请选择B超，血常规，尿常规图片"];

        return;
    }
  /*  NSDictionary *para1 = @{@"generalSurveyList":@[@{@"field":@{@"FundalHeight":@"23",@"HighBloodPressure":@"98",@"LowBloodPressure":@"56"},@"globalRecordNr":@"18911475023",@"inspectionOrder":@"1",@"recordTime":@"2016-11-22",@"sign":@"1",@"tableName":@"PhysiqueCheckRecord"}],@"globalRecordNr":@"18911475023",@"recordTime":@"2016-11-22"};
  
      NSDictionary *para =   @{@"field":@{@"FundalHeight":@"49",@"HighBloodPressure":@"1 ",@"LowBloodPressure":@"3"},@"globalRecordNr":@"18911475023",@"inspectionOrder":@"1",@"recordTime":@"2017-4-19",@"sign":@"1",@"tableName":@"PhysiqueCheckRecord"};
    
    [RBaseHttpTool postWithUrl:@"data/uploadImg" parameters:para image:[UIImage imageNamed:@"icon120"] sucess:^(id json) {
        
    } failur:^(NSError *error) {
        
    }];*/
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    
    [defaut setObject:@[dataDic] forKey:@"user_shiyanSDic"];
    [defaut synchronize];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return questionSArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *cellIndefier = @"cell";
        RegistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
        
        if (!cell) {
            
            cell = [[NSBundle mainBundle] loadNibNamed:@"RegistTableViewCell" owner:self options:nil].lastObject;
        }
        cell.nameLab.text = questionSArray[indexPath.row];
        cell.wTF.tag = 800 + indexPath.row;
        cell.wTF.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"xueya"];
            if (str.length > 0) {
                cell.wTF.text = str;
            }
        }else{
            
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"gongGao"];
            if (str.length > 0) {
                cell.wTF.text = str;
            }

        }
        
        return cell;
    }
    else {
            static NSString *cellIndetifer = @"cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifer];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifer];
            }
        
        for (int i = 0; i < 3; i ++) {
            int row = i/3;
            int clow = i %3;
            NSLog(@"%d **** %d",row,clow);
            //创建按钮
            UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(kScreenWidth/2- (myWithd +myDistance)*titleArray.count/2+myDistance/2+(myWithd + myDistance)*i, 10, myWithd, myheight)];
            
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            //点击事件
            [button addTarget:self action:@selector(didcliK:) forControlEvents:UIControlEventTouchUpInside];
            
            //        [button setBackgroundColor: rgb(100+20*i, 150, 30+30*i, 1)];
            button.tag = 10+i;
            [cell.contentView addSubview:button];
            
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((button.width-50)/2, 20, 50, 50)];
            imageV.tag = 1000+i;
            imageV.layer.cornerRadius = 25;
            imageV.clipsToBounds = YES;
            
            UIImage *saveIM = [imageDic objectForKey:[NSString stringWithFormat:@"%ld",1000+i]];
            if (saveIM) {
                imageV.image = saveIM;
            }else{
                imageV.image = [UIImage imageNamed:@"上传图片默认图@3x"];
            }
            imageV.backgroundColor = [UIColor redColor];
            [button addSubview:imageV];
            
            UILabel *titleLa = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.bottom + 10, button.width, 20)];
            titleLa.textAlignment = NSTextAlignmentCenter;
            titleLa.font = [UIFont systemFontOfSize:13];
            titleLa.text  = titleArray[i];
            [button addSubview:titleLa];
        }
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, 122, kScreenWidth - 30, 0.4)];
        backView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:backView];

        SIMAGE = [[UIImageView alloc] initWithFrame:CGRectMake(15, 130, kScreenWidth-30, 0.6*(kScreenWidth-30))];
        SIMAGE.userInteractionEnabled = YES;
        
        UIImage *saveIM = [imageDic objectForKey:[NSString stringWithFormat:@"%ld",1000]];
        if (saveIM) {
            SIMAGE.image = saveIM;
        }else{
            SIMAGE.image = [UIImage imageNamed:@"上传图片默认图@3x"];
        }
        SIMAGE.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:SIMAGE];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect)];
        [SIMAGE addGestureRecognizer:tap];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        
        
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
        return 140 + 0.6*(kScreenWidth-30);
    }
    if (indexPath.section == 2) {
        return 40;
    }

    return 60;
}

- (void)didcliK:(UIButton *)button {
    
    
    
    UIImage *image2 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"seleImage2"];
    if (image2) {
        [imageDic setObject:image2 forKey:@"1002"];
    }

    UIImage *image1;
    
    switch (button.tag) {
        case 10:
        {
            seleImage = 1000;
            
            image1 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"seleImage0"];

        }
            break;
            
        case 11:
        {
            seleImage = 1001;
            
            image1 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"seleImage1"];
        }
            break;
            
        default:{
            
            seleImage = 1002;
            
          image1 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"seleImage2"];
        }
            break;
    }
    
    if (image1) {
        SIMAGE.image = [imageDic objectForKey:[NSString stringWithFormat:@"%ld",seleImage]];
    }else{
        SIMAGE.image = [UIImage imageNamed:@"上传图片默认图@3x"];
    }

    
}

- (void)didSelect{
    
    [self selePhoto];

}
- (void)selePhoto {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    NSLog(@"cancel");
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets infos:(NSArray<NSDictionary *> *)infos {
    if (photos.count < 1) {
        return;
    }
    UIImageView *imageV = [self.view viewWithTag:seleImage];
    imageV.image = photos[0];
    SIMAGE.image = photos[0];
    [imageDic setObject:photos[0] forKey:[NSString stringWithFormat:@"%ld",seleImage]];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:imageV.image];
    
    SDWebImageManager *mageManager = [SDWebImageManager sharedManager];
    switch (seleImage) {
        case 1000:{
            [self uploadImage:imageV.image index:1000];
            [mageManager saveImageToCache:imageV.image forURL:[NSURL URLWithString:@"seleImage0"]];
        }
            break;
        case 1001:{
            [self uploadImage:imageV.image index:1001];
            [mageManager saveImageToCache:imageV.image forURL:[NSURL URLWithString:@"seleImage1"]];
        }
            break;
        case 1002:{
            [mageManager saveImageToCache:imageV.image forURL:[NSURL URLWithString:@"seleImage2"]];
            [self uploadImage:imageV.image index:1002];
        }
            break;

            
        default:
            break;
    }
    
}

- (void)uploadImage:(UIImage *) image index:(NSInteger )index {
    
    NSDate *theDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"YYYY-MM-dd";
    NSDictionary *dic = USERINFO;
    if (!dic) {
        [Alert showWithTitle:@"请重新登录"];
        return;
    }


    NSDictionary *para;
    if (index == 1000) {
        
        para = @{@"imgType":@"B_modeUltrasound",@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"recordTime":[dateFormatter stringFromDate:theDate]};
    }
    if (index == 1001) {
        
        para = @{@"imgType":@"BooldConventionCheck",@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"recordTime":[dateFormatter stringFromDate:theDate]};
    }
    if (index == 1002) {
        
        para = @{@"imgType":@"UrineConventionCheck",@"globalRecordNr":[dic objectForKey:@"mobilePhone"],@"recordTime":[dateFormatter stringFromDate:theDate]};
    }


    [RBaseHttpTool postWithUrl:@"data/uploadFile" parameters:para image:image sucess:^(id json) {
        if ([[json objectForKey:@"sucess"] integerValue] !=1) {
            [Alert showWithTitle:[json objectForKey:@"message"]];
            return ;
        }
        NSString *str = [json objectForKey:@"result"];
        NSMutableArray *children =[NSMutableArray arrayWithArray:[dataDic objectForKey:@"children"]];
       
        if (index == 1000) {
            NSMutableDictionary *Dic = [[NSMutableDictionary alloc]initWithDictionary:[children objectAtIndex:2]];
            [Dic setObject:str forKey:@"defaultValue"];
            
            [children replaceObjectAtIndex:2 withObject:Dic];
  
        }
        if (index == 1001) {
            NSMutableDictionary *Dic = [[NSMutableDictionary alloc]initWithDictionary:[children objectAtIndex:3]];
            [Dic setObject:str forKey:@"defaultValue"];
            
            [children replaceObjectAtIndex:3 withObject:Dic];


        }
        if (index == 1002) {
            NSMutableDictionary *Dic = [[NSMutableDictionary alloc]initWithDictionary:[children objectAtIndex:4]];
            [Dic setObject:str forKey:@"defaultValue"];
            
            [children replaceObjectAtIndex:4 withObject:Dic];

        }

        
        
        [dataDic setObject:children forKey:@"children"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSDate *theDate = [NSDate date];
        dateFormatter.dateFormat =@"YYYY-MM-dd";
        NSString *dataStr =  [dateFormatter stringFromDate:theDate];
        [dataDic setObject:children forKey:@"children"];
        [dataDic setObject:dataStr forKey:@"addTime"];
        [dataDic setObject:@"0" forKey:@"code"];

        
    } failur:^(NSError *error) {
        
    }];

}

#pragma mark -------------------textField delegat-------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   
    [textField canResignFirstResponder];
    
    if (textField.tag == 800) {
        j_actionV.hidden = YES;
        
        [self seleXue];
        
    }else if (textField.tag == 801){
       
        [self seleJob];
        
    }
    return NO;
}
- (void)seleXue {
    
    MKPAlertView *alertView = [[MKPAlertView alloc]initWithTitle:@"自定义UIAlertView" type:1 sureBtn:@"确认" cancleBtn:@"取消"];
    
    alertView.resultIndex = ^(NSString * str)
    {
        // 回调 -- 处理
        NSLog(@"%@",str);
        if ([str isEqualToString:@"cancle"]) {
            return ;
        }
        
        UITextField *textF = [self.view viewWithTag:800];
     NSArray *array =  [str componentsSeparatedByString:@"/"];
        NSMutableArray *children =[NSMutableArray arrayWithArray:[dataDic objectForKey:@"children"]];
        NSMutableDictionary *gaoDic = [[NSMutableDictionary alloc]initWithDictionary:[children objectAtIndex:1]];
        [gaoDic setObject:array[0] forKey:@"defaultValue"];

        NSMutableDictionary *diDic = [[NSMutableDictionary alloc]initWithDictionary:[children objectAtIndex:2]];
        [diDic setObject:array[1] forKey:@"defaultValue"];

        [children replaceObjectAtIndex:1 withObject:gaoDic];
        [children replaceObjectAtIndex:2 withObject:diDic];

        [dataDic setObject:children forKey:@"children"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSDate *theDate = [NSDate date];
        dateFormatter.dateFormat =@"YYYY-MM-dd";
        NSString *dataStr =  [dateFormatter stringFromDate:theDate];
        [dataDic setObject:children forKey:@"children"];
        [dataDic setObject:dataStr forKey:@"addTime"];
        [dataDic setObject:@"0" forKey:@"code"];

        textF.text = [NSString stringWithFormat:@"%@mmHg",str];
        
        [self saveThing:textF.text keyStr:@"xueya"];
    };
    [alertView showMKPAlertView];

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
        [pickerView selectRow:0 inComponent:0 animated:YES];
        
        [j_actionV addSubview:pickerView];
        
        [self.view addSubview:j_actionV];
    }
    
    j_actionV.hidden = NO;
    
}

-(void)toolBarCanelClick{
    
    j_actionV.hidden = YES;
    
}
-(void)toolBarDoneClick{
    
    NSString *captionS = [NSString stringWithFormat:@"%ldcm",xueSel];
    
    UITextField *textF = [self.view viewWithTag:801];
    textF.text = captionS;
    [self saveThing:captionS keyStr:@"gongGao"];
    
    NSMutableArray *children =[NSMutableArray arrayWithArray:[dataDic objectForKey:@"children"]];
    NSMutableDictionary *gongDic = [[NSMutableDictionary alloc]initWithDictionary:[children objectAtIndex:0]];
    [gongDic setObject:captionS forKey:@"defaultValue"];
    
   
    
    [children replaceObjectAtIndex:0 withObject:gongDic];
    
    [dataDic setObject:children forKey:@"children"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *theDate = [NSDate date];
    dateFormatter.dateFormat =@"YYYY-MM-dd";
    NSString *dataStr =  [dateFormatter stringFromDate:theDate];
    [dataDic setObject:children forKey:@"children"];
    [dataDic setObject:dataStr forKey:@"addTime"];
    [dataDic setObject:@"0" forKey:@"code"];

    
    j_actionV.hidden = YES;
    
    
}

- (void)saveThing:(id)thing keyStr:(NSString *)str{
    
    
    NSUserDefaults *defaultS =  [NSUserDefaults standardUserDefaults];
    [defaultS setObject:thing forKey:str];
    [defaultS synchronize];
}


//组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每个组件的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 51;
}

//初始化每个组件每一行数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSString *captionS = [NSString stringWithFormat:@"%ldcm",row];
    return captionS;
}

//选中picker cell,save ArrayIndex
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    xueSel = row;
//    NSString *captionS = [NSString stringWithFormat:@"%ldcm",xueSel];
//    
//    UITextField *textF = [self.view viewWithTag:801];
//    textF.text = captionS;
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
