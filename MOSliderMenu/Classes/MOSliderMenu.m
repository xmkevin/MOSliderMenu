//
//  MOSliderMenu.m
//  MOSliderMenu
//
//  Created by Gao Yongqing on 3/14/14.
//  Copyright (c) 2014 Motic China Group Co., Ltd. All rights reserved.
//

#import "MOSliderMenu.h"

typedef enum : NSUInteger {
    MOSliderMenuMoveDirectionNone,
    MOSliderMenuMoveDirectionVertical,
    MOSliderMenuMoveDirectionHorizontal,
} MOSliderMenuMoveDirection;

static const int kMOSliderMenuItemSpace = 10;
static const int kMOSliderMenuInset = 10;

@implementation MOSliderMenu
{
    UIView *_menuView;
    NSArray *_items;
    
    CGFloat _minY;
    CGFloat _maxY;
    
    MOSliderMenuItem *_activeItem;
    MOSliderMenuItem *_selectedItem;
    MOSliderMenuMoveDirection _moveDirection;
    
}

@synthesize selectedItem = _selectedItem;

- (id)initWithFrame:(CGRect)frame
          menuItems:(NSArray *)menuItems
        andDelegate:(id<MOSliderMenuDelegate>)delegate
{
    if(menuItems == nil || menuItems.count < 2)
    {
        [NSException raise:@"Menu items should be more than 2 items." format:nil];
        return nil;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _items = menuItems;
        self.delegate = delegate;
        
        [self _initialization];
        
    }
    return self;
}



- (void)layoutSubviews
{
    if(!_menuView)
    {
        [self _setupMenus];
    }
    else
    {
        [self _relocateMenu];
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touches.count != 1 )
    {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint prePoint = [touch previousLocationInView:self];
    CGPoint point = [touch locationInView:self];
    
    if(_moveDirection == MOSliderMenuMoveDirectionNone)
    {
        CGFloat xOffset = point.x - prePoint.x;
        CGFloat yOffset = point.y - prePoint.y;
        
        if((fabsf(yOffset) - fabsf(xOffset)) > 0)
        {
            _moveDirection = MOSliderMenuMoveDirectionVertical;
        }
        else
        {
            _moveDirection = MOSliderMenuMoveDirectionHorizontal;
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(sliderMenuWillChangeSelectedItemValue:)])
            {
                [self.delegate sliderMenuWillChangeSelectedItemValue:self];
            }
        }
    }
    
    //Select item
    if(_moveDirection == MOSliderMenuMoveDirectionVertical)
    {
        _menuView.hidden = NO;
        _activeItem.hidden = NO;
        
        CGFloat yOffset = point.y - prePoint.y;
        
        //_menuView.frame.origin.y += yOffset;
        CGRect menuFrame = _menuView.frame;
        CGFloat newY = menuFrame.origin.y + yOffset;
        if(newY < _minY)
        {
            newY = _minY;
        }
        else if(newY > _maxY)
        {
            newY = _maxY;
        }
        
        _menuView.frame = CGRectMake(menuFrame.origin.x,
                                     newY,
                                     menuFrame.size.width,
                                     menuFrame.size.height);
        
        
        for (NSInteger i = 0; i < _items.count; i++)
        {
            MOSliderMenuItem *item = _items[i];
            
            CGPoint centerPointInMenuView = [self convertPoint:self.center toView:item];
            if([item pointInside:centerPointInMenuView withEvent:nil])
            {
                if(item != _selectedItem)
                {
                    _selectedItem.hidden = NO;
                    item.hidden = YES;
                    
                    _selectedItem = item;
                    _activeItem.text = _selectedItem.text;
                    if(self.delegate)
                    {
                        [self.delegate sliderMenu:self didSelectItemIndex:i];
                    }
                }
            }
        }
        
    }
    else // Change item value
    {
        CGFloat xOffset = point.x - prePoint.x;
        xOffset *= _selectedItem.factor; //One point increase 1 is too quick
        CGFloat newValue = _selectedItem.currentValue + xOffset;
        if(newValue < _selectedItem.minValue) newValue = _selectedItem.minValue;
        if(newValue > _selectedItem.maxValue) newValue = _selectedItem.maxValue;
        
        _selectedItem.currentValue = newValue;
        if(self.delegate)
        {
            [self.delegate sliderMenuChangingSelectedItemValue:self];
        }
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_moveDirection == MOSliderMenuMoveDirectionHorizontal)
    {
        if(self.delegate)
        {
            if([self.delegate respondsToSelector:@selector(sliderMenuDidChangeSelectedItemValue:)])
            {
                [self.delegate sliderMenuDidChangeSelectedItemValue:self];
            }
            
        }
    }
    
    _moveDirection = MOSliderMenuMoveDirectionNone;
    _menuView.hidden = YES;
    _activeItem.hidden = YES;
}

