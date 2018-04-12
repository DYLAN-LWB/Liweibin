//
//  RequestManager.m
//  Beisu
//
//  Created by 李伟宾 on 15/11/30.
//  Copyright © 2015年 李伟宾. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "WBReachability.h"
#import "WBCache.h"

@interface RequestManager()

@property (nonatomic, strong) AFHTTPRequestOperation *manager;
@property (nonatomic) AFHTTPRequestOperationManager  *requestManager;
@property (nonatomic, strong) NSMutableArray *downloadPaths;

@end

@implementation RequestManager

#pragma mark - 单例

+ (RequestManager *)sharedManger {
    static RequestManager *instance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - 请求接口

- (void)requestGet:(NSString *)url
           success:(void(^)(id response))success
           failure:(void(^)(NSError * error))failure {
    [self requestWithMethod:@"GET" url:url params:nil success:success failure:failure];
}

- (void)requestPost:(NSString *)url
             params:(NSMutableDictionary *)params
            success:(void(^)(id response))success
            failure:(void(^)(NSError * error))failure {
    [self requestWithMethod:@"POST" url:url params:params success:success failure:failure];
}

- (void)requestWithMethod:(NSString *)methodType
                      url:(NSString *)url
                   params:(NSMutableDictionary *)params
                  success:(void(^)(id response))success
                  failure:(void(^)(NSError * error))failure {
    
    AFHTTPRequestSerializer <AFURLRequestSerialization> *requestSerializer = [AFHTTPRequestSerializer serializer];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSMutableURLRequest *request = [requestSerializer requestWithMethod:methodType URLString:url parameters:params error:nil];
    request.timeoutInterval = 15;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/css",@"text/plain",nil];
    [self.requestManager.operationQueue addOperation:operation];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //请求成功
        success(responseObject);
        
        //接口数据写入缓存
        [WBCache save_asyncJsonResponseToCacheFile:responseObject andURL:url params:params completed:^(BOOL result) { }];
        
        //检查异地登录
        WBModel *model = [WBModel modelWithKeyValues:responseObject];
        if (model.code == 99) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        //失败时检查是否有缓存
        id responseCache = [WBCache cacheJsonWithURL:url params:params];
        if (responseCache) {
            success(responseCache);
        } else {
            failure(error);
            WBReachability *reach = [WBReachability WBreachabilityForInternetConnection];
            WBNetworkStatus status = [reach WBcurrentReachabilityStatus];
            if (status == 0) {
                [WBAlertView showMessageToast:@"请检查您的网络" toView:AppShared.window];
            } else {
                [WBAlertView showMessageToast:@"服务器连接失败,请稍后再试" toView:AppShared.window];
            }
        }
    }];
    
    [operation start];
}

#pragma mark - 上传

/**
 *  上传单张图片
 */
- (void)uploadImageWithImageData:(NSData *)imageData
                             url:(NSString *)url
                          params:(NSDictionary *)params
                         success:(void(^)(id response))success
                         failure:(void(^)(NSError * error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/css",@"text/plain",nil];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // name 服务器给的字段名称
        // fileName 图片名称, 随便给
        [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"file.jpg" mimeType:@"image/jpg"];
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"request url = %@", url);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error) {
        NSLog(@"error = %@", error);
        failure(error);
    }];
}

/**
 *  上传音频数据
 */
- (void)uploadAudioWithData:(NSData *)audioData
                        url:(NSString *)url
                     params:(NSDictionary *)params
                    success:(void(^)(id response))success
                    failure:(void(^)(NSError * error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/css",@"text/plain",nil];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // name 服务器给的字段名称
        // fileName 图片名称, 随便给
        [formData appendPartWithFileData:audioData name:@"audio" fileName:@"record.wav" mimeType:@"audio/wav"];
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"request url = %@", url);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error) {
        NSLog(@"error = %@", error);
        failure(error);
    }];
}

