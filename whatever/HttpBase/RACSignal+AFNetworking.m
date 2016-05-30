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
        BOOL release = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"Release"];
        NSString *key = release ? @"prod" : @"dev";
        NSURL *url = [[NSBundle mainBundle]objectForInfoDictionaryKey:key];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setTimeoutIntervalForRequest:8];
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url sessionConfiguration:config];
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
    return [RACSignal requestWithparam:parameters dataClass:clazz method:^NSURLSessionDataTask *(NSDictionary *param, Success success,Failure failure) {
        return [[RACSignal managerShare]POST:url parameters:param progress:nil success:success failure:failure];
    }];
}

+(instancetype)afn_getWithURL:(NSString *)url parameters:(id)parameters dataClass:(Class)clazz{
    return [RACSignal requestWithparam:parameters dataClass:clazz method:^NSURLSessionDataTask *(NSDictionary *param, Success success,Failure failure) {
        return [[RACSignal managerShare]GET:url parameters:param progress:nil success:success failure:failure];
    }];
}

+(instancetype)requestWithparam:(id)parameters dataClass:(Class)clazz method:(RequestMethod)mothod{
    NSLog(@"http:%@",parameters);
    
    RACSignal *networkRequest = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        NSDictionary *param = nil;
        if([parameters isKindOfClass:[NSDictionary class]]){
            param = parameters;
        }else{
            param = [parameters mj_keyValues];
        }
        
        id success = ^(NSURLSessionTask *task, id responseObject){
            NSLog(@"http result:%@--,%@",responseObject,[[NSString alloc]initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
            BaseResult *result = [BaseResult mj_objectWithKeyValues:responseObject];
            if(result.code == 0){
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
            }else{
                NSError *err = [[NSError alloc]initWithDomain:result.msg code:result.code userInfo:@{NSLocalizedDescriptionKey:result.msg}];
                
                [subscriber sendError:err];
            }
            [subscriber sendCompleted];
        };
        
        id failure = ^(NSURLSessionTask *operation, NSError *error){
            [subscriber sendError:error];
        };
        
        NSURLSessionDataTask *task = mothod(parameters,success,failure);
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    return networkRequest;
}
@end
