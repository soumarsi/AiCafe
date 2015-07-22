//
//  SettingViewController.h
//  AiCafe
//
//  Created by Soumen on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
{
    NSString *login_user_id;
    NSMutableDictionary *status_data;
    
    NSMutableArray *block_data_array;
}
- (IBAction)sound_settings:(id)sender;

@end
