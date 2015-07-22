//
//  SoundSettingsViewController.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 21/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoundSettingsViewController : UIViewController

- (IBAction)back_button:(id)sender;

@property(strong,nonatomic)NSString *sound;
- (IBAction)switch_action:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *switch_status;

@property (weak, nonatomic) IBOutlet UILabel *status_label;

@end
