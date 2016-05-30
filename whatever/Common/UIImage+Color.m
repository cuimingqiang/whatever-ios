//
//  UIImage+Color.m
//  whatever
//
//  Created by cuimingqiang on 16/5/30.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "UIImage+Color.h"
#import "UIColor+Category.h"
@implementation UIImage(Color)

+(instancetype)imageWithColor:(UIColor *)color{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+(instancetype)imageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(instancetype)imageWithColorString:(NSString *)string{
    UIColor *color = [UIColor colorWithString:string];
    return [self imageWithColor:color];
}

+(instancetype)imageWithColorString:(NSString *)string size:(CGSize)size{
    UIColor *color = [UIColor colorWithString:string];
    return [self imageWithColor:color size:size];
}
@end
