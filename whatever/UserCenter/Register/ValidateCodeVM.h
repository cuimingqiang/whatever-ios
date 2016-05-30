//
//  ValidateCodeVM.h
//  whatever
//
//  Created by cuimingqiang on 16/5/30.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidateCodeModel.h"
#import "CommonHeader.h"
@interface ValidateCodeVM : NSObject
@property(nonatomic)ValidateCodeModel *model;

@property(nonatomic,readonly)RACSignal *validateEnableSignal;
@property(nonatomic,readonly)RACSignal *getCodeEnableSignal;

@property(nonatomic)RACCommand *validateCommand;
@property(nonatomic)RACCommand *getCodeCommand;
@end
