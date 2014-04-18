//
//  MOSliderMenu.h
//  MOSliderMenu
//
//  Created by Gao Yongqing on 3/14/14.
//  Copyright (c) 2014 Motic China Group Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOSliderMenuItem.h"

@protocol MOSliderMenuDelegate;

@interface MOSliderMenu : UIView

@property (nonatomic,strong,readonly) MOSliderMenuItem *selectedItem;
@property (nonatomic,weak) id<MOSliderMenuDelegate> delegate;

/**
 *  Font for item text, default is System bold 20.
 */
@property (nonatomic,strong) UIFont *itemFont;
@property (nonatomic,strong) UIColor *itemTextColor;
@property (nonatomic,strong) UIColor *itemBgColor;
@property (nonatomic) CGFloat itemCornerRadius;
@property (nonatomic,strong) UIColor *highlightBgColor;
@property (nonatomic,strong) UIColor *highlightTextColor;

@property (nonatomic,strong) UIColor *menuBgColor;
@property (nonatomic,strong) UIColor *menuBorderColor;
@property (nonatomic,assign) CGFloat menuCornerRadius;

/**
 *  Initialize a menu.
 *
 *  @param frame     Frame of the menu.
 *  @param menuItems Menu items to show, the minimum number of items is 2.
 *  @param delegate  The delegate to receive notifications.
 *
 *  @return A slider menu ,nil if error happened.
 */
-(id)initWithFrame:(CGRect)frame
         menuItems:(NSArray *)menuItems
       andDelegate:(id<MOSliderMenuDelegate>)delegate;

@end



@protocol MOSliderMenuDelegate <NSObject>

-(void)sliderMenu:(MOSliderMenu *)menu didSelectItemIndex:(NSInteger)index;
-(void)sliderMenuChangingSelectedItemValue:(MOSliderMenu *)menu;
@optional
-(void)sliderMenuWillChangeSelectedItemValue:(MOSliderMenu *)menu;
-(void)sliderMenuDidChangeSelectedItemValue:(MOSliderMenu *)menu;

@end
