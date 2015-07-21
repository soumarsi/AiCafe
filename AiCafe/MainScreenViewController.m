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
#import "ChatInboxViewController.h"
#import "Side_menu.h"
#import "ViewController.h"
#import "AiCafeFriendsViewController.h"
#import "ChatInboxViewController.h"
#import "FriendRequestViewController.h"


@interface MainScreenViewController ()<Slide_menu_delegate>
{
    BOOL flag;
    NSMutableArray *Friend_list;
}
@property (strong, nonatomic) IBOutlet UILabel *numberoffriends;
@end

@implementation MainScreenViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag=YES;
    
    obj = [[RS_JsonClass alloc]init];
    
    if ([UIScreen mainScreen].bounds.size.width>400)
    {
        _row_view1.frame=CGRectMake(_row_view1.frame.origin.x,_row_view1.frame.origin.y+6,_row_view1.frame.size.width,_row_view1.frame.size.height+10);
          _row_view2.frame=CGRectMake(_row_view2.frame.origin.x,_row_view2.frame.origin.y+8,_row_view2.frame.size.width,_row_view2.frame.size.height+9);
         _row_view3.frame=CGRectMake(_row_view3.frame.origin.x,_row_view3.frame.origin.y+1,_row_view3.frame.size.width,_row_view3.frame.size.height+8);
    }
   else if ([UIScreen mainScreen].bounds.size.width>320)
    {
        _row_view1.frame=CGRectMake(_row_view1.frame.origin.x,_row_view1.frame.origin.y-7,_row_view1.frame.size.width,_row_view1.frame.size.height+7);
        _row_view2.frame=CGRectMake(_row_view2.frame.origin.x,_row_view2.frame.origin.y+1,_row_view2.frame.size.width,_row_view2.frame.size.height+6);
        _row_view3.frame=CGRectMake(_row_view3.frame.origin.x,_row_view3.frame.origin.y+1,_row_view3.frame.size.width,_row_view3.frame.size.height+5);    }

    else
    {
        _row_view1.frame=CGRectMake(_row_view1.frame.origin.x,_row_view1.frame.origin.y-9,_row_view1.frame.size.width,_row_view1.frame.size.height-5);
        _row_view2.frame=CGRectMake(_row_view2.frame.origin.x,_row_view2.frame.origin.y+2,_row_view2.frame.size.width,_row_view2.frame.size.height-5);
        _row_view3.frame=CGRectMake(_row_view3.frame.origin.x,_row_view3.frame.origin.y+5,_row_view3.frame.size.width,_row_view3.frame.size.height-4);
    }
    
    
    /// Getting User Data from NSUserDefaults
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    user_image_data= [standardUserDefaults stringForKey:@"photo_thumb"];
    userDP=[standardUserDefaults stringForKey:@"user_photo_mainScreen"];//user_photo_mainScreen
    user_name_info= [standardUserDefaults stringForKey:@"User_name"];
    user_sex_info= [standardUserDefaults stringForKey:@"user_sex"];
    user_business_info= [standardUserDefaults stringForKey:@"user_business"];

    
    NSLog(@"### TEST MODE #### >>> %@",user_sex_info);
    
    /// Setting User Data
    
    
    _user_image.layer.cornerRadius=(_user_image.frame.size.width)/2;
    _user_image.clipsToBounds=YES;
    _user_image.contentMode=UIViewContentModeScaleAspectFill;
    
    
    
     _user_name.text=user_name_info;
    
    if ([user_sex_info isEqualToString:@"M"])
    {
        _user_sex.text=@"Male";
        
        [_user_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,userDP]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
    }
    else
    {
        _user_sex.text=@"Female";
        
        [_user_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,userDP]] placeholderImage:[UIImage imageNamed:@"PlaceholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        

    }

    
    _user_business.text=user_business_info;
    
    obj = [[RS_JsonClass alloc]init];
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    NSString *Login_user_Id = [UserData stringForKey:@"Login_User_id"];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@friend_list.php?id=%@",App_Domain_Url,Login_user_Id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    [obj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
    {
        if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
        {
            
        }
        else
        {
            Friend_list=[[result objectForKey:@"details"] mutableCopy];
            NSLog(@"Array is:------>%@",result);
            NSLog(@"Array is:------>%@",Friend_list);
            _numberoffriends.text = [NSString stringWithFormat:@"%ld  friends",(long)[Friend_list count]];
        }
        
       
    }];

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
    AiCafeFriendsViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"aicafefriends"];
    
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
                                
                        
                          
    [sidemenu setFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width*0.7f,[UIScreen mainScreen].bounds.size.height)];
                                
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
-(void)viewDidDisappear:(BOOL)animated
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
- (IBAction)PushToLoyaltiDetails:(id)sender {
    MainScreenViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Loyalti_Details"];
    //[self.navigationController pushViewController:Pushobj animated:YES];
    [self PushViewController:Pushobj WithAnimation:kCAMediaTimingFunctionEaseIn];

}
- (IBAction)PushToCouponScreen:(id)sender {
//    MainScreenViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Coupon_Screen"];
//    //[self.navigationController pushViewController:Pushobj animated:YES];
//    [self PushViewController:Pushobj WithAnimation:kCAMediaTimingFunctionEaseIn];
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
        
        MainScreenViewController *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"settingviewcontroller"];
       
        //[self presentViewController:obj animated:YES completion:nil];
        [self PushViewController:obj1 WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else if (sender.tag==8)
    {
        MainScreenViewController *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"aboutviewcontroller"];
        
        [self PushViewController:obj1 WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
    else if (sender.tag==1)
    {
        MainScreenViewController *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"Main_Page"];
        
        [self PushViewController:obj1 WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
    else if (sender.tag==5)
    {
//        MainScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"addcoupon"];
//        
//        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
    else if (sender.tag==2)
    {
        MainScreenViewController *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"storeinformation"];
        
        [self PushViewController:obj1 WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    else if (sender.tag==3)
    {
        ChatRoomViewController *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatRoomViewControllersid"];
        
        [self PushViewController:obj1 WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    else if (sender.tag==6)
    {
        MainScreenViewController *obj1=[self.storyboard instantiateViewControllerWithIdentifier:@"frndrequest"];
        
        [self PushViewController:obj1 WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    else if (sender.tag==9)
    {
        //MainScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"aboutviewcontroller"];
        
        //[self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        NSLog(@"##### test mode...%ld",(long)sender.tag);
        RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
        
        NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
        NSString *senderid = [UserData stringForKey:@"Login_User_id"];
        
        NSString *urlstring=[NSString stringWithFormat:@"http://203.196.159.37/lab9/aiCafe/iosapp/logout.php"];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        
        [request setHTTPMethod:@"POST"];
        
        NSString *postData = [NSString stringWithFormat:@"id=%@",senderid];
        
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        
        [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
            
             if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
             {
                 
             }
             else
             {
                 NSLog(@"result...%@",[result objectForKey:@"auth"]);
                 if([[result objectForKey:@"auth"] isEqualToString:@"logout success"])
                 {
                     ViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Login_Page"];
                     Pushobj.password.text=@"";
                     [self.navigationController pushViewController:Pushobj animated:YES];
                     
                 }

             }
             
             
             
         }];
        
        
    }

    
    
    //}];
}
-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.4f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [Transition setType:AnimationType];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] pushViewController:viewController animated:NO];
}

- (IBAction)MoveToInbox:(id)sender
{
    ChatInboxViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"inbox"];
    [self.navigationController pushViewController:Pushobj animated:YES];
}


@end
