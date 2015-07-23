//
//  PrivacySettingViewController.h
//  AiCafe
//
//  Created by Soumen on 09/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacySettingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *privacy_switch;
- (IBAction)privacy_switch_action:(id)sender;

@property(strong,nonatomic)NSString *privacy;

@end
