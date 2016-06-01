//
//  RegisterVM.h
//  whatever
//
//  Created by cuimingqiang on 16/6/1.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterModel.h"
#import "CommonHeader.h"
@interface RegisterVM : NSObject
@property(nonatomic)RegisterModel *model;
@property(nonatomic)RACSignal *okEnableSignal;
@property(nonatomic)RACCommand *registerCommand;
@end
