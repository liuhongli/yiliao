//
//  LandViewController.m
//  HealthPregnant
//
//  Created by 刘宏立 on 16/4/7.
//  Copyright © 2016年 honely. All rights reserved.
//

#import "LandViewController.h"
#import "RegistViewController.h"
#import "ViewController.h"
#import "HPNavigationController.h"

@interface LandViewController ()<UITextFieldDelegate>

@end

@implementation LandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户登录";
    self.mobileLab.layer.borderWidth = 0.5;
    self.mobileLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

- (void)tap {
    [_mobileLab resignFirstResponder];
}
#pragma mark 解决虚拟键盘挡住UITextField的方法  UITextField Delegate methods

//解决虚拟键盘挡住UITextField的方法，键盘若遮住，view上移
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    int offset =(kScreenHeight - 270.0) -textField.bottom;
    
    NSLog(@"111 == %@",NSStringFromCGRect(self.view.frame));
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if(offset < 0)
    {
        CGRect rect = CGRectMake(0.0f, offset,kScreenWidth,kScreenHeight);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

//键盘隐藏后，view还原
- (void) textFieldDidEndEditing:(UITextField *)textField {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 64, kScreenWidth   , kScreenHeight);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)land:(id)sender {
    
  /*
    ViewController *VC = [[ViewController alloc] init];
    HPNavigationController *navVC = [[HPNavigationController alloc]initWithRootViewController:VC];
    self.view.window.rootViewController = navVC;

  */
    if (![NSString isValidateMobile:self.mobileLab.text]) {
        [Alert showWithTitle:@"你输入的手机号有误"];
        return;
    }
    
    
    NSDictionary *para = @{@"mobilePhone":self.mobileLab.text};
    [RBaseHttpTool postWithUrl:@"user/login" parameters:para sucess:^(id json) {
        if ([[json objectForKey:@"success"] floatValue]== 1) {
            NSUserDefaults *userDetaults = [NSUserDefaults standardUserDefaults];
            
            [userDetaults setBool:YES forKey:@"showGuide"];
            //将数据同步到本地的文件中
            NSDictionary *info = [json objectForKey:@"result"];
            [userDetaults setObject:info  forKey:@"USERINFO"];

            [userDetaults synchronize];

            ViewController *VC = [[ViewController alloc] init];
            HPNavigationController *navVC = [[HPNavigationController alloc]initWithRootViewController:VC];
            self.view.window.rootViewController = navVC;
            [Alert showWithTitle:@"登录成功"];

        }else{
            [Alert showWithTitle:[NSString stringWithFormat:@"%@",[json objectForKey:@"message"]]];

        }

    } failur:^(NSError *error) {
        
        
        [Alert showWithTitle:[NSString stringWithFormat:@"%@",error.userInfo]];

    }];
}

- (IBAction)regist:(id)sender {
    RegistViewController *registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:NO];
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
