//
//  HttpRequestManager.h
//  DRMonline
//
//  Created by imac on 16/8/10.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetMessage.h"
#import "AFNetworking.h"

@class ZQFileConfig;

typedef enum
{
    HttpRequestTypePOST, // 增
    HttpRequestTypeGET, // 查
    HttpRequestTypePUT, // 改
    HttpRequestTypeDELETE // 删
} HttpRequestType;

/**
 请求成功block
 */
typedef void(^RequestSuccess)(id resultObject);

/**
 请求失败block
 */
typedef void(^RequestFailure)(NSError *error);

/**
 请求响应block
 */
typedef void (^ResponseBlock)(id dataObj, NSError *error);

/**
 监听进度响应block
 */
typedef void (^ProgressBlock)(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite);


@interface HttpRequestManager : NSObject

@property (nonatomic, strong)AFHTTPSessionManager *manager;
@property (nonatomic,assign)BOOL isNetwork;

+ (instancetype)sharedInstance;
//检测网络
- (void)monitoringNetWork;

- (void)getRequest:(NSString *)methodName parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure;

- (void)postRequest:(NSString *)methodName parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure;

- (void)sendMessage:(NetMessage *)message success:(RequestSuccess)successBlock fail:(RequestFailure)failBlock;

/**
 下载文件
 */
- (void)downloadRequest:(NSString *)url successAndProgress:(ProgressBlock)progressHandler complete:(ResponseBlock)completionHandler;

/**
 文件上传
 */
- (void)updateRequest:(NSString *)url params:(NSDictionary *)params fileConfig:(ZQFileConfig *)fileConfig success:(RequestSuccess)successHandler failure:(RequestFailure)failureHandler;

@end

/**
 *  用来封装上文件数据的模型类
 */
@interface ZQFileConfig : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *fileData;

/**
 *  服务器接收参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

+ (instancetype)fileConfigWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

- (instancetype)initWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;
@end
