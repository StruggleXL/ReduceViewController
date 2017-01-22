//
//  HttpRequestManager.m
//  DRMonline
//
//  Created by imac on 16/8/10.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "HttpRequestManager.h"
#import "HttpRequestHeader.h"

#define kTimeoutInterval 30

NSString *const app_actKey= @"app_act";
NSString *const api_nameKey= @"api_name";
NSString *const api_keyKey= @"api_key";
NSString *const api_tokenKey= @"api_token";
NSString *const signKey= @"sign";
NSString *const app_versionKey =@"app_version";

NSString *const app_actValue= @"api/do_index";
NSString *const api_nameValue= @"openshop";
NSString *const api_keyValue= @"1312891786";
NSString *const api_tokenValue= @"e6b4e3e8b81f7086adaddbe4d8731d3d";
NSString *const signValue=@"866E78D7A382AE1B63DA07B7A433A0D5";

static HttpRequestManager *_instance = nil;

@implementation HttpRequestManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HttpRequestManager alloc]init];
    });
    return _instance;
}

- (id)init
{
    @synchronized(self) {
        self = [super init];
        
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //                _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        _manager.securityPolicy.allowInvalidCertificates = YES;
        _manager.requestSerializer.timeoutInterval = kTimeoutInterval;
    }
    return self;
}

