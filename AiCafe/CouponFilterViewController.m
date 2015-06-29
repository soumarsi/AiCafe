//
//  CouponFilterViewController.m
//  AiCafe
//
//  Created by ios on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "CouponFilterViewController.h"
#import "CouponFilterTableViewCell.h"

@interface CouponFilterViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CouponFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabview.delegate=self;
    self.tabview.dataSource=self;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponFilterTableViewCell *cell=(CouponFilterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"couponfilter"];
    
    [cell.contentView bringSubviewToFront:tableView];
    return  cell;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"#############");
    
    CouponFilterViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"couponredeem"];
    
    [self.navigationController pushViewController:obj animated:YES];
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

@end
