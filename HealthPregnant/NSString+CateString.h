//
//  RLoginController.h
//  JSClient
//
//  Created by  honely on 15/8/19.
//  Copyright (c) 2015年 honely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CateString)
- (NSString *)URLEncoding;

//url编码成utf-8 str
- (NSString *)UTF8Encoding;

//url解码成unicode str
- (NSString *)URLDecoding;

//计算md5
- (NSString *)MD5;

//sha1加密
- (NSString *)sha1;

//是否是空字符串
- (BOOL)empty;

//转换成data
- (NSData *)UTF8Data;

// HTML转码
+(NSString*)HTMLencode:(NSString*) str;

// 时间转换 1.
+ (NSString *)dateString:(id)creatTime;

// 时间转换 2.(若第一种不匹配4s)
+ (NSString *)dateString_2:(NSNumber *)creatTime;

// 数字转大写 两位小数
+ (NSString *)digitUppercase:(NSString *)money;

//是否是个有效的http/https/ftp url，可以判断端口，或者不要协议名称
- (BOOL)isValidateHTTPURL;

//去除字符串前后的空格字符串。
- (NSString *)trimWhitespace;

// 判断字符串只为空格
- (BOOL)isOnlyWhiteSpace;

//判断长度，两个英文字符为一个长度，一个中文字符为一个长度
- (NSUInteger)unicodeLengthOfString;

//截取字符串，两个英文字符为一个长度，一个中文字符为一个长度
- (NSString *)unicodeMaxLength:(NSUInteger)length;

//字符串版本号大小比较
- (BOOL)isVersionEqualAndGreaterThan:(NSString *)version;
- (BOOL)isVersionEqualAndLessThan:(NSString *)version;

//通过区分字符串验证邮箱
+(BOOL)validateEmail:(NSString*)email;

//利用正则表达式验证
//身份证
+ (BOOL)verifyIDCardNumber:(NSString *)value;
//邮箱
+(BOOL)isValidateEmail:(NSString *)email;
// 中文
+ (BOOL)isValidateChinese:(NSString *)text;
// 数字
+ (BOOL)validateNumber:(NSString *)text;
// 电话号码
+ (BOOL)isValidateMobile:(NSString *)mobile;

//获取前多少个字符串
+ (NSString *)getSubStringWithLimit:(NSInteger)limit string:(NSString *)startString;

// 判断当前设备类型
+ (NSString*)deviceString;

//判断昵称规则
+ (BOOL)validateNickName:(NSString *)nickname;
//字符串转json
+(NSString *) jsonStringWithString:(NSString *) string;
-(NSString*) formateTime:(NSDate*) date;
//判断收货人规则
+ (BOOL)validateConsignee:(NSString *)Consignee;
//判断密码规则
+ (BOOL)validatePassWord:(NSString *)passWord;
//判断用户名规则
+ (BOOL)validateUserName:(NSString *)userName;

@end
