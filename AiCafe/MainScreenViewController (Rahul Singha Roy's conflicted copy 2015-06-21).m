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
#import "Side_menu.h"

@interface MainScreenViewController ()<Slide_menu_delegate>
{
    BOOL flag;
}
@end

@implementation MainScreenViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag=YES;
    
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

    if(flag==YES)
    {
        flag=YES;
        sidemenu=[[Side_menu alloc]init];
        sidemenu.frame=CGRectMake(-sidemenu.frame.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
        sidemenu.hidden=YES;
        sidemenu.SlideDelegate=self;
        [self.view addSubview:sidemenu];
    }
    else
    {
        flag=NO;
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

- (IBAction)Add_friend_button:(id)sender
{
    MainScreenViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Addfriend_Page"];
    [self.navigationController pushViewController:Pushobj animated:YES];
}
- (IBAction)Side_button:(id)sender
{
    
    
    if(flag==YES)
    {
        flag=NO;
        sidemenu.hidden=NO;
        

        [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.6
                            options:1 animations:^{
                                
                          
    sidemenu.frame=CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width*0.7f,[UIScreen mainScreen].bounds.size.height);
        _baseView.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width*0.7f)-21,_baseView.frame.origin.y,_baseView.frame.size.width,_baseView.frame.size.height);

                                
                            }
         
                         completion:^(BOOL finished)
         {
             
            
             
         }];

        
        
        
    }
    else
    {
        flag=YES;
        
        
        
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.6
                            options:1 animations:^{
                                
                                
        sidemenu.frame=CGRectMake(-[UIScreen mainScreen].bounds.size.width*0.7f,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
                                
        _baseView.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width)-20,_baseView.frame.origin.y,_baseView.frame.size.width,_baseView.frame.size.height);
                                
                                
                            }
         
                         completion:^(BOOL finished)
         {
             
             
             
         }];
        
    }

    
}
- (IBAction)PushToLoyaltiDetails:(id)sender {
    MainScreenViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Loyalti_Details"];
    //[self.navigationController pushViewController:Pushobj animated:YES];
    [self PushViewController:Pushobj WithAnimation:kCAMediaTimingFunctionEaseIn];

}
- (IBAction)PushToCouponScreen:(id)sender {
    MainScreenViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Coupon_Screen"];
    //[self.navigationController pushViewController:Pushobj animated:YES];
    [self PushViewController:Pushobj WithAnimation:kCAMediaTimingFunctionEaseIn];
}

-(void)action_method:(UIButton *)sender
{
    NSLog(@"##### test mode...%ld",(long)sender.tag);
    NSLog(@"action_method");
    
    //    [UIView transitionWithView:sidemenu
    //                      duration:0.5f
    //                       options:UIViewAnimationOptionTransitionNone
    //                    animations:^{
    //
    //                       // overlay.hidden=YES;
    //                        sidemenu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
    //
    //                    }
    //
    //                    completion:^(BOOL finished)
    //     {
    //
    //         sidemenu.hidden=YES;
    //        overlay.userInteractionEnabled=NO;
    
    
    //         if (sender.tag==1)
    //         {
    //             MainScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Invite_Friend"];
    //             [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    //         }
    //sidemenu.hidden=YES;
    if (sender.tag==7)
    {
        
        MainScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingviewcontroller"];
       
        //[self presentViewController:obj animated:YES completion:nil];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==8)
    {
        MainScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"aboutviewcontroller"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
    else if (sender.tag==1)
    {
        MainScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Main_Page"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
    else if (sender.tag==5)
    {
        MainScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"addcoupon"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
    else if (sender.tag==2)
    {
        MainScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"storeinformation"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    }

    
    
    //}];
}
-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.5f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [Transition setType:AnimationType];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] pushViewController:viewController animated:NO];
}



@end
