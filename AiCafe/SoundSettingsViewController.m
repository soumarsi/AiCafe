//
//  SoundSettingsViewController.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 21/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "SoundSettingsViewController.h"
#import "RS_JsonClass.h"
@interface SoundSettingsViewController ()

@end

@implementation SoundSettingsViewController
@synthesize sound;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([sound isEqualToString:@"Y"])
    {
         [_switch_status setOn:YES animated:YES];
        
        _status_label.text=@"Chat Sound ON";
    }
    else
    {
         [_switch_status setOn:NO animated:NO];
        
        _status_label.text=@"Chat Sound OFF";
    }
    
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

- (IBAction)back_button:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)switch_action:(id)sender
{
    
    if ([sound isEqualToString:@"Y"])
    {
        _status_label.text=@"Chat Sound OFF";
        
        RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
        
        
        NSString *urlstring=[NSString stringWithFormat:@"%@insert_status.php",App_Domain_Url];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        
        [request setHTTPMethod:@"POST"];
        
        NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
        NSString *login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
        
        NSString *postData = [NSString stringWithFormat:@"id=%@&mode=sound&sound=N",login_user_id];
        
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             NSString *sound_check=@"sound_off";
             
             [[NSUserDefaults standardUserDefaults] setObject:sound_check forKey:@"sound"];
             [[NSUserDefaults standardUserDefaults] synchronize];

             
             [self performSelector:@selector(goBack) withObject:nil afterDelay:1.0f];
             
             
         }];

    }
    else
    {
        _status_label.text=@"Chat Sound ON";
        
        RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
        
        
        NSString *urlstring=[NSString stringWithFormat:@"%@insert_status.php",App_Domain_Url];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        
        [request setHTTPMethod:@"POST"];
        
        NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
        NSString *login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
        
        NSString *postData = [NSString stringWithFormat:@"id=%@&mode=sound&sound=Y",login_user_id];
        
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             NSString *sound_check=@"sound_on";
             
             [[NSUserDefaults standardUserDefaults] setObject:sound_check forKey:@"sound"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self performSelector:@selector(goBack) withObject:nil afterDelay:1.0f];
             
             
             
         }];

    }
    
   
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
