//
//  AddFriendsViewController.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 21/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "AddFriendTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RS_JsonClass.h"
#import "UserInfoViewController.h"
#import "ChatViewController.h"

@interface AddFriendsViewController ()

@end

@implementation AddFriendsViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
       remove_array =[[NSMutableArray alloc]init];
    
     RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    NSString *Login_user_Id = [UserData stringForKey:@"Login_User_id"];
    
    
    NSString *urlstring=[NSString stringWithFormat:@"%@user_listing.php?id=%@",App_Domain_Url,Login_user_Id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
          if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
          {
              
          }
         else
         {
             NSLog(@"All User Data....%@",request);
             
             Friend_list=[[NSMutableArray alloc]init];
             Friend_list=[[result objectForKey:@"details"] mutableCopy];
             
             [_Friends_Table reloadData];

         }
         
         
     }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Show_Network_Status:)
                                                 name:@"no_internet" object:nil];
    
}

- (void)Show_Network_Status:(NSNotification *)note
{
    
   // UIAlertView *errorAlrt=[[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Please Check Your Wi/Fi or 3G Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
  //  [errorAlrt show];
    
    [_Friends_Table setHidden:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Friend_list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    cell=[[AddFriendTableViewCell alloc]init];

    /// Puting Data in tableView
    
    custom_index=indexPath.row;
    
    if(self.view.frame.size.width>320)
    {
        user_name=[[UILabel alloc]initWithFrame:CGRectMake(88, 15, 150, 30)];
        user_name.text=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"name"]];
        [user_name setTextColor:[UIColor colorWithRed:(78/255.f) green:(39/255.f) blue:(14/255.f) alpha:1.0f]];
        [user_name setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:17]];
        [user_name setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:user_name];
        
        descriptiohn=[[UILabel alloc]initWithFrame:CGRectMake(88,40, 150, 30)];
      descriptiohn.text=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"business"]];
        [descriptiohn setTextColor:[UIColor whiteColor]];
        [descriptiohn setFont:[UIFont fontWithName:@"OpenSans" size:16]];
        [descriptiohn setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:descriptiohn];
        
//        time=[[UILabel alloc]initWithFrame:CGRectMake(88, 57, 150, 30)];
//        [time setText:@"5 min ago"];
//        [time setTextColor:[UIColor whiteColor]];
//        [time setFont:[UIFont fontWithName:@"OpenSans" size:15]];
//        [time setTextAlignment:NSTextAlignmentLeft];
//        [cell addSubview:time];
        
        NSString *Friend_Check=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"friend"]];
        
        if ([Friend_Check isEqualToString:@"F"])
        {
            AddFriendBtn=[[UIButton alloc]initWithFrame:CGRectMake(235, 53, 132, 37)];
            [AddFriendBtn setImage:[UIImage imageNamed:@"addfriend_button"] forState:UIControlStateNormal];
            [AddFriendBtn setTitle:[NSString stringWithFormat:@"addfriendbtn"] forState:UIControlStateNormal];
            AddFriendBtn.tag=indexPath.row;
            [AddFriendBtn addTarget:self action:@selector(AddFriendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:AddFriendBtn];
            
            ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(235, 13, 132, 37)];
            [ChatBtn setImage:[UIImage imageNamed:@"chat_button"] forState:UIControlStateNormal];
            [ChatBtn setTitle:[NSString stringWithFormat:@"chatbtn"] forState:UIControlStateNormal];
            ChatBtn.tag=indexPath.row;
            [ChatBtn addTarget:self action:@selector(ChatButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:ChatBtn];


        }
        else
        {
            ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(235,30, 132, 37)];
            [ChatBtn setImage:[UIImage imageNamed:@"chat_button"] forState:UIControlStateNormal];
            [ChatBtn setTitle:[NSString stringWithFormat:@"chatbtn"] forState:UIControlStateNormal];
            ChatBtn.tag=indexPath.row;
            [ChatBtn addTarget:self action:@selector(ChatButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:ChatBtn];

        }
    
        
        
        UIView *seperatorview=[[UIView alloc]initWithFrame:CGRectMake(0,99,self.view.frame.size.width,1)];
        seperatorview.backgroundColor=[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:0.3f];
        [cell addSubview:seperatorview];
        
        
        
        user_profile_image =[[UIImageView alloc] initWithFrame:CGRectMake(17,20,59,59)];
        [cell addSubview:user_profile_image];
        
        user_profile_image.layer.cornerRadius=(user_profile_image.frame.size.width)/2;
        user_profile_image.clipsToBounds=YES;
        user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
        
        if ([[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"sex"] isEqualToString:@"M"])
        {
            [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
        }
        else
        {
            [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
        }
        
    }
    else
    {
        user_name=[[UILabel alloc]initWithFrame:CGRectMake(78, 15, 150, 30)];
        user_name.text=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"name"]];
       [user_name setTextColor:[UIColor colorWithRed:(78/255.f) green:(39/255.f) blue:(14/255.f) alpha:1.0f]];
        [user_name setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:16]];
        [user_name setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:user_name];
        
        descriptiohn=[[UILabel alloc]initWithFrame:CGRectMake(78, 37, 150, 30)];
        descriptiohn.text=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"business"]];
        [descriptiohn setTextColor:[UIColor whiteColor]];
        [descriptiohn setFont:[UIFont fontWithName:@"OpenSans" size:15]];
        [descriptiohn setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:descriptiohn];
        
