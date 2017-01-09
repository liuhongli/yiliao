//
//  RBaseModel.h
//  JSClient
//
//  Created by 刘宏立 on 15/8/31.
//  Copyright (c) 2015年 honely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBaseModel : NSObject
- (id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

- (NSString *)cleanString:(NSString *)str;    //清除\n和\r的字符串


@end
