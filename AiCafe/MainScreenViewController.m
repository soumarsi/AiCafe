//
//  MainScreenViewController.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 21/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "MainScreenViewController.h"
#import "UIImageView+WebCache.h"
#import "RS_JsonClass.h"
#import "Side_menu.h"
#import "LoyaltiDetailsViewController.h"
#import "CouponScreenViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        _row_view1.frame=CGRectMake(_row_view1.frame.origin.x,_row_view1.frame.origin.y-7,_row_view1.frame.size.width,_row_view1.frame.size.height+7);
          _row_view2.frame=CGRectMake(_row_view2.frame.origin.x,_row_view2.frame.origin.y+1,_row_view2.frame.size.width,_row_view2.frame.size.height+6);
         _row_view3.frame=CGRectMake(_row_view3.frame.origin.x,_row_view3.frame.origin.y+1,_row_view3.frame.size.width,_row_view3.frame.size.height+5);
    }
    else
    {
        _row_view1.frame=CGRectMake(_row_view1.frame.origin.x,_row_view1.frame.origin.y-9,_row_view1.frame.size.width,_row_view1.frame.size.height-5);
        _row_view2.frame=CGRectMake(_row_view2.frame.origin.x,_row_view2.frame.origin.y+2,_row_view2.frame.size.width,_row_view2.frame.size.height-5);
        _row_view3.frame=CGRectMake(_row_view3.frame.origin.x,_row_view3.frame.origin.y+5,_row_view3.frame.size.width,_row_view3.frame.size.height-4);
    }
    
    
    /// Getting User Data from NSUserDefaults
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    user_image_data= [standardUserDefaults stringForKey:@"user_photo"];
    user_name_info= [standardUserDefaults stringForKey:@"User_name"];
    user_sex_info= [standardUserDefaults stringForKey:@"user_sex"];
    user_business_info= [standardUserDefaults stringForKey:@"user_business"];

    
    NSLog(@"### TEST MODE #### >>> %@",user_sex_info);
    
    /// Setting User Data
    
    
    _user_image.layer.cornerRadius=(_user_image.frame.size.width)/2;
    _user_image.clipsToBounds=YES;
    _user_image.contentMode=UIViewContentModeScaleAspectFill;
    
    
    if ([user_sex_info isEqualToString:@"M"])
    {
        [_user_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,user_sex_info]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        
    }
    else
    {
       [_user_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,user_sex_info]] placeholderImage:[UIImage imageNamed:@"PlaceholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        
    }
    
     _user_name.text=user_name_info;
    
    if ([user_sex_info isEqualToString:@"M"])
    {
        _user_sex.text=@"Male";
    }
    else
    {
        _user_sex.text=@"Female";
    }

    
    _user_business.text=user_business_info;
}

-(void)viewWillAppear:(BOOL)animated
{

    sidemenu=[[Side_menu alloc]init];
    sidemenu.frame=CGRectMake(-sidemenu.frame.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
    sidemenu.hidden=YES;
    [self.view addSubview:sidemenu];

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

- (IBAction)Add_friend_button:(id)sender
{
    MainScreenViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Addfriend_Page"];
    [self.navigationController pushViewController:Pushobj animated:YES];
}
- (IBAction)Side_button:(id)sender
{
    
//
//  sidemenu.hidden=NO;
//    
//  sidemenu.frame=CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width*0.7f,[UIScreen mainScreen].bounds.size.height);
//    
//     _baseView.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width*0.7f)-21,_baseView.frame.origin.y,_baseView.frame.size.width,_baseView.frame.size.height);
    
}
- (IBAction)PushToLoyaltiDetails:(id)sender {
    MainScreenViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Loyalti_Details"];
    [self.navigationController pushViewController:Pushobj animated:YES];
}
- (IBAction)PushToCouponScreen:(id)sender {
    MainScreenViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Coupon_Screen"];
    [self.navigationController pushViewController:Pushobj animated:YES];
}

@end
