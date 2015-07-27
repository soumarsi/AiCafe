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

    
    cell.selectionStyle=NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    
    [UIView transitionWithView:selectedCell duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        self.view.userInteractionEnabled=NO;
                        
                        selectedCell.layer.masksToBounds = NO;
                        selectedCell.layer.cornerRadius = 8;
                        selectedCell.layer.shadowOffset = CGSizeMake(-19,12);
                        selectedCell.layer.shadowRadius = 5;
                        selectedCell.layer.shadowOpacity = 0.5;

                    }
                    completion:^(BOOL finished) {
                        
                        [UIView transitionWithView:selectedCell duration:1
                                           options:UIViewAnimationOptionTransitionNone
                                        animations:^{
                                            
                             [selectedCell setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width,selectedCell.frame.origin.y, selectedCell.frame.size.width, selectedCell.frame.size.height)];
                                            
                                        }
                                        completion:^(BOOL finished) {
                                            
                                            selectedCell.hidden=YES;
                                            
                                             selectedCell.layer.shadowOpacity = 0.0;
                                            
                                            
                                            RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
                                            
                                            NSString *urlstring=[NSString stringWithFormat:@"%@unblock_user.php",App_Domain_Url];
                                            
                                            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
                                            
                                            [request setHTTPMethod:@"POST"];
                                            
                                            NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
                                            NSString *login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
                                            NSString *postData = [NSString stringWithFormat:@"id=%@&block_id=%@",login_user_id,[[blockarray objectAtIndex:indexPath.row]objectForKey:@"id"]];
                                            
                                         
                                            
                                            [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                                            
                                            [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
                                            
                                            
                                            [globalobj GlobalDict:request Globalstr:@"string" Withblock:^(id result, NSError *error)
                                             {
                                                 [blockarray removeObjectAtIndex:indexPath.row];
                                                 
                                                 [_BlockListTabview reloadData];

                                                 
                                                   self.view.userInteractionEnabled=YES;
                                                 
                    
                                                 NSLog(@">>>R3$|_||_T######>>>>> %@",result);
                                                 
                                             }];

                                            
                                        }];

                        
                     
                        
                    }];
    
   
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
