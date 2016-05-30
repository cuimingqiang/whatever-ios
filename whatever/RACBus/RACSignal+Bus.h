//
//  RACSignal+Bus.h
//  reactiveCocoa-demo
//
//  Created by cuimingqiang on 16/5/11.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
@interface RACSignal(Bus)

//分配一个事件
+(nonnull instancetype)bus_obtainEvent:(nonnull Class)clazz;
//分配一个粘性事件
+(nonnull instancetype)bus_obtainStickyEvent:(nonnull Class)clazz;
//发送一个事件
+(void)bus_postEvent:(nonnull NSObject*)evnet;
//发送一个粘性事件 ,如果是类簇，类簇作为key，否则以事件的Class作为key
+(void)bus_postStickyEvent:(nonnull NSObject*)event cluster:(nullable Class)cluster;
//回收一个粘性事件
+(void)bus_recycleStickyEvent:(nonnull Class)clazz;
@end
