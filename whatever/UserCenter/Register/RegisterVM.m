//
//  RegisterVM.m
//  whatever
//
//  Created by cuimingqiang on 16/6/1.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "RegisterVM.h"
#import "RACSignal+UserAPI.h"
@implementation RegisterVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    _model = [[RegisterModel alloc]init];
    
    [RACSignal combineLatest:@[RACObserve(_model, nickname),RACObserve(_model, password)] reduce:^id(NSString *nickname,NSString *password){
        return @(nickname.length >0 && password.length>0);
    }];
    _registerCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal api_register:_model dataClass:[NSDictionary class]];
    }];
}
@end
