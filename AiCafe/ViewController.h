//
//  ViewController.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 18/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)sign_up:(id)sender;
- (IBAction)Login_Button:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *login_btn;

@end

