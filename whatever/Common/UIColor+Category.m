//
//  UIColor+Category.m
//  whatever
//
//  Created by cuimingqiang on 16/5/30.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor(Category)
+(instancetype)colorWithString:(NSString *)string alpha:(float)alpha{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&rgbValue];
    float red = ((rgbValue & 0xFF0000) >> 16)/255.0;
    float green = ((rgbValue & 0xFF00) >> 8)/255.0;
    float blue = (rgbValue & 0xFF)/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(instancetype)colorWithString:(NSString *)string{
    return [self colorWithString:string alpha:1.0];
}
@end
