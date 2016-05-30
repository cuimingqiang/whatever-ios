//
//  RACSignal+Bus.m
//  reactiveCocoa-demo
//
//  Created by cuimingqiang on 16/5/11.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

#import "RACSignal+Bus.h"
static RACSubject *subject;
static NSMutableDictionary<NSString*,RACReplaySubject*> *stickySubject;
@implementation RACSignal(Bus)

+(RACSubject*)bus_subjectShare{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        subject = [RACSubject subject];
    });
    return subject;
}

+(NSMutableDictionary*)bus_stickySubjectShare{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stickySubject = [NSMutableDictionary dictionary];
    });
    return stickySubject;
}

+(instancetype)bus_obtainEvent:(nonnull Class)clazz{
    return [[RACSignal bus_subjectShare] try:^BOOL(id value, NSError *__autoreleasing *errorPtr) {
        return [value isKindOfClass:clazz];
    }];
}

+(instancetype)bus_obtainStickyEvent:(nonnull Class)clazz{
     NSLog(@"----%@",NSStringFromClass(clazz));
    RACReplaySubject *subject = [RACSignal bus_stickySubjectShare][NSStringFromClass(clazz)];
    if(subject == nil){
        subject = [RACReplaySubject replaySubjectWithCapacity:1];
        [stickySubject setObject:subject forKey:NSStringFromClass(clazz)];
    }
    return subject;
}

+(void)bus_postEvent:(nonnull NSObject*)evnet{
    [[RACSignal bus_subjectShare] sendNext:evnet];
}

+(void)bus_postStickyEvent:(nonnull NSObject*)event cluster:(nullable Class)cluster{
    NSString *clazz = nil;
    if(cluster){
        clazz = NSStringFromClass([cluster class]);
    }else{
        clazz = NSStringFromClass([event class]);
    }
    RACReplaySubject *subject = [RACSignal bus_stickySubjectShare][clazz];
    if(subject == nil){
        subject = [RACReplaySubject replaySubjectWithCapacity:1];
        [[RACSignal bus_stickySubjectShare] setObject:subject forKey:clazz];
    }
    [subject sendNext:event];
}

+(void)bus_recycleStickyEvent:(nonnull Class)clazz{
    [[RACSignal bus_stickySubjectShare] removeObjectForKey:NSStringFromClass(clazz)];
}
@end
