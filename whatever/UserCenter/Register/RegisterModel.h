//
//  RegisterModel.h
//  whatever
//
//  Created by cuimingqiang on 16/6/1.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject
@property(nonatomic)NSString *registerToken;
@property(nonatomic)NSString *nickname;
@property(nonatomic)NSString *phone;
@property(nonatomic)NSString *password;

@property(nonatomic)NSString *device;
@property(nonatomic)NSString *deviceId;
@end
