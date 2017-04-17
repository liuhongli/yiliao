//
//  RLoginController.h
//  JSClient
//
//  Created by  honely on 15/8/19.
//  Copyright (c) 2015年 honely. All rights reserved.
//

#import "NSString+CateString.h"
#import <sys/utsname.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CateString)
- (NSString *)URLEncoding
{
    NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
                                                                                              (CFStringRef)self,
                                                                                              NULL,
                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                              kCFStringEncodingUTF8 ));
    return result;
}

- (NSString *)UTF8Encoding
{
    NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
                                                                                              (CFStringRef)self,
                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                              NULL,
                                                                                              kCFStringEncodingUTF8 ));
    return result;
}

- (NSString *)URLDecoding
{
    NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    return result;
    //	NSMutableString * string = [NSMutableString stringWithString:self];
    //    [string replaceOccurrencesOfString:@"+"
    //							withString:@" "
    //							   options:NSLiteralSearch
    //								 range:NSMakeRange(0, [string length])];
    //    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)MD5
{
    unsigned char *CC_MD5();
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString*) sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}



- (BOOL)isVersionEqualAndGreaterThan:(NSString *)version
{
    NSArray *currentSepArr = [self componentsSeparatedByString:@"."];
    NSArray *targetSepArr = [version componentsSeparatedByString:@"."];
    NSInteger maxIdx = [targetSepArr count] >= [currentSepArr count] ? [currentSepArr count] + 1: [currentSepArr count] + 1;
    
    BOOL flag = NO;
    for (NSInteger idx = 0 ;idx < maxIdx; idx++) {
        
        NSString *targetBit = nil;
        if (idx < [targetSepArr count]) {
            targetBit = [targetSepArr objectAtIndex:idx];
        }
        
        NSString *currentBit = nil;
        if (idx < [currentSepArr count]) {
            currentBit = [currentSepArr objectAtIndex:idx];
        }
        
        if (targetBit && currentBit) {
            if (targetBit.integerValue > currentBit.integerValue) {
                flag = NO;
                break;
            }
            else if (targetBit.integerValue < currentBit.integerValue)
            {
                flag = YES;
                break;
            }
            else
            {
                continue;
            }
        }
        else if (targetBit && !currentBit)
        {
            flag = NO;
            break;
        }
        else if (!targetBit && currentBit)
        {
            flag = YES;
            break;
        }
        else
        {
            //都没有的时候，是相等的
            flag = YES;
            break;
        }
    }
    return flag;
}

- (BOOL)isVersionEqualAndLessThan:(NSString *)version
{
    NSArray *targetSepArr = [version componentsSeparatedByString:@"."];
    NSArray *currentSepArr = [self componentsSeparatedByString:@"."];
    NSInteger maxIdx = [targetSepArr count] >= [currentSepArr count] ? [targetSepArr count] + 1: [currentSepArr count] + 1;
    
    BOOL flag = NO;
    for (NSInteger idx = 0 ;idx < maxIdx; idx++) {
        
        NSString *targetBit = nil;
        if (idx < [targetSepArr count]) {
            targetBit = [targetSepArr objectAtIndex:idx];
        }
        
        NSString *currentBit = nil;
        if (idx < [currentSepArr count]) {
            currentBit = [currentSepArr objectAtIndex:idx];
        }
        
        if (targetBit && currentBit) {
            if (targetBit.integerValue > currentBit.integerValue) {
                flag = YES;
                break;
            }
            else if (targetBit.integerValue < currentBit.integerValue)
            {
                flag = NO;
                break;
            }
            else
            {
                continue;
            }
        }
        else if (targetBit && !currentBit)
        {
            flag = YES;
            break;
        }
        else if (!targetBit && currentBit)
        {
            flag = NO;
            break;
        }
        else
        {
            flag = YES;
            break;
        }
    }
    return flag;
}

- (BOOL)empty
{
    return [self length] > 0 ? NO : YES;
}


+ (NSString *)escapeHTML:(NSString*)string
{
    NSMutableString *newString = [[NSMutableString alloc] initWithString:string];
    
    [newString replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [newString length])];
    [newString replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [newString length])];
    [newString replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [newString length])];
    [newString replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [newString length])];
    
    return newString;
}

+ (NSString *)unescapeHTML:(NSString*)string
{
    //强制检查 以防crash
    if (string == nil || [string isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    
    NSMutableString *newString = [[NSMutableString alloc] initWithString:string];
    
    [newString replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [newString length])];
    [newString replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:NSLiteralSearch range:NSMakeRange(0, [newString length])];
    [newString replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSLiteralSearch range:NSMakeRange(0, [newString length])];
    [newString replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSLiteralSearch range:NSMakeRange(0, [newString length])];
    
    return newString;
}

- (NSData *)UTF8Data
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)isValidateHTTPURL
{
    NSString *urlRegEx =
    @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:self];
}

- (NSString *)trimWhitespace
{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)str);
    return str;
}

- (BOOL)isOnlyWhiteSpace
{
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
    }
    return NO;
}


- (NSUInteger)unicodeLengthOfString
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++)
    {
        unichar uc = [self characterAtIndex:i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}

- (NSString *)unicodeMaxLength:(NSUInteger)length
{
    NSUInteger maxLength = 0;
    NSInteger asciiRemainLength = length * 2;
    
    for (maxLength = 0; maxLength < self.length; maxLength++)
    {
        unichar uc = [self characterAtIndex:maxLength];
        NSUInteger assciiCharLength = isascii(uc) ? 1 : 2;
        asciiRemainLength -= assciiCharLength;
        if (asciiRemainLength < 0) {
            break;
        }
    }
    return [self substringToIndex:maxLength];
}

// 验证邮箱
+(BOOL)validateEmail:(NSString*)email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy];
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        /*
         *使用compare option 来设定比较规则，如
         *NSCaseInsensitiveSearch是不区分大小写
         *NSLiteralSearch 进行完全比较,区分大小写
         *NSNumericSearch 只比较定符串的个数，而不比较字符串的字面值
         */
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        //取得域名部分
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else {
        return NO;
    }
}

