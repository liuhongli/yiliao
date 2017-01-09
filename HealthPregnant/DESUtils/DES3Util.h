//
//  DES3Util.h
//  RongMoMo
//
//  Created by Lily Yang on 15/5/21.
//  Copyright (c) 2015年 JinBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject
// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;
// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;
@end
