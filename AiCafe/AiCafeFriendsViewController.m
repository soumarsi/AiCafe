//
//  AiCafeFriendsViewController.m
//  AiCafe
//
//  Created by Somenath on 25/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "AiCafeFriendsViewController.h"
#import "RS_PCH.pch"
#import "UIImageView+WebCache.h"
#import "ChatViewController.h"
#import "UserInfoViewController.h"
#import "MainScreenViewController.h"



@interface AiCafeFriendsViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *Friend_list;
    UILabel *user_name;
    UILabel *descriptiohn;
    UILabel *time;
    UIImageView *user_profile_image;
    UIButton *ChatBtn;
    UIImageView *online_status;
}
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation AiCafeFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    }

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    obj = [[RS_JsonClass alloc]init];
    
    list_value=10;
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    NSString *Login_user_Id = [UserData stringForKey:@"Login_User_id"];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@friend_list.php?id=%@&start=0&records=%d",App_Domain_Url,Login_user_Id,list_value];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [_spinner setHidden:NO];
    [_spinner startAnimating];
    [obj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
    {
        if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
        {
             [_spinner removeFromSuperview];
        }
        else
        {
            Friend_list=[[result objectForKey:@"details"] mutableCopy];
            NSLog(@"Array is:------>%@",result);
            NSLog(@"Array is:------>%@",Friend_list);
            [_Friends_Table reloadData];
            
            
           
            [_spinner setHidden:YES];

        }
        
         }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Friend_list count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
         
         NSLog(@">>>>>>>>>>>> %f",_Friends_Table.contentOffset.y);
    
    if (_Friends_Table.contentOffset.y>90)
    {
        NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
        NSString *Login_user_Id = [UserData stringForKey:@"Login_User_id"];
        
        NSString *urlstr = [NSString stringWithFormat:@"%@friend_list.php?id=%@&start=0&records=%d",App_Domain_Url,Login_user_Id,list_value+10];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
        
        [request setHTTPMethod:@"POST"];
        
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
       // [_spinner setHidden:NO];
      //  [_spinner startAnimating];
        [obj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
             {
                // [_spinner removeFromSuperview];
             }
             else
             {
                 Friend_list=[[result objectForKey:@"details"] mutableCopy];
                 NSLog(@"Array is:------>%@",result);
                 NSLog(@"Array is:------>%@",Friend_list);
                 [_Friends_Table reloadData];
                 
                 
                 
               //  [_spinner setHidden:YES];
                 
             }
             
         }];

    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellid";
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /// Puting Data in tableView
    
    if (self.view.frame.size.width == 320) {
        user_name=[[UILabel alloc]initWithFrame:CGRectMake(78, 20, 150, 30)];
        user_name.text=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"name"]];
        [user_name setTextColor:[UIColor colorWithRed:(78/255.f) green:(39/255.f) blue:(14/255.f) alpha:1.0f]];
        [user_name setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:16]];
        [user_name setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:user_name];
        
        descriptiohn=[[UILabel alloc]initWithFrame:CGRectMake(78, 46, 180, 30)];
        descriptiohn.text = [[Friend_list objectAtIndex:indexPath.row] valueForKey:@"about"];
        [descriptiohn setTextColor:[UIColor whiteColor]];
        [descriptiohn setFont:[UIFont fontWithName:@"OpenSans" size:15]];
        [descriptiohn setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:descriptiohn];
        
        
        UIView *seperatorview=[[UIView alloc]initWithFrame:CGRectMake(0,99,self.view.frame.size.width,1)];
        seperatorview.backgroundColor=[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:0.3f];
        [cell addSubview:seperatorview];
        
        user_profile_image =[[UIImageView alloc] initWithFrame:CGRectMake(10,20,59,59)];
        [cell addSubview:user_profile_image];
        
        user_profile_image.layer.cornerRadius=(user_profile_image.frame.size.width)/2;
        user_profile_image.clipsToBounds=YES;
        user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
        
        online_status = [[UIImageView alloc]initWithFrame:CGRectMake(58, 60, 10, 10)];
        online_status.image = [UIImage imageNamed:@"online"];
        [cell addSubview:online_status];
        
       // ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(220, 13, 91, 31)];
        ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(220, 30, 91, 31)];
        [ChatBtn setImage:[UIImage imageNamed:@"chat_button"] forState:UIControlStateNormal];
        [ChatBtn setTitle:[NSString stringWithFormat:@"chatbtn"] forState:UIControlStateNormal];
        ChatBtn.tag=indexPath.row;
        [ChatBtn addTarget:self action:@selector(ChatButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:ChatBtn];
    }
    else
    {
        user_name=[[UILabel alloc]initWithFrame:CGRectMake(83, 23, 150, 30)];
        user_name.text=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"name"]];
        [user_name setTextColor:[UIColor colorWithRed:(78/255.f) green:(39/255.f) blue:(14/255.f) alpha:1.0f]];
        [user_name setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:16]];
        [user_name setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:user_name];
        
        descriptiohn=[[UILabel alloc]initWithFrame:CGRectMake(84, 45, 300, 30)];
        descriptiohn.text = [[Friend_list objectAtIndex:indexPath.row] valueForKey:@"about"];
        [descriptiohn setTextColor:[UIColor whiteColor]];
        [descriptiohn setFont:[UIFont fontWithName:@"OpenSans" size:15]];
        [descriptiohn setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:descriptiohn];
        
        
        UIView *seperatorview=[[UIView alloc]initWithFrame:CGRectMake(0,99,self.view.frame.size.width,1)];
        seperatorview.backgroundColor=[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:0.3f];
        [cell addSubview:seperatorview];
        
        user_profile_image =[[UIImageView alloc] initWithFrame:CGRectMake(17,20,59,59)];
        [cell addSubview:user_profile_image];
        
        user_profile_image.layer.cornerRadius=(user_profile_image.frame.size.width)/2;
        user_profile_image.clipsToBounds=YES;
        user_profile_image.contentMode=UIViewContentModeScaleAspectFill;
        
        online_status = [[UIImageView alloc]initWithFrame:CGRectMake(65, 60, 10, 10)];
        online_status.image = [UIImage imageNamed:@"online"];
        [cell addSubview:online_status];
        
        CGFloat x = self.view.frame.size.width *.65;
        
        //ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(x, 13, 115, 35)];
        ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(x, 30, 115, 35)];
        [ChatBtn setImage:[UIImage imageNamed:@"chat_button"] forState:UIControlStateNormal];
        [ChatBtn setTitle:[NSString stringWithFormat:@"chatbtn"] forState:UIControlStateNormal];
        ChatBtn.tag=indexPath.row;
        [ChatBtn addTarget:self action:@selector(ChatButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:ChatBtn];
    }
        
        if ([[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"sex"] isEqualToString:@"M"])
        {
            [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        }
        else
        {
            [user_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        }
    
        if ([[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"online"] isEqualToString:@"T"])
        {
            [online_status setHidden:NO];
        }
        else
        {
            [online_status setHidden:YES];
        }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    AiCafeFriendsDetailViewController *det=[self.storyboard instantiateViewControllerWithIdentifier:@"aicafefriendsdetail"];
//    
//    det.frienddetaildic = [Friend_list objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:det animated:YES];
    
    UserInfoViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"User_info_page"];
    Pushobj.getuser_id=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"id"]];
    [self.navigationController pushViewController:Pushobj animated:YES];

}

-(void)ChatButtonClicked:(UIButton*)sender
{
    
    ChatViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"chat_page"];
    Pushobj.getuser_id=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:sender.tag]objectForKey:@"id"]];
    [self.navigationController pushViewController:Pushobj animated:YES];
    
}

- (IBAction)backTapped:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    for (UIViewController* viewController in self.navigationController.viewControllers)
    {
        
        if ([viewController isKindOfClass:[MainScreenViewController class]] )
        {
            
            MainScreenViewController *MainScreenObj = (MainScreenViewController*)viewController;
            [self.navigationController popToViewController:MainScreenObj animated:YES];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
