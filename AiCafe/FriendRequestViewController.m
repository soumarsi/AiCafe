//
//  FriendRequestViewController.m
//  AiCafe
//
//  Created by Soumen on 25/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "FriendRequestViewController.h"
#import "FriendRequestTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RS_JsonClass.h"
#import "UserInfoViewController.h"
#import "ChatViewController.h"
#import "MainScreenViewController.h"


@interface FriendRequestViewController ()

@end

@implementation FriendRequestViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    Login_user_Id = [UserData stringForKey:@"Login_User_id"];

    
    _Friends_Table.delegate=self;
    _Friends_Table.dataSource=self;
    //remove_array =[[NSMutableArray alloc]init];
    //details=[[NSMutableArray alloc]init];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Show_Network_Status:)
                                                 name:@"no_internet" object:nil];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    remove_array =[[NSMutableArray alloc]init];
    globalobj=[[RS_JsonClass alloc]init];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@friend_request_pending.php?user_id=%@",App_Domain_Url,Login_user_Id];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         
         
         if ([[result objectForKey:@"auth"] isEqualToString:@"fail"])
         {
             
         }
         else
         {
             Friend_request=[[result objectForKey:@"details"] mutableCopy];
             [_Friends_Table reloadData];
             
         }
         
         
     }];
    



}

