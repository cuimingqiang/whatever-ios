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
@end
