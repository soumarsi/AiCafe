//
//  ChatInboxViewController.m
//  AiCafe
//
//  Created by ios on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ChatInboxViewController.h"
#import "ChatInboxTableViewCell.h"
#import "RS_JsonClass.h"
#import "UIImageView+WebCache.h"
#import "UserInfoViewController.h"
#import "ChatInboxViewController.h"
#import "ChatInboxTableViewCell.h"
#import "RS_JsonClass.h"
#import "UIImageView+WebCache.h"
#import "ChatViewController.h"


@interface ChatInboxViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *Friend_list;
    UIButton *ChatBtn;
}

@end

@implementation ChatInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabview.delegate=self;
    self.tabview.dataSource=self;
    // Do any additional setup after loading the view.
    
    obj = [[RS_JsonClass alloc]init];
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    NSString *Login_user_Id = [UserData stringForKey:@"Login_User_id"];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@friend_list.php?id=%@",App_Domain_Url,Login_user_Id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
        [obj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
         {
             
         }
         else
         {
            Friend_list=[[NSMutableArray alloc]init];
            Friend_list=[[result objectForKey:@"details"] mutableCopy];
            
            [_tabview reloadData];
         }
         
       
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Friend_list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatInboxTableViewCell *cell=(ChatInboxTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chatinbox"];

    
    if ([[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"sex"] isEqualToString:@"M"])
    {
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    }
    else
    {
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    }
    
    
    
    cell.username.text = [[Friend_list objectAtIndex:indexPath.row]objectForKey:@"name"];
    cell.msg.text = [[Friend_list objectAtIndex:indexPath.row] objectForKey:@"last_chat"];
    
    [cell.chatbutton addTarget:self action:@selector(ChatButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if (self.view.frame.size.width == 320)
//    {
//        ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(220, 13, 91, 31)];
//        [ChatBtn setImage:[UIImage imageNamed:@"chat_button"] forState:UIControlStateNormal];
//        [ChatBtn setTitle:[NSString stringWithFormat:@"chatbtn"] forState:UIControlStateNormal];
//        ChatBtn.tag=indexPath.row;
//        [ChatBtn addTarget:self action:@selector(ChatButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:ChatBtn];
//    }
//    else
//    {
//        CGFloat x = self.view.frame.size.width *.65;
//    
//        ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(x, 13, 115, 35)];
//        [ChatBtn setImage:[UIImage imageNamed:@"chat_button"] forState:UIControlStateNormal];
//        [ChatBtn setTitle:[NSString stringWithFormat:@"chatbtn"] forState:UIControlStateNormal];
//        ChatBtn.tag=indexPath.row;
//        [ChatBtn addTarget:self action:@selector(ChatButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:ChatBtn];
//    }

    NSString *online_check=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"online"]];
    
    if ([online_check isEqualToString:@"T"])
    {
        [cell.online_status setHidden:NO];
    }
    else
    {
        [cell.online_status setHidden:YES];
    }
    return  cell;
}



-(void)ChatButtonClicked:(UIButton*)sender
{
    
    ChatViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"chat_page"];
    Pushobj.getuser_id=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:sender.tag]objectForKey:@"id"]];
    [self.navigationController pushViewController:Pushobj animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSLog(@"didSelectRowAtIndexPath");
        UserInfoViewController *Pushobj=[self.storyboard instantiateViewControllerWithIdentifier:@"User_info_page"];
        Pushobj.getuser_id=[NSString stringWithFormat:@"%@",[[Friend_list objectAtIndex:indexPath.row]objectForKey:@"id"]];
    [self.navigationController pushViewController:Pushobj animated:YES];
}

- (IBAction)BackToMainScreen:(id)sender
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
