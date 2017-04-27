//
//  RBaseHttpTool.m
//  JSClient
//
//  Created by  honely on 15/8/19.
//  Copyright (c) 2015年 honely. All rights reserved.
//

#import "RBaseHttpTool.h"

#import "Reachability.h"
#import "YTKKeyValueStore.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "DES3Util.h"

#import "Utility.h"
#import "UIColor+CateColor.h"
#import "JSONKit.h"


@implementation RBaseHttpTool
static YTKKeyValueStore *_store;

+(void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters sucess:(BaseHttpToolSucess)sucess failur:(BaseHttpToolFailur)failur
{

    url = [NSString stringWithFormat:@"%@%@",HTTPURL,url];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [AFHTTPRequestSerializer serializer].timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                NSLog(@"%@",formData);
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *doubi = responseObject;
        
        NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",shabi);
        
        
        NSString *response = shabi;
        NSLog(@"%@",response);
        response = [response stringByReplacingOccurrencesOfString:@":null"withString:@":\"\""];
        
        NSError *error;
        NSMutableDictionary *responDic;
        
        
        if(nil!=response){
            
            responDic=[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
            NSLog(@"%@",responDic);
            
        }
        
        
        if (responDic) {
            sucess(responDic);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
        if (failur) {
            failur(error);
        }

        
    }];
    
}

+(void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters image:(UIImage *)image sucess:(BaseHttpToolSucess)sucess failur:(BaseHttpToolFailur)failur
{
    
    url = [NSString stringWithFormat:@"%@%@",HTTPURL,url];

    [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/json",@"text/javascript", nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [AFHTTPRequestSerializer serializer].timeoutInterval = 10;

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSLog(@"%@",formData);

            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"imgFile" fileName:@"iOS" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *doubi = responseObject;
        
        NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",shabi);
        
        
        NSString *response = shabi;
        NSLog(@"%@",response);
        response = [response stringByReplacingOccurrencesOfString:@":null"withString:@":\"\""];
        
        NSError *error;
        NSMutableDictionary *responDic;
        
        
        if(nil!=response){
            
            responDic=[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
            NSLog(@"%@",responDic);
            
        }
        
        
        if (responDic) {
            sucess(responDic);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        if (failur) {
            failur(error);
        }
        
        
    }];
    
}



+(void)getCacheWithUrl:(NSString *)url option:(BcRequestCenterCachePolicy)option parameters:(NSDictionary *)parameters sucess:(BaseHttpToolSucess)sucess failur:(BaseHttpToolFailur)failur
{
    
    
    url = [NSString stringWithFormat:@"%@%@",HTTPURL,url];
   
    // 1.创建GET请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    // 开启网络指示器
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
    [AFHTTPRequestSerializer serializer].timeoutInterval = 10;
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
     // 数据库
    NSString *tableName = @"user_table";
    // 判断网络连接
    int status = [self reachabilityConnectionNetWork];
    
    switch (option) {
        case BcRequestCenterCachePolicyNormal:{ // 普通的网络请求
            
            [mgr GET:url parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 NSData *doubi = responseObject;
                 NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];

                 NSLog(@"%@",shabi);
                 
                 
                 NSString *response =[NSString stringWithFormat:@"%@",shabi];
               
                 response = [response stringByReplacingOccurrencesOfString:@":null"withString:@":\"\""];
                 
                     NSError *error;
                 NSMutableDictionary *responDic;
                 

                     if(nil!=response){
                 
                         responDic=[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
                         NSLog(@"%@",responDic);
                 
                     }
                     

                 if (responDic) {
                     sucess(responDic);
                 }else{
                 sucess(shabi);
                 }
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if (failur) {
                     failur(error);
                 }
             }];
        }
            break;
        case BcRequestCenterCachePolicyCacheAndRefresh:{ //如果有网络直接读网络，如果没网络直接读本地
            
            if (status == 0) { // 没有网络
                NSString *newKey = [url stringByAppendingString:parameters[@"method"]];
                NSDictionary *queryUser = [_store getObjectById:newKey fromTable:tableName];
                if (queryUser) {
                    sucess(queryUser);
                }
                // failur(failur);
            }else// 有网络
            {
                // 发送请求
                [mgr GET:url parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSString *newKey = [url stringByAppendingString:parameters[@"method"]];
                     [_store putObject:responseObject withId:newKey intoTable:tableName];
                     if (sucess) {
                         sucess(responseObject);
                     }
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     if (failur) {
                         failur(error);
                     }
                 }];
            }
        }
            break;
        case BcRequestCenterCachePolicyCacheAndLocal:{ //优先读取本地，不管有没有网络，优先读取本地
            
            if (status == 0) { // 没有网络
                NSString *newKey = [url stringByAppendingString:parameters[@"func"]];
                id previouslySaved = [_store getObjectById:newKey fromTable:tableName];
                if (previouslySaved) {
                    sucess(previouslySaved);
                }
            }else// 有网络
            {
                // 发送请求
                [mgr GET:url parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSString *newKey = [url stringByAppendingString:parameters[@"func"]];
                     if ([_store getObjectById:newKey fromTable:tableName]) {
                         sucess([_store getObjectById:newKey fromTable:tableName]);
                     }else
                     {
                         sucess(responseObject);
                     }
                     
                     [_store putObject:responseObject withId:newKey intoTable:tableName];
                     
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     if (failur) {
                         failur(error);
                     }
                 }];
            }
        }
            break;
        default:
            break;
    }
}



+(int)reachabilityConnectionNetWork
{
    Reachability *connectionNetWork = [Reachability reachabilityWithHostName:@"www.apple.com"];
    int status = [connectionNetWork currentReachabilityStatus];
    return status;
}

@end
