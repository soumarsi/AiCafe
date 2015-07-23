//
//  PrivacySettingViewController.m
//  AiCafe
//
//  Created by Soumen on 09/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "PrivacySettingViewController.h"
#import "RS_JsonClass.h"
@interface PrivacySettingViewController ()

@end

@implementation PrivacySettingViewController
@synthesize privacy;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if ([privacy isEqualToString:@"Y"])
    {
        [_privacy_switch setOn:YES animated:YES];
        
        
    }
    else
    {
        [_privacy_switch setOn:NO animated:NO];
        
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackToSetting:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)privacy_switch_action:(id)sender
{
    if ([privacy isEqualToString:@"Y"])
    {
        
        
        RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
        
        
        NSString *urlstring=[NSString stringWithFormat:@"%@insert_status.php",App_Domain_Url];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        
        [request setHTTPMethod:@"POST"];
        
        NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
        NSString *login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
        
        NSString *postData = [NSString stringWithFormat:@"id=%@&mode=visible&visible=N",login_user_id];
        
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
               NSLog(@">>>>>>%@",result);
             
         }];
        
    }
    else
    {
        
        
        RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
        
        
        NSString *urlstring=[NSString stringWithFormat:@"%@insert_status.php",App_Domain_Url];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        
        [request setHTTPMethod:@"POST"];
        
        NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
        NSString *login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
        
          NSString *postData = [NSString stringWithFormat:@"id=%@&mode=visible&visible=Y",login_user_id];
        
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             NSLog(@">>>>>>%@",result);
             
         }];
        
    }

}
@end