- (void)Show_Network_Status:(NSNotification *)note
{
    
//    UIAlertView *errorAlrt=[[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Please Check Your Wi/Fi or 3G Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [errorAlrt show];
    
    [_Friends_Table setHidden:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Friend_request count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"cellForRowAtIndexPath");
//    cell=[[FriendRequestTableViewCell alloc]init];
    
    static NSString *simpleTableIdentifier = @"Cell";
    FriendRequestTableViewCell *cell = [[FriendRequestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    
    /// Puting Data in tableView
    
    custom_index=indexPath.row;

    if(self.view.frame.size.width>320)
    {
        
            user_name=[[UILabel alloc]initWithFrame:CGRectMake(90, 15, 150, 30)];
            user_name.text=[[Friend_request objectAtIndex:indexPath.row]objectForKey:@"name"];
            [user_name setTextColor:[UIColor colorWithRed:(78/255.f) green:(39/255.f) blue:(14/255.f) alpha:1.0f]];
            [user_name setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:16]];
            [user_name setTextAlignment:NSTextAlignmentLeft];
            [cell addSubview:user_name];
        
            business=[[UILabel alloc]initWithFrame:CGRectMake(90, 37, 150, 30)];
            business.text=[[Friend_request objectAtIndex:indexPath.row]objectForKey:@"business"];
            [business setTextColor:[UIColor whiteColor]];
            [business setFont:[UIFont fontWithName:@"OpenSans" size:15]];
            [business setTextAlignment:NSTextAlignmentLeft];
            [cell addSubview:business];
        
            about=[[UILabel alloc]initWithFrame:CGRectMake(90, 57, 150, 30)];
            about.text=[[Friend_request objectAtIndex:0]valueForKey:@"about"];
            [about setTextColor:[UIColor whiteColor]];
            [about setFont:[UIFont fontWithName:@"OpenSans" size:15]];
            [about setTextAlignment:NSTextAlignmentLeft];
            [cell addSubview:about];
        
            DenieButton=[[UIButton alloc]initWithFrame:CGRectMake(235, 53, 132, 37)];
            [DenieButton setTitle:[NSString stringWithFormat:@"Deny"] forState:UIControlStateNormal];
            DenieButton.backgroundColor=[UIColor colorWithRed:(87.0f/255.0f) green:(62.0f/255.0f) blue:(36.0f/255.0f) alpha:1.0f];
            DenieButton.tag=indexPath.row;
            DenieButton.titleLabel.font=[UIFont fontWithName:@"OpenSans" size:15];
            [DenieButton addTarget:self action:@selector(DenieButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:DenieButton];
        
            UIView *seperatorview=[[UIView alloc]initWithFrame:CGRectMake(0,99,self.view.frame.size.width,1)];
            seperatorview.backgroundColor=[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:0.3f];
            [cell addSubview:seperatorview];
        
            AcceptButton=[[UIButton alloc]initWithFrame:CGRectMake(235, 13, 132, 37)];
            [AcceptButton setImage:[UIImage imageNamed:@"accept"] forState:UIControlStateNormal];
//            AcceptButton.backgroundColor=[UIColor colorWithRed:(87.0f/255.0f) green:(62.0f/255.0f) blue:(36.0f/255.0f) alpha:1.0f];
            AcceptButton.tag=indexPath.row;
            [AcceptButton addTarget:self action:@selector(AcceptButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:AcceptButton];
        
        
            user_profile_image =[[UIImageView alloc] initWithFrame:CGRectMake(17,20,59,59)];
            [cell addSubview:user_profile_image];
        
            user_profile_image.layer.cornerRadius=(user_profile_image.frame.size.width)/2;
            user_profile_image.clipsToBounds=YES;
            user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
        
        if ([[[Friend_request objectAtIndex:indexPath.row]objectForKey:@"sex"] isEqualToString:@"M"])
        
        {
            [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_request objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
        }
        else
        {
          [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_request objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
        }
        
       }
    else
    {
        user_name=[[UILabel alloc]initWithFrame:CGRectMake(85, 15, 150, 30)];
        user_name.text=[NSString stringWithFormat:@"%@",[[Friend_request objectAtIndex:indexPath.row]objectForKey:@"name"]];
        [user_name setTextColor:[UIColor colorWithRed:(78/255.f) green:(39/255.f) blue:(14/255.f) alpha:1.0f]];
        [user_name setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:16]];
        [user_name setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:user_name];
        
        business=[[UILabel alloc]initWithFrame:CGRectMake(85, 37, 150, 30)];
        business.text= [[Friend_request objectAtIndex:indexPath.row]objectForKey:@"business"];
        [business setTextColor:[UIColor whiteColor]];
        [business setFont:[UIFont fontWithName:@"OpenSans" size:15]];
        [business setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:business];
        
        about=[[UILabel alloc]initWithFrame:CGRectMake(85, 57, 150, 30)];
        about.text= [[Friend_request objectAtIndex:indexPath.row]objectForKey:@"about"];
        [about setTextColor:[UIColor whiteColor]];
        [about setFont:[UIFont fontWithName:@"OpenSans" size:15]];
        [about setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:about];
        
        
        
        DenieButton=[[UIButton alloc]initWithFrame:CGRectMake(205, 58, 107, 32)];
        [DenieButton setTitle:[NSString stringWithFormat:@"Deny"] forState:UIControlStateNormal];
        DenieButton.backgroundColor=[UIColor colorWithRed:(87.0f/255.0f) green:(62.0f/255.0f) blue:(36.0f/255.0f) alpha:1.0f];
        DenieButton.tag=indexPath.row;
        DenieButton.titleLabel.font=[UIFont fontWithName:@"OpenSans" size:14];
        [DenieButton addTarget:self action:@selector(DenieButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:DenieButton];

        
        AcceptButton=[[UIButton alloc]initWithFrame:CGRectMake(205, 18, 107, 32)];
        [AcceptButton setImage:[UIImage imageNamed:@"accept"] forState:UIControlStateNormal];
       // AcceptButton.backgroundColor=[UIColor colorWithRed:(87.0f/255.0f) green:(62.0f/255.0f) blue:(36.0f/255.0f) alpha:1.0f];
        AcceptButton.tag=indexPath.row;
        [AcceptButton addTarget:self action:@selector(AcceptButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:AcceptButton];
        
        
        
    
        
        UIView *seperatorview=[[UIView alloc]initWithFrame:CGRectMake(0,99,self.view.frame.size.width,1)];
        seperatorview.backgroundColor=[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:0.3f];
        [cell addSubview:seperatorview];

        
        user_profile_image =[[UIImageView alloc] initWithFrame:CGRectMake(12,20,59,59)];
        [cell addSubview:user_profile_image];
        
        user_profile_image.layer.cornerRadius=(user_profile_image.frame.size.width)/2;
        user_profile_image.clipsToBounds=YES;
        user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
        
        if ([[[Friend_request objectAtIndex:indexPath.row]objectForKey:@"sex"] isEqualToString:@"M"])
        {
            [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_request objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
        }
        else
        {
            [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_request objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
        }
        
    }
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=NO;
    
    BOOL contains = [remove_array containsObject:[Friend_request objectAtIndex:indexPath.row]];
    
    if (contains)
    {
        
        [AcceptButton removeFromSuperview];
        
    }

    return cell;
}
-(void)DenieButtonClicked:(UIButton*)sender
{
        NSString *friend_id=[NSString stringWithFormat:@"%@",[[Friend_request objectAtIndex:sender.tag]objectForKey:@"id"]];

    NSString *urlstring=[NSString stringWithFormat:@"%@friend_request_reject.php?send_id=%@&rec_id=%@",App_Domain_Url,friend_id,Login_user_Id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    [globalobj GlobalDict:request Globalstr:@"string" Withblock:^(id result, NSError *error)
     {
         
         status=result;
         NSLog(@"accept/deny...........%@",status);
         
         [self viewDidLoad];
         
         
     }];
}

-(void)AcceptButtonClicked:(UIButton*)sender
{
    
    NSLog(@"AcceptButtonClicked clicked....%@",[[Friend_request objectAtIndex:sender.tag]objectForKey:@"id"]);
    
    NSString *friend_id=[NSString stringWithFormat:@"%@",[[Friend_request objectAtIndex:sender.tag]objectForKey:@"id"]];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@friend_request_accept.php?send_id=%@&rec_id=%@",App_Domain_Url,friend_id,Login_user_Id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    [globalobj GlobalDict:request Globalstr:@"string" Withblock:^(id result, NSError *error)
     {
         
         status=result;
         NSLog(@"accept/deny...........%@",status);
         
        // if ([status isEqualToString:@"accept"])
        // {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Friend Request Accepted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [alert show];
             
             FriendRequestViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"aicafefriends"];
             
             [self.navigationController pushViewController:Pushobj animated:YES];
        // }
         
     }];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
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

- (IBAction)Back_to_main:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    

}
@end
