//
//  SecuritySettingViewController.m
//  AiCafe
//
//  Created by Soumen on 09/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "SecuritySettingViewController.h"

@interface SecuritySettingViewController ()

@end

@implementation SecuritySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)BackToSetting:(id)sender {
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
