//
//  JoDes.h
//  RongMoMo
//
//  Created by Lily Yang on 15/5/15.
//  Copyright (c) 2015年 JinBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@interface JoDes : NSObject
+ (NSString *) encode:(NSString *)str key:(NSString *)key;
+ (NSString *) decode:(NSString *)str key:(NSString *)key;
+ (NSMutableString *)urlEncode:(NSString*)str;
@end
