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
    
     RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@user_listing.php",App_Domain_Url];
    
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
    
         Friend_list=[[NSMutableArray alloc]init];
         Friend_list=[[result objectForKey:@"details"] mutableCopy];
         
         NSLog(@"result-- %@",Friend_list);
         
         [_Friends_Table reloadData];
         
     }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Show_Network_Status:)
                                                 name:@"no_internet" object:nil];

}

- (void)Show_Network_Status:(NSNotification *)note
{
    
    UIAlertView *errorAlrt=[[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Please Check Your Wi/Fi or 3G Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlrt show];
    
    [_Friends_Table setHidden:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Friend_list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                           forIndexPath:indexPath];

    /// Puting Data in tableView
    
    cell.user_profile_image.layer.cornerRadius=(cell.user_profile_image.frame.size.width)/2;
    cell.user_profile_image.clipsToBounds=YES;
    cell.user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
    
    if ([[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"sex"] isEqualToString:@"M"])
    {
        [cell.user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        

    }
    else
    {
        [cell.user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        

    }
    
    
    //--
    
    cell.user_name.text=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"name"]];
    
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=NO;
    return cell;
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
