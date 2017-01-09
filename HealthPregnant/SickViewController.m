//
//  SickViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/7.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "SickViewController.h"
#import "LTableViewCell.h"
#import "RAnserModel.h"

@interface SickViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSMutableArray *contacts;
    UIButton *button;
    
    NSMutableArray *questArray;//问题列表title
    NSMutableArray *questionArray;//问题选项
    
}


@end

@implementation SickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    contacts = [NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"主诉病症";
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    
    questArray = [NSMutableArray array];
    questionArray = [NSMutableArray array];
    
    NSLog(@"%f",kScreenHeight);
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UIButton *buton  = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 40)];
    [buton setTitle:@"提交" forState:UIControlStateNormal];
    [buton addTarget:self action:@selector(postInfo) forControlEvents:UIControlEventTouchUpInside];
    [buton setBackgroundColor:xuanRGB];
    [view addSubview:buton];
    table.tableFooterView = view;

}

- (void)viewWillAppear:(BOOL)animated{
    [self loadData];
    
}
- (void)loadData{
    
    [RBaseHttpTool getCacheWithUrl:@"/beautician/user-answer-option" option:0 parameters:nil sucess:^(id json) {
        NSArray *dataArray = [json objectForKey:@"data"];
        
        for (int i = 0; i< dataArray.count; i++) {
            NSArray *optionsArray = [[dataArray objectAtIndex:i] objectForKey:@"answer_options"];
            NSString *title =  [[dataArray objectAtIndex:i] objectForKey:@"title"];
            RAnserModel *model = [[RAnserModel alloc] init];
            model = [model initWithDataDic:dataArray[i]];
            model.isSelected = NO;
            [questArray addObject:model];
            
            NSMutableArray *muTaArry = [[NSMutableArray alloc] init];
            for (int n = 0 ; n < optionsArray.count; n++) {
                NSDictionary *optionDic = optionsArray[n];
                RAnserModel *model = [[RAnserModel alloc] init];
                model.title = title;
                model.answer_options = optionsArray;
                model.answer_id  = [optionDic objectForKey:@"answer_id"];
                model.numId  = [optionDic objectForKey:@"id"];
                model.options  = [optionDic objectForKey:@"options"];
                
                
                model.isSelected = NO;
                [muTaArry addObject:model];
            }
            [questionArray addObject:muTaArry];
            
            
        }
        [table reloadData];
        
    } failur:^(NSError *error) {

        [Alert showWithTitle:@"网络异常"];
        
        
    }];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return questionArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    RAnserModel *model = questArray[section];
    NSArray *answer_options = model.answer_options;
    return answer_options.count ;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RAnserModel *model  = questArray[section];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-0, 40)];
    label.text = [NSString stringWithFormat:@"  %ld  %@",section+1,model.title];
    label.textColor  = xuanRGB;
    label.backgroundColor = [UIColor whiteColor];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RAnserModel *model = [questArray objectAtIndex:indexPath.section];
    NSArray *answer_options = model.answer_options;
    NSString *title = [answer_options[indexPath.row] objectForKey:@"options"];
    //计算选中cell的高度
    float cellHeight = [LTableViewCell cellHeight:title];
    
    return cellHeight;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"Cell";
    LTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    for (UIView *view in cell.contentView.subviews) {
        if ([view isMemberOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
        if ([view isMemberOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
        if ([view isMemberOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
        
    }
    cell.m_checkImageView.frame =CGRectMake(10, cell.height/2-10, 20, 20);
    RAnserModel *model = [[questionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.titleLabel.height = cell.height;
    cell.titleLabel.lineBreakMode =  NSLineBreakByWordWrapping;
    [cell.titleLabel setNumberOfLines:0];
    cell.titleLabel.font = [UIFont systemFontOfSize:13];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.options];
    if (model.isSelected) {
        [cell setChecked:YES];
    }else{
        [cell setChecked:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    LTableViewCell *cell = (LTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    RAnserModel *model = questArray[indexPath.section];
    NSMutableArray *quArray = [NSMutableArray arrayWithObjects:questionArray[indexPath.section], nil];
    NSArray *numArray = model.answer_options;
    NSMutableArray *muArray = [NSMutableArray array];
    for (int i=0; i<numArray.count; i++) {
        RAnserModel *quModel =[[questionArray objectAtIndex:indexPath.section] objectAtIndex:i];
        if (indexPath.row == i) {
            quModel.isSelected = YES;
            
        }else{
            quModel.isSelected = NO;
        }
        [muArray addObject:quModel];
    }
    [questionArray replaceObjectAtIndex:indexPath.section withObject:muArray];
    
    [table reloadData];
}


- (void)postInfo {
    //    NSMutableArray *mutableArray = [NSMutableArray array];
    NSString *str = nil ;
    NSInteger titleNum = 0;
    for (int  i = 0; i < questArray.count; i ++) {
        //        NSString *str;
        RAnserModel *model =[questArray objectAtIndex:i];
        
        //        NSArray *array = [questArray objectAtIndex:i]
        for (int n = 0; n <model.answer_options.count; n ++) {
            RAnserModel *qmodel =[[questionArray objectAtIndex:i] objectAtIndex:n];
            if (qmodel.isSelected) {
                if (str) {
                    str = [NSString stringWithFormat:@"%@,%@",str,qmodel.numId];
                }else{
                    str = [NSString stringWithFormat:@"%@",qmodel.numId];
                    
                }
                titleNum ++;
                //                [mutableArray addObject:qmodel.numId];
            }
            
        }
    }
#warning 待完成
    if (titleNum < questArray.count) {
        [Alert showWithTitle:@"请完整填写每一项用户信息,谢谢！"];
        return;
    }
    
}
//完成订单
-(void)finishTask{
    
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
