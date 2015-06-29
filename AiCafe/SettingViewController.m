//
//  SettingViewController.m
//  AiCafe
//
//  Created by Soumen on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)PushToSecuritySettings:(id)sender {
    
    SettingViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"securitysettingviewcontroller"];
    [self.navigationController pushViewController:Pushobj animated:YES];

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

@end
