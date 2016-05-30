//
//  UIColor+Category.h
//  whatever
//
//  Created by cuimingqiang on 16/5/30.
//  Copyright © 2016年 cmq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Category)
/**
 * @param string "ffffff"
 **/
+(instancetype)colorWithString:(NSString*)string alpha:(float)alpha;
+(instancetype)colorWithString:(NSString*)string;
@end
