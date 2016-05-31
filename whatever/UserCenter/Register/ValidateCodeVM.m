//
//  ValidateCodeVM.m
//  whatever
//
//  Created by cuimingqiang on 16/5/30.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "ValidateCodeVM.h"
#import "RACSignal+UserAPI.h"
@implementation ValidateCodeVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        _model = [[ValidateCodeModel alloc]init];
        [self setup];
    }
    return self;
}

-(void)setup{
    _getCodeEnableSignal = [RACSignal combineLatest:@[RACObserve(self.model, phone)] reduce:^id(NSString *phone){
        return @(phone.length == 11);
    }];
    _validateEnableSignal = [RACSignal combineLatest:@[RACObserve(self.model, phone),RACObserve(self.model, code)] reduce:^id(NSString* phone,NSString *code){
        return @(phone.length == 11 && code.length == 4);
    }];
    
    _getCodeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal api_getCode:_model.phone dataClass:[NSDictionary class]];
    }];
    
    _validateCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal api_validateCode:_model dataClass:[NSDictionary class]];
    }];
}
@end
