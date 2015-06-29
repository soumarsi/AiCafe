//
//  CouponScreenViewController.m
//  AiCafe
//
//  Created by Soumen on 04/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "CouponScreenViewController.h"
#import "CouponScreenTableViewCell.h"

@interface CouponScreenViewController ()

@end

@implementation CouponScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)side_menu:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
