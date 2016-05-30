//
//  RACSignal+UserAPI.h
//  reactiveCocoa-demo
//
//  Created by cuimingqiang on 16/5/11.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACSignal+AFNetworking.h"
@interface RACSignal(UserAPI)

+(instancetype)api_register:(id)param dataClass:(Class)clazz;
+(instancetype)api_getCode:(NSString*)phone dataClass:(Class)clazz;
+(instancetype)api_validateCode:(id)param dataClass:(Class)clazz;
@end
