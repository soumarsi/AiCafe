//
//  StoreInfoViewController.m
//  AiCafe
//
//  Created by ios on 12/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "StoreInfoViewController.h"

@interface StoreInfoViewController ()

@end

@implementation StoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)backtomainscreen:(id)sender
{
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

- (IBAction)In_Store_Users:(id)sender
{
    StoreInfoViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"Addfriend_Page"];
    [self.navigationController pushViewController:Pushobj animated:YES];
}
@end
