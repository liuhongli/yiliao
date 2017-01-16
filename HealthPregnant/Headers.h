//
//  RLoginController.h
//  JSClient
//
//  Created by  honely on 15/8/19.
//  Copyright (c) 2015年 honely. All rights reserved.
//

#ifndef RongMeme_Headers_h
#define RongMeme_Headers_h

#import <SystemConfiguration/SystemConfiguration.h>

#define SYSTEM_IS_IOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_0)
//#define SYSTEM_IS_IOS8 ([[UIDevice currentDevice].systemVersion floatValue])
#define SYSTEM_IS_IOS8 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)
// 获取物理屏幕的尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kTabbarViewHeight 49
#define kStatusBarHeight 20
#define kNavigationBarHeight 44
#define kPickerViewHeight 216
#define kToolBarHeight 44
#define kStatusViewHeight 216 // 发消息的时候弹出的下面视图的高度
#define kEnglishKeyboardHeight 216 //英文键盘输入高度
#define kChineseKeyboardHeight 252 //中文键盘输入高度
#define baseColor [UIColor colorWithRed:103.0/255 green:0.0/255 blue:131.0/255 alpha:1]

//1主诉病症  2既往病史 3实验室检测 4饮食习惯 5生活习惯 6膳食调查 7运动调查
#define zhusuSDic    [[NSUserDefaults standardUserDefaults] objectForKey:@"user_zhusuSDic"]
#define zhusuPDic    [[NSUserDefaults standardUserDefaults] objectForKey:@"user_zhusuPDic"]

#define jiwangSDic   [[NSUserDefaults standardUserDefaults] objectForKey:@"user_jiwangSDic"]
#define jiwangPDic   [[NSUserDefaults standardUserDefaults] objectForKey:@"user_jiwangPDic"]

#define shiyanSDic   [[NSUserDefaults standardUserDefaults] objectForKey:@"user_shiyanSDic"]
#define shiyanPDic   [[NSUserDefaults standardUserDefaults] objectForKey:@"user_shiyanPDic"]

#define yingshiSDic  [[NSUserDefaults standardUserDefaults] objectForKey:@"user_yingshiSDic"]
#define yingshiPDic  [[NSUserDefaults standardUserDefaults] objectForKey:@"user_yingshiPDic"]

#define shenghuoSDic [[NSUserDefaults standardUserDefaults] objectForKey:@"user_shenghuoSDic"]
#define shenghuoPDic [[NSUserDefaults standardUserDefaults] objectForKey:@"user_shenghuoPDic"]

#define shanshiSDic  [[NSUserDefaults standardUserDefaults] objectForKey:@"user_shanshiSDic"]
#define shanshiPDic  [[NSUserDefaults standardUserDefaults] objectForKey:@"user_shanshiPDic"]

#define yundongSDic  [[NSUserDefaults standardUserDefaults] objectForKey:@"user_yundongSDic"]
#define yundongPDic  [[NSUserDefaults standardUserDefaults] objectForKey:@"user_yundongPDic"]







//通过三色值获取颜色对象
#define xuanRGB    rgb(116, 190, 131, 1)
#define guoRGB     rgb(203, 189, 183, 1)//浅棕色
#define selecRGB   rgb(69,189,185,1)
#define goldenRGB   rgb(115,61,43,1)//金色
#define lanRGB   rgb(21,190,183,1)//蓝色

#define LightBrown [UIColor colorWithHexString:@"bfa99d"] //浅棕
#define DeepBrown [UIColor colorWithHexString:@"733d2b"] //深棕
#define Blue [UIColor colorWithHexString:@"15beb7"] //蓝色
#define Orange [UIColor colorWithHexString:@"f57a6f"] //橘红色



#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define USERID      [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]
#define USERMOBIle  [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"]
#define USERAVATAR  [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]
#define USERCITYID  [[NSUserDefaults standardUserDefaults] objectForKey:@"cityId"]
#define USERCITYName  [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"]

#define USERTYPE      [[NSUserDefaults standardUserDefaults] objectForKey:@"type"]
#define ACCESSTOKEN      [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]
//#define CARTID [[NSUserDefaults standardUserDefaults] objectForKey:@"cartId"]
#define MYLATITUDE      [[NSUserDefaults standardUserDefaults] objectForKey:@"MYLATITUDE"]
#define MYLONGITUDE      [[NSUserDefaults standardUserDefaults] objectForKey:@"MYLONGITUDE"]


#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//颜色值转换
#define COLORFROMCODE(c,a) ([UIColor colorWithRed:(((c >> 16) & 0x000000FF)/255.0f) \
green:(((c >> 8) & 0x000000FF)/255.0f) \
blue:(((c) & 0x000000FF)/255.0f) \
alpha:a])
//#define beautician_id  @"50"

#endif
