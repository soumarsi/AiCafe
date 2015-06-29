//
//  UserInfoViewController.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 25/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "UserInfoViewController.h"
#import "RS_JsonClass.h"
#import "UIImageView+WebCache.h"
#import "ChatViewController.h"


@interface UserInfoViewController () <UITextViewDelegate>
{
    UIView *reportoverlayview;
    UITextView *tview;
    RS_JsonClass *globalobj;
    UIAlertView *alert;
}

@property (strong, nonatomic) IBOutlet UIButton *reportbtn;
@end

@implementation UserInfoViewController
@synthesize getuser_id;
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    _profile_pic.layer.cornerRadius=(_profile_pic.frame.size.width)/2;
    _profile_pic.clipsToBounds=YES;
    _profile_pic.contentMode=UIViewContentModeScaleAspectFill;
    
    
    // Design Modification
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        _blueview.frame=CGRectMake(_blueview.frame.origin.x,_blueview.frame.origin.y,[UIScreen mainScreen].bounds.size.width, _blueview.frame.size.height+8);
        
        
    }
    
    
    
    globalobj=[[RS_JsonClass alloc]init];
    
    //NSString *urlstring=[NSString stringWithFormat:@"%@user_detail.php?id=%@",App_Domain_Url,getuser_id];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@user_detail.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"id=%@",getuser_id];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
         {
             
         }
         else
         {
             user_details=[[NSMutableDictionary alloc]init];
             user_details=[[result objectForKey:@"detail"]mutableCopy];
             
             NSLog(@"User Data-- %@",user_details);
             
             
             if ([[user_details objectForKey:@"sex"] isEqualToString:@"M"])
             {
                 [_profile_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[user_details objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                 
                 
             }
             else
             {
                 [_profile_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[user_details objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
                 
                 
             }
             
             
             
             //--
             
             _profile_name.text=[NSString stringWithFormat:@"%@",[user_details objectForKey:@"name"]];
             
             _about_user.text=[NSString stringWithFormat:@"%@",[user_details objectForKey:@"about"]];
             
             _business.text=[NSString stringWithFormat:@"%@",[user_details objectForKey:@"business"]];
             
             
             if ([[user_details objectForKey:@"sex"] isEqualToString:@"M"])
             {
                 _gender.text=@"Male";
             }
             else
             {
                 _gender.text=@"Female";
                 
             }

         }
         
             }];
}

- (IBAction)MoveToChat:(id)sender
{
    ChatViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"chat_page"];
    //Pushobj.getuser_id=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:sender.tag]objectForKey:@"id"]];
    Pushobj.getuser_id=[NSString stringWithFormat:@"%@",[user_details objectForKey:@"id"]];
    [self.navigationController pushViewController:Pushobj animated:YES];
}

- (IBAction)MoveToAddFriend:(id)sender
{
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    NSString *senderid = [UserData stringForKey:@"Login_User_id"];
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    NSString *receiverid=[user_details objectForKey:@"id"];
    //NSLog(@"sender id...%@",senderid);
    NSString *urlstring=[NSString stringWithFormat:@"%@add_friend.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@",senderid,receiverid];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    [globalobj GlobalDict:request Globalstr:@"string" Withblock:^(id result, NSError *error)
     {
         
         if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
         {
             
         }
         else
         {
             NSString *friendstr;
             friendstr=result;
             NSLog(@"result-- %@",friendstr);
             UIAlertView *message = [[UIAlertView alloc] initWithTitle:friendstr
                                                               message:Nil
                                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             
             [message show];
         }
         
       
     }];
    
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

- (IBAction)Back_Button:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)reportTapped:(id)sender
{
    reportoverlayview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    reportoverlayview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.9];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * .83, 80, 20, 20)];
    [cancel setTitle:@"" forState:UIControlStateNormal];
    [cancel setBackgroundImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    tview = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*.1, self.view.frame.size.height * .3, self.view.frame.size.width*.8, self.view.frame.size.width* .3)];
    tview.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0 alpha:1];
    tview.textColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0 alpha:1];
    tview.textColor = [UIColor colorWithRed:47/255 green:28/255 blue:12/255 alpha:1];
    [tview setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    tview.delegate = self;
    
    UIButton *sendreport = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * .1, self.view.frame.size.height * .48, self.view.frame.size.width * .8, 40)];
//    sendreport.backgroundColor = [UIColor colorWithRed:47/255 green:28/255 blue:12/255 alpha:1];
    [sendreport setBackgroundImage:[UIImage imageNamed:@"App_Main_Background"] forState:UIControlStateNormal];
    [sendreport setTitle:@"Send" forState:UIControlStateNormal];
    sendreport.titleLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:18];
    [sendreport setTitleColor:[UIColor colorWithRed:47/255 green:28/255 blue:12/255 alpha:1] forState:UIControlStateNormal];
    [sendreport addTarget:self action:@selector(sendReportTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [reportoverlayview addSubview:cancel];
    [reportoverlayview addSubview:tview];
    [reportoverlayview addSubview:sendreport];
    [self.view addSubview:reportoverlayview];
    
}

-(void)sendReportTapped
{
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
   NSString *Login_user_Id = [UserData stringForKey:@"Login_User_id"];
    
    NSString *report_text=[tview.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *friend_id=[NSString stringWithFormat:@"%@",[user_details objectForKey:@"id"]];
    
    NSLog(@"RSR............%@",friend_id);
    
    NSString *urlstr = [NSString stringWithFormat:@"%@report.php?send_id=%@&rec_id=%@&report_reason=%@",App_Domain_Url,Login_user_Id,friend_id,report_text];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"id=%@",Login_user_Id];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [globalobj GlobalDict:request Globalstr:@"string" Withblock:^(id result, NSError *error)
     {
         
         if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
         {
             
         }
         else
         {
             NSString *status = [result mutableCopy];
             NSLog(@"Status is:----->%@",status);
             if([status isEqualToString:@"reported"]){
                 
                 
                 alert = [[UIAlertView alloc] initWithTitle:@"" message:@"User Reported" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
                 
                 
                 [reportoverlayview removeFromSuperview];
                 
             }
             else
             {
                 alert = [[UIAlertView alloc] initWithTitle:@"" message:@"User Reported" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
                 
                 
                 [reportoverlayview removeFromSuperview];
                 
             }

         }
         
        
     }];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        
//        if (textView.text.length==0)
//        {
//            self.addlbl.hidden=NO;
//        }
    }
    return YES;
}
-(void)cancelTapped
{
    [reportoverlayview removeFromSuperview];
}



@end
