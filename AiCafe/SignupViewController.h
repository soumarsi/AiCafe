//
//  SignupViewController.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 21/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImage *chosenImage;
}

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *sex;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirm_password;
@property (strong, nonatomic) IBOutlet UITextField *about_you;
@property (strong, nonatomic) IBOutlet UITextField *current_business;

@property (strong, nonatomic) IBOutlet UITextField *DOB;

- (IBAction)Cross_Button:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;

- (IBAction)select_image:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *user_profile_image;

- (IBAction)Sign_up_button:(id)sender;

- (IBAction)select_gender:(id)sender;

@end
