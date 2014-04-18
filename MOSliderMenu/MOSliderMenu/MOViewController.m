//
//  MOViewController.m
//  MOSliderMenu
//
//  Created by Gao Yongqing on 4/18/14.
//  Copyright (c) 2014 Motic China Group Co., Ltd. All rights reserved.
//

#import "MOViewController.h"
#import "MOSliderMenu.h"

@interface MOViewController () <MOSliderMenuDelegate>

@property (nonatomic,weak) IBOutlet UILabel *infoLabel;

@end

@implementation MOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setupMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupMenu
{
    NSArray *items = @[[[MOSliderMenuItem alloc] initWithText:@"ONE"],
                       [[MOSliderMenuItem alloc] initWithText:@"TWO"],
                       [[MOSliderMenuItem alloc] initWithText:@"THREE"],
                       [[MOSliderMenuItem alloc] initWithText:@"FOUR"],
                       [[MOSliderMenuItem alloc] initWithText:@"FIVE"]];
    
    MOSliderMenu *menu = [[MOSliderMenu alloc] initWithFrame:self.view.frame
                                                   menuItems:items
                                                 andDelegate:self];
    menu.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:menu];
}

- (void)sliderMenu:(MOSliderMenu *)menu didSelectItemIndex:(NSInteger)index
{
    self.infoLabel.text = [NSString stringWithFormat:@"%@ : %.f", menu.selectedItem.text,menu.selectedItem.currentValue];
}

- (void)sliderMenuChangingSelectedItemValue:(MOSliderMenu *)menu
{
    self.infoLabel.text = [NSString stringWithFormat:@"%@ : %.f", menu.selectedItem.text,menu.selectedItem.currentValue];
}

@end
