//
//  BaseResult.h
//  reactiveCocoa-demo
//
//  Created by cuimingqiang on 16/5/11.
//  Copyright © 2016年 cuimingqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON+Model.h"
@interface BaseResult : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)id data;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *reason;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *fromuri;
@end