- (void)getRequest:(NSString *)methodName parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure
{
    if (![HttpRequestManager sharedInstance].isNetwork) {
        if (failure) {
             NSError *error = [NSError errorWithDomain:@"netError" code:1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不给力哦..."}];
            failure(error);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSDictionary *systemParameters=@{app_actKey:app_actValue,api_nameKey:api_nameValue,api_keyKey:api_keyValue,api_tokenKey:api_tokenValue,app_versionKey:DRMInfoAppVersion};
//    if (dict) {
//        [dict setValuesForKeysWithDictionary:systemParameters];
//    } else {
//        dict=[systemParameters mutableCopy];
//    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kServerURL, methodName];
//    DLog(@"URL %@", urlString);
//    DLog(@"请求 %@\nURL: %@\n参数：%@", [[self methodDescription] objectForKey:methodName], urlString, dict);
    
    [_manager GET:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
//        DLog(@"添加 %@ 请求成功！\n结果：%@", [[self methodDescription] objectForKey:methodName], responseObject);
         NSInteger code = [responseObject[@"code"] integerValue];
        if (code != 0) {
            //错误回调
            NSError *error = [NSError errorWithDomain:@"ErrorFromNetwork" code:code userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"],NSLocalizedFailureReasonErrorKey:responseObject[@"code"]}];
            if (failure) {
                failure(error);
            }
        } else {
            if (success) {
                success(responseObject[@"data"]); //成功回调
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        DLog(@"%@", task.taskDescription);
//        DLog(@"添加 %@ 请求失败！\n错误：%@", [[self methodDescription] objectForKey:methodName], error);
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postRequest:(NSString *)methodName parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure
{
//    if (![HttpRequestManager sharedInstance].isNetwork) {
//        if (failure) {
//            NSError *error = [NSError errorWithDomain:@"netError" code:1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不给力哦..."}];
//            failure(error);
//        }
//        return;
//    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSDictionary *systemParameters=@{app_actKey:app_actValue,api_nameKey:api_nameValue,api_keyKey:api_keyValue,api_tokenKey:api_tokenValue};
    if (dict) {
        [dict setValuesForKeysWithDictionary:systemParameters];
    } else {
        dict=[systemParameters mutableCopy];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kServerURL, methodName];
//    DLog(@"URL %@", urlString);
//    DLog(@"请求 %@\nURL: %@\n参数：%@", [[self methodDescription] objectForKey:methodName], urlString, dict);
    
    [_manager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        DLog(@"添加 %@ 请求成功！\n结果：%@", [[self methodDescription] objectForKey:methodName], responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code != 0) {
            //错误回调
            NSError *error = [NSError errorWithDomain:@"ErrorFromNetwork" code:code userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"],NSLocalizedFailureReasonErrorKey:responseObject[@"code"]}];
            if (failure) {
                failure(error);
            }
        } else {
            if (success) {
                success(responseObject[@"data"]); //成功回调
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        DLog(@"%@", task.taskDescription);
//        DLog(@"添加 %@ 请求失败！\n错误：%@", [[self methodDescription] objectForKey:methodName], error);
        NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
        userInfo[NSLocalizedDescriptionKey] = @"网络不给力哦...";
        NSError *err = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
        if (failure) {
            failure(err);
        }
    }];
}

/**
 文件上传
 */
- (void)updateRequest:(NSString *)methodName params:(NSDictionary *)params fileConfig:(ZQFileConfig *)fileConfig success:(RequestSuccess)successHandler failure:(RequestFailure)failureHandler
{
    if (![HttpRequestManager sharedInstance].isNetwork) {
        NSError *error = [NSError errorWithDomain:@"netError" code:1000 userInfo:@{NSLocalizedDescriptionKey:@"没有网络"}];
        failureHandler(error);
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
    NSDictionary *systemParameters=@{app_actKey:app_actValue,api_nameKey:api_nameValue,api_keyKey:api_keyValue,api_tokenKey:api_tokenValue,signKey:signValue,@"method":methodName};
    if (dict) {
        [dict setValuesForKeysWithDictionary:systemParameters];
    } else {
        dict=[systemParameters mutableCopy];
    }

    
    NSString *urlString = [NSString stringWithFormat:@"%@", kServerURL];
//    DLog(@"请求 %@\nURL: %@\n参数：%@", [[self methodDescription] objectForKey:methodName], urlString, dict);
    
    [_manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileConfig.fileData name:fileConfig.name fileName:fileConfig.fileName mimeType:fileConfig.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //         DLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
        
//        DLog(@"添加 %@ 请求成功！\n结果：%@", [[self methodDescription] objectForKey:methodName], responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DLog(@"-上传失败-%@",error);
        failureHandler(error);
    }];
}

- (void)downloadRequest:(NSString *)url successAndProgress:(ProgressBlock)progressHandler complete:(ResponseBlock)completionHandler
{
    if (![HttpRequestManager sharedInstance].isNetwork) {
        progressHandler(0, 0, 0);
        NSError *error = [NSError errorWithDomain:@"netError" code:1000 userInfo:@{NSLocalizedDescriptionKey:@"没有网络"}];
        completionHandler(nil, error);
        return;
    }
    //    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //    AFHTTPSessionManager *downloadManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    
    AFHTTPSessionManager *downloadManager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *downloadTask = [downloadManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        DLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentUrl = [[NSFileManager defaultManager] URLForDirectory :NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        if (error) {
//            DLog(@"-下载失败-%@",error);
//        } else {
//            DLog(@"下载完成：");
//            DLog(@"%@--%@",response,filePath);
//        }
        completionHandler(response, error);
    }];
    
    [downloadManager setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        progressHandler(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    }];
    [downloadTask resume];
    
}



- (void)sendMessage:(NetMessage *)message success:(RequestSuccess)successBlock fail:(RequestFailure)failBlock
{
    // 正式版本
    if (message.httpMethod == AFNetworkGET) {
        [self getRequest:message.path parameters:message.params success:successBlock failure:failBlock];
    }else if (message.httpMethod == AFNetworkPOST){
        [self postRequest:message.path parameters:message.params success:successBlock failure:failBlock];
    }
}
// 方法列表
- (NSDictionary *)methodDescription
{
    return @{@"user/loginMuliEnt": @"登录",
             @"department/getCareDeptment":@"组织架构",
             @"friends/getfriendsList":@"好友列表",
             @"user/upload":@"上传头像",
             @"modularApp/getTopModularApp":@"重点推荐标题",
             @"recommend/getModulareJkpAction":@"重点推荐健步走",
             @"recommend/getModulareEbook":@"重点推荐兴趣阅读",
             @"recommend/getModulareEapExam":@"重点推荐问卷调查",
             @"recommend/getModulareVote":@"重点推荐投票",
             @"recommend/findNinePic":@"重点推荐banner",
             @"recommend/getModulareAppList":@"重点推荐app",
             @"recommend/getModulareExerciseList":@"重点推荐佳佳推荐",
             };
}

/**
 监控网络状态
 */
- (void)monitoringNetWork
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusUnknown) {
            [HttpRequestManager sharedInstance].isNetwork = YES;
            
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            [HttpRequestManager sharedInstance].isNetwork = YES;
            
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            [HttpRequestManager sharedInstance].isNetwork = YES;
            
        } else if (status == AFNetworkReachabilityStatusNotReachable){
            [HttpRequestManager sharedInstance].isNetwork = NO;
        }
        // 发送通知
//        [KNfCenter postNotificationName:DRMNetworkChangeNotification object:@(status)];
    }];
    
    [reachabilityManager startMonitoring];
    if (reachabilityManager.networkReachabilityStatus!=AFNetworkReachabilityStatusNotReachable) {
        [HttpRequestManager sharedInstance].isNetwork = YES;
    }
}


@end

@implementation ZQFileConfig

+ (instancetype)fileConfigWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType {
    return [[self alloc] initWithfileData:fileData name:name fileName:fileName mimeType:mimeType];
}

- (instancetype)initWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType {
    if (self = [super init]) {
        
        _fileData = fileData;
        _name = name;
        _fileName = fileName;
        _mimeType = mimeType;
    }
    return self;
}

@end
