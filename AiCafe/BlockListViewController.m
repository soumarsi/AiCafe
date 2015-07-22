//
//  BlockListViewController.m
//  AiCafe
//
//  Created by ios on 21/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "BlockListViewController.h"
#import "BlockListTableViewCell.h"
#import "RS_JsonClass.h"
#import "UIImageView+WebCache.h"

@interface BlockListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BlockListViewController
@synthesize blockarray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BlockListTabview.delegate=self;
    self.BlockListTabview.dataSource=self;
    
    NSLog(@"output...%@",blockarray);
    
    
    [_BlockListTabview reloadData];
    
    
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [blockarray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlockListTableViewCell *cell=(BlockListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"block_list"];
    
    [cell.user_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[blockarray objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    
    cell.user_image.layer.cornerRadius=(cell.user_image.frame.size.width)/2;
    cell.user_image.clipsToBounds=YES;
    
    cell.username.text=[NSString stringWithFormat:@"%@",[[blockarray objectAtIndex:indexPath.row]objectForKey:@"name"]];
    
    cell.details.text=[NSString stringWithFormat:@"%@",[[blockarray objectAtIndex:indexPath.row]objectForKey:@"about"]];

    
    
    return cell;
}

- (IBAction)back_button:(id)sender
{
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
