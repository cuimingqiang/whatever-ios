//
//  MBProgressHUD+Toast.h
//  whatever
//
//  Created by admin on 16/5/31.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD/MBProgressHUD.h"
@interface MBProgressHUD(Toast)
+(void)showMsg:(NSString*)msg inView:(UIView*)view;
+(void)hideWithSuccessAndMsg:(NSString*)msg inView:(UIView*)view;
+(void)hideWithFailureAndMsg:(NSString*)msg inView:(UIView*)view;
@end
