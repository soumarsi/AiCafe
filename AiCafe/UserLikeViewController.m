//
//  UserLikeViewController.m
//  AiCafe
//
//  Created by ios on 17/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "UserLikeViewController.h"

@interface UserLikeViewController ()

@end

@implementation UserLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.UserLikeTabView.delegate=self;
    self.UserLikeTabView.dataSource=self;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserLikeTableViewCell *cell=[[UserLikeTableViewCell alloc]init];
    cell.timeLabel.text = @"5 min ago";
    cell.username.text = @"Emma Rosalie";
    cell.usertxt.text = @"Voluptatem Quia";
    cell.backgroundColor=[UIColor clearColor];
    return cell;
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
