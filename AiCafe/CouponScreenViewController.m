//
//  CouponScreenViewController.m
//  AiCafe
//
//  Created by Soumen on 04/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "CouponScreenViewController.h"
#import "CouponScreenTableViewCell.h"
#import "Side_menu.h"
@interface CouponScreenViewController ()<Slide_menu_delegate>
{
    BOOL flag;
}
@end

@implementation CouponScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag=YES;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponScreenTableViewCell *cscell=(CouponScreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Coupon_Screen_Cell"];
    return cscell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"couponredeem"];
    
    [self.navigationController pushViewController:obj animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    //    sidemenu=[[Side_menu alloc]init];
    //    sidemenu.frame=CGRectMake(-sidemenu.frame.size.width,0,sidemenu.frame.size.width,[UIScreen mainScreen].bounds.size.height);
    //    sidemenu.hidden=YES;
    //    [self.view addSubview:sidemenu];
    if(flag==YES)
    {
        flag=YES;
        NSLog(@"viewwillappear");
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
        
        CouponScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"settingviewcontroller"];
        //  [self showAnimation2];
        //[self presentViewController:obj animated:YES completion:nil];
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
        //[self showAnimation2];
    }
    else if (sender.tag==8)
    {
        CouponScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"aboutviewcontroller"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
    else if (sender.tag==1)
    {
        CouponScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"Main_Page"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
    else if (sender.tag==5)
    {
        CouponScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"addcoupon"];
        
        [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
    else if (sender.tag==2)
    {
        CouponScreenViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"storeinformation"];
        
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
