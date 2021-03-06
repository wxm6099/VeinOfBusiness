
//
//  RestfulAPIRequestTool.m
//  app
//
//  Created by 张加胜 on 15/8/3.
//  Copyright (c) 2015年 Donler. All rights reserved.
//
#import "RestfulAPIRequestTool.h"
#import "RouteManager.h"
#import "RouteInfoModel.h"
#import "AFNetworking.h"
#import "Account.h"
#import "ServerAddress.h"
#import "MJExtension.h"
#import "FixTemplateRouteTool.h"

typedef enum : NSUInteger {
    RequsetMethodTypeGET = 0 ,
    RequsetMethodTypePOST,
    RequsetMethodTypePUT,
    RequsetMethodTypeDELETE
} RequsetMethodType;



@interface RestfulAPIRequestTool()

@end

@implementation RestfulAPIRequestTool


/**
 *  路由管理者
 */
static RouteManager *_routeManager;

/**
 *  请求管理者
 */
static AFHTTPSessionManager *_mgr;


/**
 *  类加载时对静态属性的配置
 */

+ (void)loadWithFlag:(BOOL)flag{
    _routeManager = [RouteManager sharedManager];
    
    /*
     ****************************************************************************************************
     baseUrl 使用细则
     ****************************************************************************************************
     NSURL *baseURL = [NSURL URLWithString:@"http://example.com/v1/"];
     [NSURL URLWithString:@"foo" relativeToURL:baseURL];                  // http://example.com/v1/foo
     [NSURL URLWithString:@"foo?bar=baz" relativeToURL:baseURL];          // http://example.com/v1/foo?bar=baz
     [NSURL URLWithString:@"/foo" relativeToURL:baseURL];                 // http://example.com/foo
     [NSURL URLWithString:@"foo/" relativeToURL:baseURL];                 // http://example.com/v1/foo
     [NSURL URLWithString:@"/foo/" relativeToURL:baseURL];                // http://example.com/foo/
     [NSURL URLWithString:@"http://example2.com/" relativeToURL:baseURL]; // http://example2.com/
     ****************************************************************************************************
     */
    
    NSURL *baseUrl = [NSURL URLWithString:[ServerAddress serverAddress]];
    _mgr = [[AFHTTPSessionManager alloc]initWithBaseURL:baseUrl];
    _mgr.responseSerializer  = [AFHTTPResponseSerializer serializer];
//        if (!flag) {
//            _mgr.requestSerializer  = [AFJSONRequestSerializer serializer];
//        }
    //    if ([AccountTool account].userToken) {
    //        [_mgr.requestSerializer setValue:[AccountTool account].userToken forHTTPHeaderField:@"x-access-token"];
    //    }
}

+ (void)routeName:(NSString *)routeName requestModel:(id)requestModel useKeys:(NSArray *)keysArray success:(void (^)(id json))success failure:(void (^)(id errorJson))failure{
    
    __block BOOL uploadFlag = NO;
    
    NSDictionary *paramsDict = [requestModel mj_keyValues];
    [paramsDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *imageArray = (NSArray *)obj;
            if (imageArray.count > 0 && [imageArray[0] isKindOfClass:[UIImage class]]) {
                uploadFlag = YES;
            }
        }
    }];
    
    [self loadWithFlag:uploadFlag];
    RouteInfoModel *routeInfoModel = [_routeManager getModelWithRouteName:routeName];
    // 获得该路由名称的路由信息模型
    
    // 请求方法类型
    RequsetMethodType type;
    if ([routeInfoModel.routeMethod.lowercaseString isEqualToString:@"get"]) {
        type = RequsetMethodTypeGET;
    }else if ([routeInfoModel.routeMethod.lowercaseString isEqualToString:@"post"]){
        type = RequsetMethodTypePOST;
    }else if ([routeInfoModel.routeMethod.lowercaseString isEqualToString:@"put"]){
        type = RequsetMethodTypePUT;
    }else if ([routeInfoModel.routeMethod.lowercaseString isEqualToString:@"delete"]){
        type = RequsetMethodTypeDELETE;
    }
    
    // 排除在url中出现的请求参数
    NSMutableDictionary *mutableParamsDict = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    NSString *routeUrl = [FixTemplateRouteTool routeWithTemplate:routeInfoModel.routeURL parameterModel:requestModel];
    
    NSDictionary *pathParams = [FixTemplateRouteTool routeParamsDictionaryWithTemplate:routeInfoModel.routeURL parameterModel:requestModel];
    [mutableParamsDict addEntriesFromDictionary:pathParams];
    [pathParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [mutableParamsDict removeObjectForKey:key];
    }];
    
    
    NSString *amendStr = [NSString stringWithFormat:@"%@%@", [ServerAddress serverAddress], routeUrl];
    
    NSLog(@"请求的接口为  %@", amendStr);
    switch (type) {
        case RequsetMethodTypeGET:
            [self get:amendStr params:mutableParamsDict success:success failure:failure];
            break;
            
        case RequsetMethodTypePOST:
            if (uploadFlag == YES) {
                [self upload:amendStr params:mutableParamsDict success:success failure:failure];
            }else{
                [self post:amendStr params:mutableParamsDict success:success failure:failure];
            }
            break;
        case RequsetMethodTypeDELETE:
            [self delete:amendStr params:mutableParamsDict success:success failure:failure];
            break;
        case RequsetMethodTypePUT:
            if (uploadFlag == NO) {
                [self put:amendStr params:mutableParamsDict success:success failure:failure];
            } else
            {
                [self putUpload:amendStr params:mutableParamsDict success:success failure:failure];
            }
            break;
        default:
            break;
    }
    NSLog(@"===========Request=============\n");
    NSLog(@"请求的方式为  %@",routeInfoModel.routeMethod);
    NSLog(@"请求的网址为  %@", amendStr);
    NSLog(@"请求的参数为  %@", mutableParamsDict);
    NSLog(@"===========Request=============\n");
}



