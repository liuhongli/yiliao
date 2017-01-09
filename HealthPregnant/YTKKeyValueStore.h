//
//  YTKKeyValueStore.h
//  Ape
//
//  Created by TangQiao on 12-11-6.
//  Copyright (c) 2012年 TangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTKKeyValueItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) id itemObject;
@property (strong, nonatomic) NSDate *createdTime;

@end


@interface YTKKeyValueStore : NSObject
// 通过initDBWithName方法，即可在程序的Document目录打开指定的数据库文件。如果该文件不存在，则会创建一个新的数据库。
- (id)initDBWithName:(NSString *)dbName;

- (id)initWithDBWithPath:(NSString *)dbPath;

// 通过createTableWithName方法，我们可以在打开的数据库中创建表，如果表名已经存在，则会忽略该操作
- (void)createTableWithName:(NSString *)tableName;

// 清除数据表中所有数据
- (void)clearTable:(NSString *)tableName;

- (void)close;

///************************ Put&Get methods *****************************************
// 写数据到table中去，包括NSDictionary和NSArray
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;

// 从table中根据提供的key读数据，包括NSDictionary和NSArray
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

// 获得指定key的数据
- (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;

// 写NSString数据到table中去
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;

// 从table中根据提供的key读NSString对象
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;

// 写NSNumber数据到table中去
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;

// 从table中根据提供的key读NSNumber对象
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;

// 获得所有数据
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;

// 删除指定key的数据
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

// 批量删除一组key数组的数据
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;

// 批量删除所有带指定前缀的数据
- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;


@end
