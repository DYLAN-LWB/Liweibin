//
//  WBNetwork.h
//  Liweibin
//
//  Created by 李伟宾 on 15/11/30.
//  Copyright © 2015年 李伟宾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//上传
typedef void(^uploadProgress)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

//下载
typedef void(^DownloadProgressBlock)(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead);
typedef void(^DownloadSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^DownloadFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface WBNetwork : NSObject

+ (WBNetwork *)networkManger;

#pragma mark - 请求接口

/**
 *  get请求
 *
 *  @param url        请求的url
 *  @param success    返回成功
 *  @param failure    返回失败
 */
- (void)requestGet:(NSString *)url
           success:(void(^)(id response))success
           failure:(void(^)(NSError * error))failure;
/**
 *  post请求
 *
 *  @param url        请求的url
 *  @param params     请求的参数
 *  @param success    返回成功
 *  @param failure    返回失败
 */
- (void)requestPost:(NSString *)url
             params:(NSMutableDictionary *)params
            success:(void(^)(id response))success
            failure:(void(^)(NSError * error))failure;

#pragma mark - 上传

/**
 *  上传单张图片
 *
 *  @param imageData 图片二进制流 SData *imageData = UIImageJPEGRepresentation(image, 0.7);
 *  @param url       上传图片接口地址
 *  @param params    封装的参数,id,key等
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)uploadImageWithImageData:(NSData *)imageData
                             url:(NSString *)url
                          params:(NSDictionary *)params
                         success:(void(^)(id response))success
                         failure:(void(^)(NSError * error))failure;

/**
 *  上传音频文件
 *
 *  @param audioData 二进制流
 *  @param url       接口地址
 *  @param params    封装的参数,id,key等
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)uploadAudioWithData:(NSData *)audioData
                        url:(NSString *)url
                     params:(NSDictionary *)params
                    success:(void(^)(id response))success
                    failure:(void(^)(NSError * error))failure;

#pragma mark - 下载文件

/**
 *  开始下载文件
 *
 *  @param URLString     文件链接
 *  @param cachePath     本地路径 (已做处理，传个 `xx.xxx` 即可，如 `demo.mp3`)
 *  @param progressBlock 进度回调
 *  @param successBlock  成功回调
 *  @param failureBlock  失败回调
 *
 *  @return 下载任务
 */
+ (AFHTTPRequestOperation *)downloadFileWithURLString:(NSString *)URLString
                                            cachePath:(NSString *)cachePath
                                             progress:(DownloadProgressBlock)progressBlock
                                              success:(DownloadSuccessBlock)successBlock
                                              failure:(DownloadFailureBlock)failureBlock;
/**
 *  暂停下载文件
 *  @param operation 下载任务
 */
+ (void)pauseWithOperation:(AFHTTPRequestOperation *)operation;

/**
 *  获取文件大小
 *  @param path 本地路径
 *  @return 文件大小
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path;


@end

