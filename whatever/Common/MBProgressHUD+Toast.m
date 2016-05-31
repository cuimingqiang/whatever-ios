//
//  MBProgressHUD+Toast.m
//  whatever
//
//  Created by admin on 16/5/31.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "MBProgressHUD+Toast.h"

@implementation MBProgressHUD(Toast)
+(void)showMsg:(NSString *)msg inView:(UIView*)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = msg;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:3.0f];
}
+(void)hideWithSuccessAndMsg:(NSString *)msg inView:(UIView *)view{
    MBProgressHUD *hud = [self HUDForView:view];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [UIImage imageNamed:@"hud_done"];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.labelText = msg;
    [hud hide:YES afterDelay:3.0f];
}

+(void)hideWithFailureAndMsg:(NSString *)msg inView:(UIView *)view{
    MBProgressHUD *hud = [self HUDForView:view];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [UIImage imageNamed:@"hud_done"];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.labelText = msg;
    [hud hide:YES afterDelay:3.0f];
}
@end
