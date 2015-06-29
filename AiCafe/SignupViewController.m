//
//  SignupViewController.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 21/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "SignupViewController.h"
#import "RS_JsonClass.h"
@interface SignupViewController ()<UIActionSheetDelegate>

@end

@implementation SignupViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *paddingTxtfieldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    UIView *paddingTxtfieldView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    UIView *paddingTxtfieldView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    UIView *paddingTxtfieldView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    UIView *paddingTxtfieldView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    UIView *paddingTxtfieldView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    UIView *paddingTxtfieldView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    UIView *paddingTxtfieldView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 42)];
    
    _name.leftView = paddingTxtfieldView;
    _name.leftViewMode = UITextFieldViewModeAlways;
    
    _sex.leftView = paddingTxtfieldView2;
    _sex.leftViewMode = UITextFieldViewModeAlways;
    
    _DOB.leftView = paddingTxtfieldView8;
    _DOB.leftViewMode = UITextFieldViewModeAlways;

    _email.leftView = paddingTxtfieldView3;
    _email.leftViewMode = UITextFieldViewModeAlways;

    _password.leftView = paddingTxtfieldView4;
    _password.leftViewMode = UITextFieldViewModeAlways;

    _confirm_password.leftView = paddingTxtfieldView5;
    _confirm_password.leftViewMode = UITextFieldViewModeAlways;

    
    _about_you.leftView = paddingTxtfieldView6;
    _about_you.leftViewMode = UITextFieldViewModeAlways;

    _current_business.leftView = paddingTxtfieldView7;
    _current_business.leftViewMode = UITextFieldViewModeAlways;


    
    [_mainScroll setContentSize:CGSizeMake(0,1000)];
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f,[UIScreen mainScreen].bounds.size.width, 35.0f)];
    toolbar.barStyle=UIBarStyleBlackOpaque;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
   
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dateSelected)];
    barButtonItem.tintColor=[UIColor whiteColor];
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
    _DOB.inputAccessoryView = toolbar;

    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.backgroundColor = [UIColor clearColor];
    [datePicker addTarget:self action:@selector(dateUpdated:) forControlEvents:UIControlEventValueChanged];
    self.DOB.inputView = datePicker;
    
    
    _user_profile_image.layer.cornerRadius=(_user_profile_image.frame.size.width)/2;
    _user_profile_image.clipsToBounds=YES;
    _user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    
        if (textField==_email)
        {
            [_mainScroll setContentOffset:CGPointMake(0,90) animated:YES];
        }
        if (textField==_name)
        {
            [_mainScroll setContentOffset:CGPointMake(0,80) animated:YES];
        }
        if (textField==_DOB)
        {
          //  [_mainScroll setContentOffset:CGPointMake(0,80) animated:YES];
        }
        if (textField==_sex)
        {
            
            [_sex resignFirstResponder];
    
          
        }

        else if (textField==_password)
        {
            [_mainScroll setContentOffset:CGPointMake(0,155) animated:YES];
        }

        else if (textField==_confirm_password)
        {
            [_mainScroll setContentOffset:CGPointMake(0,170) animated:YES];
        }
        else if (textField==_about_you)
        {
            [_mainScroll setContentOffset:CGPointMake(0,200) animated:YES];
        }
        else if (textField==_current_business)
        {
            [_mainScroll setContentOffset:CGPointMake(0,230) animated:YES];
        }
        

    
        [textField becomeFirstResponder];


    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_mainScroll setContentOffset:CGPointMake(0,0) animated:YES];
    [textField resignFirstResponder];
     return YES;
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    [_mainScroll setContentOffset:CGPointMake(0,0) animated:YES];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        _sex.text=@"M";
        
    }
    else if (buttonIndex==1)
    {
        _sex.text=@"F";
    }
}

- (void) dateUpdated:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    self.DOB.text = [formatter stringFromDate:datePicker.date];
}

-(void)dateSelected
{
    [_mainScroll setContentOffset:CGPointMake(0,0) animated:YES];
    [_DOB resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Cross_Button:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)select_image:(id)sender
{

    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
   if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
       
    {
        type = UIImagePickerControllerSourceTypeCamera;
    }
  
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        picker.delegate   = self;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
     //   NSString *mediaType = info[UIImagePickerControllerMediaType];
    
       chosenImage = info[UIImagePickerControllerEditedImage];
          

            _user_profile_image.image =chosenImage;
    
    
        [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)Sign_up_button:(id)sender
{
    [_name resignFirstResponder];
    [_DOB resignFirstResponder];
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    [_confirm_password resignFirstResponder];
    [_current_business resignFirstResponder];
    
    
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
        UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:nil message:@"Not a valid email !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [loginAlert show];
    }
    else if ([_name.text isEqualToString:@""])
    {
        _name.text=@"";
      _name.placeholder=@"Please enter your name !";
    }
    else if ([_name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
    {
        _name.text=@"";
        _name.placeholder=@"Please enter your name !";
    }

    else if ([_password.text isEqualToString:@""])
    {
        _password.placeholder=@"Please enter password !";
    }
    else if (![_password.text isEqualToString:_confirm_password.text])
    {
        _confirm_password.text=@"";
        _confirm_password.placeholder=@"Password does not match !";
    }
    else
        
    {

     [_mainScroll setContentOffset:CGPointMake(0,0) animated:YES];
    
    NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(chosenImage, 1.0f)];
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSString *urlString=[NSString stringWithFormat:@"%@registration.php?name=%@&sex=%@&email=%@&password=%@&about=%@&business=%@&dob=%@",App_Domain_Url,_name.text,_sex.text,_email.text,_confirm_password.text,_about_you.text,_current_business.text,_DOB.text];
    
 NSString *str=[globalobj GlobalDict_image:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] Globalstr_image:@"string" globalimage:data];
  
    
    NSLog(@"##########...%@",str);
        
        if ([str isEqualToString:@"1success"])
        {
            
            UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:nil message:@"Ai Cafe Account Successfully Created " delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [loginAlert show];
            
            
            SignupViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
            [self.navigationController pushViewController:Pushobj animated:YES];

        }
        else
        {
            UIAlertView *loginAlert=[[UIAlertView alloc]initWithTitle:nil message:@"Sign Up Failed !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [loginAlert show];
        }
        
    }
    
}


- (IBAction)select_gender:(id)sender
{
    UIActionSheet *Gender_list=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Male",@"Female", nil];
    
    [Gender_list showInView:self.view];
    
    [_mainScroll setContentOffset:CGPointMake(0,0) animated:YES];
    
    
    [_name resignFirstResponder];
    [_DOB resignFirstResponder];
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    [_confirm_password resignFirstResponder];
    [_current_business resignFirstResponder];

   
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
