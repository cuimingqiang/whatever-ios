//
//  RACSignal+UserAPI.m
//  reactiveCocoa-demo
//
//  Created by cuimingqiang on 16/5/11.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

#import "RACSignal+UserAPI.h"

@implementation RACSignal(UserAPI)
+(instancetype)api_register:(id)param dataClass:(Class)clazz{
    return [RACSignal afn_postWithURL:@"/user/register" parameters:param dataClass:clazz];
}
+(instancetype)api_getCode:(NSString *)phone dataClass:(Class)clazz{
    NSString *url = [NSString stringWithFormat:@"/user/getCode/%@",phone];
    return [RACSignal afn_getWithURL:url parameters:nil dataClass:clazz];
}
+(instancetype)api_validateCode:(id)param dataClass:(Class)clazz{
    return [RACSignal afn_postWithURL:@"" parameters:param dataClass:[NSDictionary class]];
}
@end
