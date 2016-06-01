//
//  LoginVM.h
//  whatever
//
//  Created by cuimingqiang on 16/6/1.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import "CommonHeader.h"
@interface LoginVM : NSObject
@property(nonatomic)LoginModel *model;
@property(nonatomic)RACSignal *loginEnableSignal;
@property(nonatomic)RACCommand *loginCommand;
@end
