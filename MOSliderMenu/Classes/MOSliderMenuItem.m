//
//  MOSliderMenuItem.m
//  MOSliderMenu
//
//  Created by Gao Yongqing on 3/14/14.
//  Copyright (c) 2014 Motic China Group Co., Ltd. All rights reserved.
//

#import "MOSliderMenuItem.h"

const static CGFloat kMOSliderMenuItemHInsert = 5;
const static CGFloat kMOSliderMenuItemVInsert = 3;

@implementation MOSliderMenuItem
{
    UILabel *_label;
}

@synthesize minValue;
@synthesize maxValue;
@synthesize currentValue;

-(NSString *)text
{
    return _label.text;
}

-(void)setText:(NSString *)text
{
    _label.text = text;
}

-(UIColor *)textColor
{
    return _label.textColor;
}

-(void)setTextColor:(UIColor *)textColor
{
    _label.textColor = textColor;
}

-(UIFont *)font
{
    return _label.font;
}

-(void)setFont:(UIFont *)font
{
    _label.font = font;
}

- (id)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        
        self.minValue = 0;
        self.maxValue = 100;
        self.currentValue = 50;
        self.factor = 1;
        
        // Initialization code
        self.layer.cornerRadius = kMOSliderMenuItemHInsert;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:161 green:161 blue:161 alpha:0.7];
        self.textColor = [UIColor colorWithRed:212 green:212 blue:212 alpha:1];
        
        _label = [[UILabel alloc] init];
        _label.textColor = self.textColor;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = text;
        [self addSubview:_label];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _label.frame = CGRectMake(kMOSliderMenuItemHInsert,
                              kMOSliderMenuItemVInsert,
                              self.bounds.size.width - kMOSliderMenuItemHInsert *2,
                              self.bounds.size.height - kMOSliderMenuItemVInsert *2);
}



+(CGSize)itemSizeForText:(NSString *)text withFont:(UIFont *)font
{
    CGRect textBound = [text boundingRectWithSize:CGSizeMake(9999, 9999)
                                          options:NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName: font}
                                          context:nil];
    // The width add 40 points extra space to make the label long engough to hold the text in a line.
    // It's a work around, don't know why the textBound width does not match the label width.
    return CGSizeMake(kMOSliderMenuItemHInsert * 2 + textBound.size.width + 40,
                      kMOSliderMenuItemVInsert * 2 + textBound.size.height);
}

@end
