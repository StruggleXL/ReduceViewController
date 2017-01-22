//
//  NetMessage.h
//  SunRoamGuanAiJiaJia
//
//  Created by Eric on 16/12/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestHeader.h"

typedef enum{
    AFNetworkGET = 1,//get请求
    AFNetworkPOST,  //post请求
    AFNetworkPUT,
    AFNetworkDELETE,
    AFNetworkPATCH,
} AFNetworkType;

@interface NetMessage : NSObject
/** 原始参数*/
@property(nonatomic, assign) AFNetworkType httpMethod;
@property(nonatomic, strong) NSDictionary *params;
@property(nonatomic, strong) NSDictionary *header;
@property(nonatomic, copy) NSString *path;
@property(nonatomic, copy) NSString *serverUrl;//扩展请求会用到,默认使用kServerURL
@property(nonatomic, assign) BOOL showLog;//是否打印返回结果
@property(nonatomic, assign)BOOL isCheck;//默认是yes


@end
