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
@interface UserInfoViewController ()

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
    
    NSString *urlstring=[NSString stringWithFormat:@"%@user_detail.php?id=%@",App_Domain_Url,getuser_id];
    
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error)
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
@end
