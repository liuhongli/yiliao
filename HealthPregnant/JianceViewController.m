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


#define myWithd 90
#define myheight 90
#define myDistance  20 //间距


@interface JianceViewController ()<UITableViewDataSource,UITableViewDelegate,TZImagePickerControllerDelegate>{
    
    NSArray *titleArray;
    NSArray *imageSArray;
    NSArray *questionSArray;
    UIImageView *SIMAGE;
    
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
    [self initTableView];
}

- (void)initTableView {

    _myTabV = [[UITableView alloc] initWithFrame:    CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _myTabV.delegate = self;
    _myTabV.dataSource = self;
    
    
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,100)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, kScreenWidth-40, 40)];
    button.titleLabel.textColor= [UIColor whiteColor];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"界面底部大按钮_ct"] forState:UIControlStateNormal];
    [footview addSubview:button];
    
    _myTabV.tableFooterView = footview;
    [self.view addSubview:_myTabV];
    
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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
            imageV.layer.cornerRadius = 25;
            imageV.clipsToBounds = YES;
            imageV.image = [UIImage imageNamed:imageSArray[i]];
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
        SIMAGE.backgroundColor = [UIColor  greenColor];
        SIMAGE.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:SIMAGE];
        
        UIButton *selePho = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-30, 0.6*(kScreenWidth-30))];
        [selePho addTarget:self action:@selector(selePhoto) forControlEvents:UIControlEventTouchUpInside];
        [SIMAGE addSubview:selePho];
        
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
    
    switch (button.tag) {
        case 10:
        {
            
        }
            break;
            
        case 11:
        {
            
        }
            break;
            
        default:
            break;
    }
    
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

/// User finish picking photo，if assets are not empty, user picking original photo.
/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets{
    if (assets.count > 0) {
        SIMAGE.image = photos[0];
        

    }
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