- (AFHTTPRequestOperationManager *)requestManager {
    if (!_requestManager) {
        _requestManager = [AFHTTPRequestOperationManager manager] ;
        [_requestManager.securityPolicy setAllowInvalidCertificates:YES];
        
    }
    return _requestManager;
}

#pragma mark - 下载

//获取文件大小
+ (unsigned long long)fileSizeForPath:(NSString *)path {
    return [[self alloc] fileSizeForPath:path];
}

- (unsigned long long)fileSizeForPath:(NSString *)path {
    
    signed long long fileSize = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

//下载文件
+ (AFHTTPRequestOperation *)downloadFileWithURLString:(NSString *)URLString cachePath:(NSString *)cachePath progress:(DownloadProgressBlock)progressBlock success:(DownloadSuccessBlock)successBlock failure:(DownloadFailureBlock)failureBlock {
    return [[self alloc] downloadFileWithURLString:URLString cachePath:cachePath progress:progressBlock success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)downloadFileWithURLString:(NSString *)URLString cachePath:(NSString *)cachePath progress:(DownloadProgressBlock)progressBlock success:(DownloadSuccessBlock)successBlock failure:(DownloadFailureBlock)failureBlock {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //如果没有该文件夹则创建
    NSString *htmlDir = [NSString stringWithFormat:@"%@/diandu/html", docPath];   //项目存放目录
    BOOL isHtmlDir = NO;
    BOOL isHtmlExisted = [fileManager fileExistsAtPath:htmlDir isDirectory:&isHtmlDir];
    if (!(isHtmlDir && isHtmlExisted)) {
        [fileManager createDirectoryAtPath:htmlDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //下载文件本地文件夹 (此处是为了下载压缩包所以`/ZIP`)
    NSString *zipDir = [NSString stringWithFormat:@"%@/diandu/zip", docPath];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:zipDir isDirectory:&isDir];
    
    if (!(isDir == YES && existed == YES)) {
        [fileManager createDirectoryAtPath:zipDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [zipDir stringByAppendingPathComponent:cachePath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    unsigned long long downloadedBytes = 0;
    
    NSLog(@"FilePath:\n%@", filePath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //获取已下载的文件长度
        downloadedBytes = [self fileSizeForPath:filePath];
        
        //检查文件是否已经下载了一部分
        if (downloadedBytes > 0) {
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
        }
    }
    
    //不使用缓存，避免断点续传出现问题
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    //下载请求
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //检查是否已经有该下载任务. 如果有, 释放掉...
    for (NSDictionary *dic in self.downloadPaths) {
        if ([cachePath isEqualToString:dic[@"path"]] && ![(AFHTTPRequestOperation *)dic[@"operation"] isPaused]) {
            return dic[@"operation"];
        } else {
            [(AFHTTPRequestOperation *)dic[@"operation"] cancel];
        }
    }
    NSDictionary *dicNew = @{@"path" : cachePath, @"operation" : operation};
    [self.downloadPaths addObject:dicNew];
    
    //下载路径
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:YES];
    //下载进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        CGFloat progress = ((CGFloat)totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes);
        progressBlock(progress, (totalBytesRead + downloadedBytes) / 1024 / 1024.0f, (totalBytesExpectedToRead + downloadedBytes) / 1024 / 1024.0f);
    }];
    
    //成功和失败回调
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    
    [operation start];
    //为了做暂停功能，把这个下载任务返回
    return operation;
}

//暂停
+ (void)pauseWithOperation:(AFHTTPRequestOperation *)operation {
    [[self alloc] pauseWithOperation:operation];
}

- (void)pauseWithOperation:(AFHTTPRequestOperation *)operation {
    [operation pause];
}

- (NSMutableArray *)downloadPaths {
    if (!_downloadPaths) {
        _downloadPaths = [[NSMutableArray alloc] init];
    }
    return _downloadPaths;
}
@end

