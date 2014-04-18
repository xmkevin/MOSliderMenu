//
//  MOSliderMenuItem.h
//  MOSliderMenu
//
//  Created by Gao Yongqing on 3/14/14.
//  Copyright (c) 2014 Motic China Group Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOSliderMenuItem : UIView

/**
 *  Min value of item. Default is 0.
 */
@property (nonatomic) CGFloat minValue;

/**
 *  Max value of item, default is 100.
 */
@property (nonatomic) CGFloat maxValue;

/**
 *  Default is 50;
 */
@property (nonatomic) CGFloat currentValue;
/**
 *  Factor of the changing value. Default is 1.
 *  For example: If you have increased 10 points, you just want the value increase 1, set the factor to 0.1
 */
@property (nonatomic) CGFloat factor;

@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIFont *font;

+(CGSize)itemSizeForText:(NSString *)text withFont:(UIFont *)font;

- (id)initWithText:(NSString *)text;

@end
