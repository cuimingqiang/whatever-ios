//
//  RegisterModel.m
//  whatever
//
//  Created by cuimingqiang on 16/6/1.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "RegisterModel.h"
#import <UIKit/UIKit.h>
@implementation RegisterModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _device = @"ios";
        _deviceId = [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return self;
}
@end
