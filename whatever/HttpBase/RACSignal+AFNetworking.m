//
//  SignalRequest.m
//  reactiveCocoa-demo
//
//  Created by cuimingqiang on 16/5/9.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

#import "RACSignal+AFNetworking.h"
#import "BaseResult.h"
#import "MJExtension.h"
#import "JSON+Model.h"
#import "objc/runtime.h"
static AFHTTPSessionManager *manager;

typedef void(^Success)(NSURLSessionTask *task, id responseObject);
typedef void(^Failure)(NSURLSessionTask *operation, NSError *error);
typedef NSURLSessionDataTask* (^RequestMethod)(NSDictionary* param,Success success,Failure failure);

@implementation RACSignal (AFNetworking)

+(AFHTTPSessionManager*)managerShare{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *info =  [[NSBundle mainBundle]infoDictionary];
        BOOL release = [[info objectForKey:@"Release"] boolValue];
        NSString *key = release ? @"prod" : @"dev";
        NSString *url = info[@"HostUrl"][key];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setTimeoutIntervalForRequest:8];
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:url] sessionConfiguration:config];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    });
    return manager;
}

+(void)afn_setCookie:(NSString *)cookie{
    [[RACSignal managerShare].requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
}

+(instancetype)afn_postWithURL:(NSString *)url parameters:(id)parameters dataClass:(Class)clazz{
    NSLog(@"-->POST%@",url);
    return [RACSignal requestWithParam:parameters dataClass:clazz method:^NSURLSessionDataTask *(NSDictionary *param, Success success,Failure failure) {
        return [[RACSignal managerShare]POST:url parameters:param progress:nil success:success failure:failure];
    }];
}

+(instancetype)afn_getWithURL:(NSString *)url parameters:(id)parameters dataClass:(Class)clazz{
    NSLog(@"-->GET%@",url);
    return [RACSignal requestWithParam:parameters dataClass:clazz method:^NSURLSessionDataTask *(NSDictionary *param, Success success,Failure failure) {
        return [[RACSignal managerShare]GET:url parameters:param progress:nil success:success failure:failure];
    }];
}

+(instancetype)requestWithParam:(id)parameters dataClass:(Class)clazz method:(RequestMethod)mothod{
    
    RACSignal *networkRequest = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *param = nil;
        if(parameters == nil){
            
        }else if([parameters isKindOfClass:[NSDictionary class]]){
            param = parameters;
        }else{
            param = [parameters mj_keyValues];
        }
        if(param)NSLog(@"param:%@",param);
        
        id success = ^(NSURLSessionTask *task, id responseObject){
            NSLog(@"<--%@\n%@",task.response.URL,responseObject);
            BaseResult *result = [BaseResult mj_objectWithKeyValues:responseObject];
            if(result.code == 200){
                if(class_conformsToProtocol(clazz, @protocol(JSON_Model))){
                    NSDictionary *dic = [clazz performSelector:@selector(undefineKeyMap)];
                    [clazz mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                        return dic;
                    }];
                }
                id data = nil;
                if([result.data isKindOfClass:[NSDictionary class]]){
                    data = [clazz mj_objectWithKeyValues:result.data];
                }else if([result.data isKindOfClass:[NSArray class]]){
                    NSMutableArray *arr = [NSMutableArray array];
                    [result.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        id item = [clazz mj_objectWithKeyValues:obj];
                        [arr addObject:item];
                    }];
                    data = arr;
                }else {
                    data = result.data;
                }
                [subscriber sendNext:data];
                [subscriber sendCompleted];
            }else{
                NSError *err = [[NSError alloc]initWithDomain:result.msg code:result.code userInfo:@{NSLocalizedDescriptionKey:result.msg}];
                [subscriber sendError:err];
            }
            
        };
        
        id failure = ^(NSURLSessionTask *operation, NSError *error){
            [subscriber sendError:error];
        };
        
        NSURLSessionDataTask *task = mothod(param,success,failure);
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    return networkRequest;
}
@end
