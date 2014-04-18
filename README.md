MOSliderMenu
============

MOSliderMenu is a menu with the same look as snapseed image adjustment menu.

*How To:*

Create a menu with some items:

```
NSArray *items = @[[[MOSliderMenuItem alloc] initWithText:@"ONE"],
                       [[MOSliderMenuItem alloc] initWithText:@"TWO"],
                       [[MOSliderMenuItem alloc] initWithText:@"THREE"],
                       [[MOSliderMenuItem alloc] initWithText:@"FOUR"],
                       [[MOSliderMenuItem alloc] initWithText:@"FIVE"]];
    
    MOSliderMenu *menu = [[MOSliderMenu alloc] initWithFrame:self.view.frame
                                                   menuItems:items
                                                 andDelegate:self];
```

Add the menu to the view:

```
menu.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
[self.view addSubview:menu];
```

Then you can get events from the menu:

```
- (void)sliderMenu:(MOSliderMenu *)menu didSelectItemIndex:(NSInteger)index
{
    //Put your code here.
}

- (void)sliderMenuChangingSelectedItemValue:(MOSliderMenu *)menu
{
    //Put your code here.
}
```

/*Screenshot*/
(https://github.com/xmkevin/MOSliderMenu/blob/master/Resources/screenshot.png)