-(void)_initialization
{
    // Initialization code
    _moveDirection = MOSliderMenuMoveDirectionNone;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.itemFont = [UIFont boldSystemFontOfSize:20];
    self.itemBgColor = [UIColor colorWithRed:161 green:161 blue:161 alpha:0.7];
    self.itemTextColor = [UIColor colorWithRed:212 green:212 blue:212 alpha:1];
    self.itemCornerRadius = 5;
    self.highlightBgColor = [UIColor colorWithRed:213 green:0 blue:0 alpha:0.7];
    self.highlightTextColor = [UIColor whiteColor];
    self.menuBgColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.menuBorderColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5];
    self.menuCornerRadius = 10;
}

-(CGSize)_calculateItemSize
{
    //Find the longest string, the item size is determined by the longest string length.
    NSUInteger maxLength = 0;
    MOSliderMenuItem *maxItem;
    for (MOSliderMenuItem *item in _items)
    {
        if(item.text.length > maxLength)
        {
            maxLength = item.text.length;
            maxItem = item;
        }
    }
    
    CGSize itemSize = [MOSliderMenuItem itemSizeForText:maxItem.text withFont:self.itemFont];
    return itemSize;
}

-(void)_setupMenus
{
    
    CGSize itemSize = [self _calculateItemSize];
    
    //Menu background
    int menuViewWidth = itemSize.width + kMOSliderMenuInset * 2;
    int menuViewHeight = itemSize.height * _items.count + kMOSliderMenuItemSpace * (_items.count -1) + kMOSliderMenuInset * 2;
    _minY = self.center.y + itemSize.height / 2.0 + kMOSliderMenuInset - menuViewHeight;
    _maxY = self.center.y - itemSize.height / 2.0 - kMOSliderMenuInset;
    
    _menuView = [[UIView alloc] init];
    _menuView.frame = CGRectMake(self.center.x - menuViewWidth/2.0, _maxY, menuViewWidth, menuViewHeight);
    _menuView.hidden = YES;
    _menuView.opaque = NO;
    _menuView.layer.opaque = NO;
    _menuView.clipsToBounds = YES;
    _menuView.backgroundColor = self.menuBgColor;
    _menuView.layer.cornerRadius = self.menuCornerRadius;
    _menuView.layer.borderWidth = 3;
    _menuView.layer.borderColor = self.menuBorderColor.CGColor;
    _menuView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    CGFloat height = kMOSliderMenuInset;
    for (MOSliderMenuItem *item in _items)
    {
        item.font = self.itemFont;
        item.textColor = self.itemTextColor;
        item.backgroundColor = self.itemBgColor;
        
        item.frame = CGRectMake(kMOSliderMenuInset, height, itemSize.width, itemSize.height);
        height += itemSize.height + kMOSliderMenuItemSpace;
        
        [_menuView addSubview:item];
    }
    [self addSubview:_menuView];
    
    
    //Active item
    _selectedItem = _items[0];
    _selectedItem.hidden = YES;
    _activeItem = [[MOSliderMenuItem alloc] initWithText:_selectedItem.text];
    _activeItem.hidden = YES;
    _activeItem.backgroundColor = self.highlightBgColor;
    _activeItem.textColor = self.highlightTextColor;
    _activeItem.font = self.itemFont;
    _activeItem.frame = CGRectMake(self.center.x - itemSize.width/2.0,self.center.y - itemSize.height/2.0, itemSize.width, itemSize.height);
    _activeItem.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:_activeItem];
    
}

-(void)_relocateMenu
{
    CGSize itemSize = _selectedItem.frame.size;
    _minY = self.center.y + itemSize.height / 2.0 + kMOSliderMenuInset - _menuView.frame.size.height;
    _maxY = self.center.y - itemSize.height / 2.0 - kMOSliderMenuInset;
    
}


@end
