//
//  UIImage+Color.h
//  whatever
//
//  Created by cuimingqiang on 16/5/30.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Color)
+(instancetype)imageWithColor:(UIColor*)color;
+(instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;
+(instancetype)imageWithColorString:(NSString *)string;
+(instancetype)imageWithColorString:(NSString *)string size:(CGSize)size;
@end