+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(id errorJson))failure
{
    
    // 发送get请求
    [_mgr GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //处理返回码
        [self processStatusCode:task];
        if (success) {
            success([self dataToJsonObject:responseObject]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //处理返回码
        [self processStatusCode:task];
        NSLog(@"%@",error);
        if (failure) {
            failure([self resolveFailureWith:error]);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(id errorJson))failure
{
    // 发送post请求
    
    [_mgr POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //处理返回码
        [self processStatusCode:task];
        if (success) {
            success([self dataToJsonObject:responseObject]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //处理返回码
        [self processStatusCode:task];
        NSLog(@"%@",error);
        if (failure) {
            failure([self resolveFailureWith:error]);
        }
    }];
}

+ (void)upload:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(id errorJson))failure{
    // 发送post 请求
    __block NSMutableArray *fileArray = [NSMutableArray array];
    __block NSMutableArray *keyArray = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *tempImageArray = [NSArray arrayWithArray:obj];
            if (tempImageArray.count > 0 && [tempImageArray[0] isKindOfClass:[UIImage class]]) {
                [keyArray addObject:key];
                fileArray = (NSMutableArray *)obj;
            }
        }
    }];
    [params removeObjectsForKeys:keyArray];
    
    [_mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSInteger index = 0;
        
        for (UIImage *image in fileArray) {
            [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"photos" fileName:[NSString stringWithFormat:@"DonlerImage %zd", index] mimeType:@"image/jpeg"];
            index++;
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        //处理返回码
        [self processStatusCode:task];
        if (success) {
            success([self dataToJsonObject:responseObject]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //处理返回码
        [self processStatusCode:task];
        NSLog(@"%@",error);
        if (failure) {
            failure([self resolveFailureWith:error]);
        }
    }];
}

+ (void)put:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(id errorJson))failure
{
    
    // 发送put请求
    
    
    //    [manger.requestSerializer setValue:[AccountTool account].token forHTTPHeaderField:@"x-access-token"];
    
    
    [_mgr PUT:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //处理返回码
        [self processStatusCode:task];
        if (success) {
            success([self dataToJsonObject:responseObject]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //处理返回码
        [self processStatusCode:task];
        NSLog(@"%@",error);
        if (failure) {
            failure([self resolveFailureWith:error]);
        }
    }];
}

+ (void)putUpload:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(id errorJson))failure
{
    __block NSMutableArray *fileArray = [NSMutableArray array];
    __block NSMutableArray *keyArray = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *temp = (NSArray *)obj;
            if (temp.count > 0 && [obj[0] isKindOfClass:[UIImage class]]) {
                [keyArray addObject:key];
                fileArray = (NSMutableArray *)obj;
            }
        }
    }];
    
    
    [params removeObjectsForKeys:keyArray];
    
    [self PUT:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSInteger index = 0;
        
        for (UIImage *dataDict in fileArray) {
            [formData appendPartWithFileData:UIImagePNGRepresentation(dataDict) name:@"photo" fileName:[NSString stringWithFormat:@"DonlerImage %zd", index] mimeType:@"image/jpeg"];
            index++;
            
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        //处理返回码
        [self processStatusCode:task];
        if (success) {
            success([self dataToJsonObject:responseObject]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //处理返回码
        [self processStatusCode:task];
        NSLog(@"%@",error);
        if (failure) {
            failure([self resolveFailureWith:error]);
        }
    }];
    
    
}

/**
 * 参考POST方法，增加了PUT方法的UPLOAD
 */
+ (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [_mgr.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:[[NSURL URLWithString:URLString relativeToURL:_mgr.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(_mgr.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [_mgr uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}

+ (void)delete:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(id errorJson))failure{
    
    // 发送delete请求
    [_mgr DELETE:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //处理返回码
        [self processStatusCode:task];
        if (success) {
            success([self dataToJsonObject:responseObject]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //处理返回码
        [self processStatusCode:task];
        NSLog(@"%@",error);
        if (failure) {
            failure([self resolveFailureWith:error]);
        }
    }];
}


+ (id)resolveFailureWith:(NSError *)error{
    
    id errorJson =  [self dataToJsonObject:error.userInfo[@"com.alamofire.serialization.response.error.data"]];
    if (!errorJson) {
        //        TTAlert(@"服务器连接失败");
    }
    return errorJson;
}

/**
 *  data转jsonObject
 *
 *  @param responseObject data
 *
 *  @return JsonObject
 */

+ (id)dataToJsonObject:(id)responseObject{
    
    if ([responseObject isKindOfClass:[NSData class]]) {
        NSData *data = [NSData dataWithData:responseObject];
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return json;
        
    } else {
        return responseObject;
    }
}
/**
 * 处理请求返回码
 */
+ (void)processStatusCode:(NSURLSessionTask*)task
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)[task response];
    NSInteger responseStatusCode = [httpResponse statusCode];
    NSLog(@"========Response Code========");
    NSLog(@"StatusCode-->%ld",responseStatusCode);
    NSLog(@"========Response Code========");
    if (responseStatusCode==401) {
        NSLog(@"toke expired,need user to reLogin");
        
        return;
    }else if (responseStatusCode==408) {
        NSLog(@"timeout error");
        return;
    }
}

@end