// 利用正则表达式验证
+ (BOOL)verifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

//昵称
+ (BOOL)validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


// 邮箱
+(BOOL)isValidateEmail:(NSString *)email {
    
    NSArray *array = [email componentsSeparatedByString:@"."];
    if ([array count] >= 4) {
        return FALSE;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
// 电话
/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13，15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}


+ (NSString *)getSubStringWithLimit:(NSInteger)limit string:(NSString *)startString
{
    if (!startString || startString.length == 0)
    {
        return nil;
    }
    __block int length = 0;
    NSMutableString *subNewText = [[NSMutableString alloc] init];
    [startString enumerateSubstringsInRange:NSMakeRange(0, startString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        length += substringRange.length;
        if (length <= limit) {
            [subNewText appendString:substring];
        }
    }];
    return subNewText;
}

+ (BOOL)isValidateChinese:(NSString *)text
{
    NSString *regex = @"^[\u4E00-\u9FA5]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:text];
}




// HTMl转码
+(NSString*)HTMLencode:(NSString*) str{
    
    if (str==nil) {
        return @"";
    }
    
    str= [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    str= [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    str= [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    str= [str stringByReplacingOccurrencesOfString:@"&amp;nbsp;" withString:@" "];
    
    str= [str stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\""];
    str= [str stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
    
    str= [str stringByReplacingOccurrencesOfString:@"&amp;ldquo;" withString:@"\""];
    str= [str stringByReplacingOccurrencesOfString:@"&amp;rdquo;" withString:@"\""];
    str= [str stringByReplacingOccurrencesOfString:@"&mdash" withString:@"——"];
    str= [str stringByReplacingOccurrencesOfString:@"&amp;mdash" withString:@"——"];
    
    
    
    return str;
}

// 时间转换
+ (NSString *)dateString:(id)creatTime{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString * timeStampString = [NSString stringWithFormat:@"%@",creatTime];
    NSTimeInterval _interval=[timeStampString doubleValue] /1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSString *fixString = [dateFormatter stringFromDate:date];
    
    return fixString;
}

+ (NSString *)dateString_2:(NSNumber *)creatTime
{
    NSString * timeStampString = [NSString stringWithFormat:@"%@",creatTime];
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate:date];
}


// 判断当前设备类型
+ (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"\""withString:@""]
            ];
}

//判断昵称是否合法。
+ (BOOL)validateNickName:(NSString *)nickname
{
//    用户昵称长度为4-20个字符，汉字算两个字母，可包含数字、字母、下环线、横线，且至少包含一个字母
    NSString *nicknameRegex = @"^[-_a-zA-Z0-9\u4e00-\u9fa5]{2,20}+$";
    NSPredicate *nicknameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];
    BOOL validate = [nicknameTest evaluateWithObject:nickname];
    
    if ([self isChinese:nickname]>nickname.length) {
        if ([self isChinese:nickname] < 4 || [self isChinese:nickname] > 20) {
            return NO;
        }
    }else{
        if (nickname.length < 4 || nickname.length > 20) {
            return NO;
        }
    }
    return validate;
}

//一个中文字符是两个字符
+ (NSInteger)isChinese:(NSString*)c{
    int strlength = 0;
    char* p = (char*)[c cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[c lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

+ (BOOL)validateConsignee:(NSString *)Consignee
{
    NSString *consigneeRegex = @"^[a-zA-Z0-9.\u4e00-\u9fa5]{2,30}+$";
    NSPredicate *consigneeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", consigneeRegex];
    BOOL validate = [consigneeTest evaluateWithObject:Consignee];
    return validate;
}

+ (BOOL)validatePassWord:(NSString *)passWord
{
    NSString *passwordRegex = @"^[a-zA-Z_0-9]{6,20}+$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    BOOL validate = [passwordTest evaluateWithObject:passWord];
    return validate;
}

+ (BOOL)validateUserName:(NSString *)userName
{
    NSString *userNameRegex = @"^[a-zA-Z_0-9]{6,20}+$";
    NSPredicate *userNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    BOOL validate = [userNameTest evaluateWithObject:userName];
    return validate;
}

+ (BOOL)validateNumber:(NSString *)text
{
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    BOOL validate = [numberTest evaluateWithObject:text];
    return validate;
}

+ (NSString *)digitUppercase:(NSString *)money
{
    NSMutableString *moneyStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[money doubleValue]]];
    NSArray *MyScale=@[@"分", @"角", @"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *MyBase=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    NSMutableString *M=[[NSMutableString alloc] init];
    [moneyStr deleteCharactersInRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 1)];
    for(int i= (int)moneyStr.length;i>0;i--)
    {
        NSInteger MyData=[[moneyStr substringWithRange:NSMakeRange(moneyStr.length-i, 1)] integerValue];
        [M appendString:MyBase[MyData]];
        if([[moneyStr substringFromIndex:moneyStr.length-i+1] integerValue]==0&&i!=1&&i!=2)
        {
            [M appendString:@"元整"];
            break;
        }
        [M appendString:MyScale[i-1]];
    }
    return M;
}

-(NSString*) formateTime:(NSDate*) date {
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString* dateTime = [formatter stringFromDate:date];
    return dateTime;
}


@end
