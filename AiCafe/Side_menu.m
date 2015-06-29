//
//  Side_menu.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 29/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "Side_menu.h"
#import "SettingViewController.h"

@implementation Side_menu
@synthesize SlideDelegate;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"SideMenu" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}



- (IBAction)Slide_button_tap:(UIButton *)sender {
    
    NSLog(@"Slide button tapped");
    if ([SlideDelegate respondsToSelector:@selector(action_method:)])
    {
        NSLog(@"##### %ld",(long)sender.tag);
        
        [SlideDelegate action_method:sender];
        
    }
    
}
@end