//        time=[[UILabel alloc]initWithFrame:CGRectMake(70, 57, 150, 30)];
//        [time setText:@"5 min ago"];
//        [time setTextColor:[UIColor whiteColor]];
//        [time setFont:[UIFont fontWithName:@"OpenSans" size:15]];
//        [time setTextAlignment:NSTextAlignmentLeft];
//        [cell addSubview:time];
        
          NSString *Friend_Check=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"friend"]];
        
        if ([Friend_Check isEqualToString:@"F"])
        {
            AddFriendBtn=[[UIButton alloc]initWithFrame:CGRectMake(205, 58, 107, 32)];
            [AddFriendBtn setImage:[UIImage imageNamed:@"addfriend_button"] forState:UIControlStateNormal];
            [AddFriendBtn setTitle:[NSString stringWithFormat:@"addfriendbtn"] forState:UIControlStateNormal];
            AddFriendBtn.tag=indexPath.row;
            [AddFriendBtn addTarget:self action:@selector(AddFriendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:AddFriendBtn];
            
            
            ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(205, 18, 107, 32)];
            [ChatBtn setImage:[UIImage imageNamed:@"chat_button"] forState:UIControlStateNormal];
            [ChatBtn setTitle:[NSString stringWithFormat:@"chatbtn"] forState:UIControlStateNormal];
            ChatBtn.tag=indexPath.row;
            [ChatBtn addTarget:self action:@selector(ChatButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:ChatBtn];


        }
        
        else
        {
            
            ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(205,35, 107, 32)];
            [ChatBtn setImage:[UIImage imageNamed:@"chat_button"] forState:UIControlStateNormal];
            [ChatBtn setTitle:[NSString stringWithFormat:@"chatbtn"] forState:UIControlStateNormal];
            ChatBtn.tag=indexPath.row;
            [ChatBtn addTarget:self action:@selector(ChatButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:ChatBtn];

        }
        
        
        UIView *seperatorview=[[UIView alloc]initWithFrame:CGRectMake(0,99,self.view.frame.size.width,1)];
        seperatorview.backgroundColor=[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:0.3f];
        [cell addSubview:seperatorview];
        
        
        
        
        user_profile_image =[[UIImageView alloc] initWithFrame:CGRectMake(12,20,59,59)];
        [cell addSubview:user_profile_image];
        
        user_profile_image.layer.cornerRadius=(user_profile_image.frame.size.width)/2;
        user_profile_image.clipsToBounds=YES;
        user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
        
        if ([[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"sex"] isEqualToString:@"M"])
        {
            [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
        }
        else
        {
            [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
        }
        
    }
    
     cell.backgroundColor=[UIColor clearColor];
     cell.selectionStyle=NO;
    
    BOOL contains = [remove_array containsObject:[Friend_list objectAtIndex:indexPath.row]];
    
    if (contains)
    {
 
        [AddFriendBtn removeFromSuperview];
        
    }
    
     return cell;
}

-(void)ChatButtonClicked:(UIButton*)sender
{

      ChatViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"chat_page"];
      Pushobj.getuser_id=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:sender.tag]objectForKey:@"id"]];
      [self.navigationController pushViewController:Pushobj animated:YES];
}

-(void)AddFriendButtonClicked:(UIButton*)sender
{
    
     NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    NSString *senderid = [UserData stringForKey:@"Login_User_id"];
    NSString *receiverid=[[Friend_list objectAtIndex:sender.tag]objectForKey:@"id"];
 
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    //NSString *urlstring=[NSString stringWithFormat:@"%@add_friend.php?send_id=%@&rec_id=%@",App_Domain_Url,senderid,receiverid];
    NSString *urlstring=[NSString stringWithFormat:@"%@add_friend.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@",senderid,receiverid];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];


    
    [globalobj GlobalDict:request Globalstr:@"string" Withblock:^(id result, NSError *error)
     {
         friendstr=result;
         NSLog(@"result-- %@",friendstr);
         
        
             if([result isEqual:@"already send"])
             {
                 
                 UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                                   message:@"Friend Request Already Sent"
                                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 [message show];
                 
                 
                 
             }
             else
             {
                 UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                                   message:@"Friend Request Sent"
                                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 [message show];
                 
                 
                 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
                 AddFriendTableViewCell *mycell = (AddFriendTableViewCell *)[_Friends_Table cellForRowAtIndexPath:indexPath];
                 
                 NSArray *subArray=[mycell subviews];
                 
                 for (UIButton *btn in subArray)
                     
                 {
                     
                     if ([btn isKindOfClass:[UIButton class]])
                         
                     {
                         
                         if (btn.tag==indexPath.row)
                         {
                             [remove_array addObject:[Friend_list objectAtIndex:indexPath.row]];
                             if([[btn currentTitle] isEqualToString:@"addfriendbtn"])
                             {
                                 
                                 [btn removeFromSuperview];
                             }
                         }
                         else
                         {
                             
                         }
                         
                     }
                 }
                 
                 
                 //[_Friends_Table reloadData];
                 
             }

         
         
         
     }];
  
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"User_info_page"];
    Pushobj.getuser_id=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"id"]];
    [self.navigationController pushViewController:Pushobj animated:YES];
    

    
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

- (IBAction)back_tomainPage:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
