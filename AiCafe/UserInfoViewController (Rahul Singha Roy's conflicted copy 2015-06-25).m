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
@interface UserInfoViewController ()
{
    UIView *reportoverlayview;
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
    
    
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    //NSString *urlstring=[NSString stringWithFormat:@"%@user_detail.php?id=%@",App_Domain_Url,getuser_id];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@user_detail.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"id=%@",getuser_id];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
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
         NSString *friendstr;
         friendstr=result;
         NSLog(@"result-- %@",friendstr);
         UIAlertView *message = [[UIAlertView alloc] initWithTitle:friendstr
                                                           message:Nil
                                                          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         
         [message show];
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
//    reportoverlayview = [UIView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}

@end
