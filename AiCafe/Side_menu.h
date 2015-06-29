//
//  Side_menu.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 29/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Slide_menu_delegate<NSObject>
@optional
-(void)action_method:(UIButton *)sender;
@end

@interface Side_menu : UIView


- (IBAction)Slide_button_tap:(UIButton *)sender;

@property(assign)id<Slide_menu_delegate>SlideDelegate;
@end
