//
//  SignalRequest.h
//  reactiveCocoa-demo
//
//  Created by cuimingqiang on 16/5/9.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "AFNetworking/AFNetworking.h"
@interface RACSignal (AFNetworking)
+(instancetype)afn_postWithURL:(NSString*)url parameters:(id)parameters dataClass:(Class)clazz;
+(instancetype)afn_getWithURL:(NSString*)url parameters:(id)parameters dataClass:(Class)clazz;
+(void)afn_setCookie:(NSString*)cookie;
@end
