//
//  UserInfoViewController.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 25/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController

{
    NSMutableDictionary *user_details;
    
    UIActionSheet *report_menu;
}
- (IBAction)Back_Button:(id)sender;

@property(nonatomic,assign)NSString *getuser_id;

@property (strong, nonatomic) IBOutlet UIImageView *profile_pic;
@property (strong, nonatomic) IBOutlet UILabel *profile_name;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *age;

@property (strong, nonatomic) IBOutlet UILabel *gender;
@property (strong, nonatomic) IBOutlet UILabel *business;

@property (strong, nonatomic) IBOutlet UIImageView *gender_icon;

@property (strong, nonatomic) IBOutlet UITextView *about_user;
@property (strong, nonatomic) IBOutlet UIImageView *blueview;
@property (weak, nonatomic) IBOutlet UIImageView *add_friend_button;
@property (weak, nonatomic) IBOutlet UILabel *add_friend_title;
@property (weak, nonatomic) IBOutlet UIButton *add_friend_button2;



@end
