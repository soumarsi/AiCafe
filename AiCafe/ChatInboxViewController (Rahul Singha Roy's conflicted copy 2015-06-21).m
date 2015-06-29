//
//  ChatInboxViewController.m
//  AiCafe
//
//  Created by ios on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ChatInboxViewController.h"
#import "ChatInboxTableViewCell.h"

@interface ChatInboxViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ChatInboxViewController

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
    ChatInboxTableViewCell *cell=(ChatInboxTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chatinbox"];
    return  cell;
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
