//
//  ViewController.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 18/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ViewController.h"
#import "RS_JsonClass.h"

@interface ViewController ()

@end

@implementation ViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Debarun
    // TextField Padding ....
    
    UIView *paddingTxtfieldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    UIView *paddingTxtfieldView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    _email.leftView = paddingTxtfieldView;
    _email.leftViewMode = UITextFieldViewModeAlways;
    
    _password.leftView = paddingTxtfieldView2;
    _password.leftViewMode = UITextFieldViewModeAlways;

    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sign_up:(id)sender
{
    ViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Signup_Page"];
    [self.navigationController pushViewController:Pushobj animated:YES];
}

- (IBAction)Login_Button:(id)sender
{
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];

    
    if (globalobj.connectedToNetwork == YES)
    {
        
        if ([_email.text isEqualToString:@""])
        {
            _email.placeholder=@"Please enter email !";
        }
        else if (![ self NSStringIsValidEmail:_email.text])
        {
            
            UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:nil message:@"Not a valid email !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [loginAlert show];
        }
        else if ([_email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
        {
            _email.placeholder=@"Email should not have blank space !";
        }
        else if ([_password.text isEqualToString:@""])
        {
            UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:nil message:@"Password can not be blank !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [Alert show];

        }
        else
        {
            _login_btn.userInteractionEnabled=NO;
            
            [_email resignFirstResponder];
            [_password resignFirstResponder];
            
//    NSString *urlstring=[NSString stringWithFormat:@"%@login.php?email=%@&password=%@",App_Domain_Url,_email.text,_password.text];
//            
//        [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error)
//            {
//                
//                if (result)
//                {
//                  NSLog(@"result-- %@",result);
//                    
//                    if ([[result objectForKey:@"auth"] isEqualToString:@"login success"])
//                    {
//                      
//            NSMutableDictionary *get_result=[[result objectForKey:@"details" ]mutableCopy];
//                        
//            NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
//                        
//            [UserData setObject:[get_result objectForKey:@"id"] forKey:@"Login_User_id"];
//            [UserData setObject:[get_result objectForKey:@"name"] forKey:@"User_name"];
//            [UserData setObject:[get_result objectForKey:@"photo_thumb"] forKey:@"user_photo"];
//            [UserData setObject:[get_result objectForKey:@"sex"] forKey:@"user_sex"];
//            [UserData setObject:[get_result objectForKey:@"business"] forKey:@"user_business"];
//            [UserData setObject:[get_result objectForKey:@"about"] forKey:@"user_about"];
//                    
//            [UserData synchronize];
//           
//                        
//                ViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Main_Page"];
//                    [self.navigationController pushViewController:Pushobj animated:YES];
//                        
//                    }
//                    else
//                    {
//                       UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:nil message:@"Login Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                        [Alert show];
//                        
//                        
//                    _login_btn.userInteractionEnabled=YES;
//                        
//                       // _email.text = @"";
//                        _password.text = @"";
//                        
//
//                    }
//                }
//                
//            }];
            
            NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
            NSString *Device_Token = [UserData stringForKey:@"deviceToken"];
            
            NSString *urlstring=[NSString stringWithFormat:@"%@login.php",App_Domain_Url];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
            
            [request setHTTPMethod:@"POST"];
            
            NSString *postData = [NSString stringWithFormat:@"email=%@&password=%@&device_type=0&device_token=%@",_email.text,_password.text,Device_Token];
            
            [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            
            [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
            
[globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
        {
            
            _login_btn.userInteractionEnabled=YES;
            
            NSLog(@">>>>>>>>>>>>> %@",result);
            
      if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
      {
          UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:nil message:@"Login Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
          [Alert show];
          _login_btn.userInteractionEnabled=YES;
      }
   else if ([[result objectForKey:@"auth"]isEqualToString:@"login failed"])
            {
                UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:nil message:@"Login Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [Alert show];
                _login_btn.userInteractionEnabled=YES;
            }

    else
        {
            if([[result objectForKey:@"auth"] isEqualToString:@"login failed"])
        {
                    
                }
                else
                {
                    NSLog(@"result...%@",[result objectForKey:@"auth"]);
                    if([[result objectForKey:@"auth"] isEqualToString:@"login success"])
                    {
                        NSMutableDictionary *get_result=[[result objectForKey:@"details" ]mutableCopy];
                        
                        NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
                        
                        [UserData setObject:[get_result objectForKey:@"id"] forKey:@"Login_User_id"];
                        [UserData setObject:[get_result objectForKey:@"name"] forKey:@"User_name"];
                        [UserData setObject:[get_result objectForKey:@"photo_thumb"] forKey:@"user_photo"];
                        [UserData setObject:[get_result objectForKey:@"photo"] forKey:@"user_photo_mainScreen"];
                        
                        [UserData setObject:[get_result objectForKey:@"sex"] forKey:@"user_sex"];
                        [UserData setObject:[get_result objectForKey:@"age"] forKey:@"age"];
                        [UserData setObject:[get_result objectForKey:@"business"] forKey:@"user_business"];
                        [UserData setObject:[get_result objectForKey:@"about"] forKey:@"user_about"];
                        
                        [UserData synchronize];
                        ViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Main_Page"];
                        [self.navigationController pushViewController:Pushobj animated:YES];
                    }
                    else
                    {
                        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:nil message:@"Login Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [Alert show];
                        
                        _login_btn.userInteractionEnabled=YES;
                        // _email.text = @"";
                        _password.text = @"";
                    }
                }
            }
          
            
  
                 
             }];
            
            
            
        }
        
    }

    

}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}



@end
