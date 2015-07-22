//
//  SettingViewController.m
//  AiCafe
//
//  Created by Soumen on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "SettingViewController.h"
#import "RS_JsonClass.h"
#import "SoundSettingsViewController.h"
#import "BlockListViewController.h"
@interface SettingViewController ()
{
    NSMutableArray *marr;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
    
    
    NSString *urlstring=[NSString stringWithFormat:@"%@show_status.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"id=%@",login_user_id];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         status_data=[[NSMutableDictionary alloc]init];
         block_data_array=[[NSMutableArray alloc]init];
         
         block_data_array=[[result objectForKey:@"block_list"]mutableCopy];
         
         status_data=[[result objectForKey:@"settings"]mutableCopy];
         
                NSLog(@"###>>>>>>>>>%@",result);
         
     }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)PushToSecuritySettings:(id)sender {
    
//    SettingViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"securitysettingviewcontroller"];
    //[self.navigationController pushViewController:Pushobj animated:YES];

}
- (IBAction)PushToPrivacySettings:(id)sender {
    
    SettingViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"privacysettingviewcontroller"];
    [self.navigationController pushViewController:Pushobj animated:YES];
}
- (IBAction)BackToMainScreen:(id)sender {
    [self POPViewController];
}

-(void)POPViewController
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.7f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sound_settings:(id)sender
{
    
    SoundSettingsViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"sound_page"];
    Pushobj.sound=[status_data objectForKey:@"sound"];
    [self.navigationController pushViewController:Pushobj animated:YES];

}

- (IBAction)notification_settings:(id)sender
{
    SoundSettingsViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"notification_page"];
    //Pushobj.sound=[status_data objectForKey:@"sound"];
    [self.navigationController pushViewController:Pushobj animated:YES];
}

- (IBAction)block_list:(id)sender
{
//     RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
//    
//    NSString *urlstring=[NSString stringWithFormat:@"http://www.esolz.co.in/lab9/aiCafe/iosapp/show_status.php?id=10"];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    NSString *postData = [NSString stringWithFormat:@"id=%d",10];
//    
//    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    
//    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
//     {
//         
//         
//         //NSLog(@"output....%@",result);
//         
//         marr=[[result objectForKey:@"block_list"]mutableCopy];
////         for(int i=0;i<[marr count];i++)
////         {
////             NSLog(@"id..%@",[[marr objectAtIndex:i]valueForKey:@"id"]);
////             NSLog(@"name..%@",[[marr objectAtIndex:i]valueForKey:@"name"]);
////         }
//      
//    
//         
//         
//     }];
//    
//    BlockListViewController *nxtobj=[[BlockListViewController alloc]init];
//    nxtobj.blockarray=[marr mutableCopy];
//
    
    BlockListViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"blocklist_page"];
    Pushobj.blockarray=block_data_array;
    [self.navigationController pushViewController:Pushobj animated:YES];
}


@end
