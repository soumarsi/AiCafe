//
//  LoyaltiDetailsViewController.m
//  AiCafe
//
//  Created by Soumen on 04/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "LoyaltiDetailsViewController.h"
#import "LoyaltiDetailsTableViewCell.h"

@interface LoyaltiDetailsViewController ()

@end

@implementation LoyaltiDetailsViewController

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
    LoyaltiDetailsTableViewCell *lcell=(LoyaltiDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Loyalti_Details_Cell"];
    return lcell;
}
- (IBAction)back_button:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
