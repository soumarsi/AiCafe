//
//  ChatViewController.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ChatViewController.h"
#import "UIImageView+WebCache.h"
#import "RS_JsonClass.h"
@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

    _chat_table.backgroundColor=[UIColor clearColor];
    
    _chatbox.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.6];
    _chatbox.font=[UIFont fontWithName:@"OpenSans" size:16];

    _chatbox.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
//      NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
//    login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
    
    login_user_id=@"10";
    
    NSString *urlstring=[NSString stringWithFormat:@"%@chat_view.php?send_id=10&rec_id=25&limit=23&page=2",App_Domain_Url];
    
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         chat_Data_array=[[NSMutableArray alloc]init];
         chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
         
         NSLog(@"Chat Data-- %@",chat_Data_array);
         
         
         [_chat_table reloadData];
         
         
     }];


}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.4 animations:^{
        
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x, _chatbox.frame.origin.y-220,_chatbox.frame.size.width, _chatbox.frame.size.height)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x, _send_button.frame.origin.y-220,_send_button.frame.size.width, _send_button.frame.size.height)];
        
          [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, _clip_button.frame.origin.y-220,27,56)];

    }];
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    
//    const char * _char = [text cStringUsingEncoding:NSUTF8StringEncoding];
//    int isBackSpace = strcmp(_char, "\b");
//    
//    if (isBackSpace == -8)
//    {
//        NSLog(@"BackSpace .... ");
//    }
//
//

    
    if ( [text isEqualToString:@"\n"] ) {
        
        NSLog(@"Changing line .....%f",_chatbox.frame.size.height);
        
        if (_chatbox.frame.size.height<150)
        {
            
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x, _chatbox.frame.origin.y-25,_chatbox.frame.size.width, _chatbox.frame.size.height+25)];
        }
        else
        {
//                CGRect frame = _chatbox.frame;
//                frame.size.height = _chatbox.contentSize.height;
//                _chatbox.frame = frame;
        }
        
        
    }
    
   
    
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chat_Data_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
 
    
    NSString *id_string=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"send_from"]];
                         
    NSLog(@"##### Test ID...%@",id_string);
    
//    chatView=[[UIView alloc]initWithFrame:CGRectMake(40,5, cell.frame.size.width-50, 65)];
//    chatView.layer.cornerRadius=10;
//    chatView.backgroundColor=[UIColor clearColor];
//    [cell addSubview: chatView];
//    


    
    if ([login_user_id isEqualToString:id_string])
    {
        
        
        chat_person_image=[[UIImageView alloc]initWithFrame:CGRectMake(0,+10, 75,75)];
        chat_person_image.layer.cornerRadius=(75.0f/2.0f);
        chat_person_image.clipsToBounds=YES;
        chat_person_image.contentMode=UIViewContentModeScaleAspectFill;
        
        [cell addSubview:chat_person_image];
        
        
        [chat_person_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];

        
        chat_design=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x+55,5,[UIScreen mainScreen].bounds.size.width-60,80)];
        
        [cell addSubview:chat_design];

        
        chat_design.image=[UIImage imageNamed:@"chat_design_img"];
        
    
        
        user_name=[[UILabel alloc]initWithFrame:CGRectMake(47,5, 150, 20)];
        user_name.textColor=[UIColor colorWithRed:(204.0f/255.0f) green:(162.0f/255.0f) blue:(102.0f/255.0f) alpha:1];
        user_name.font=[UIFont fontWithName:@"OpenSans-Semibold" size:17];
        user_name.textAlignment=NSTextAlignmentLeft;
        user_name.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"name"]];
        [chat_design addSubview:user_name];
        
        
        time=[[UILabel alloc]initWithFrame:CGRectMake(chat_design.frame.size.width-60,5, 150, 20)];
        time.textColor=[UIColor colorWithRed:(204.0f/255.0f) green:(162.0f/255.0f) blue:(102.0f/255.0f) alpha:1];
        time.font=[UIFont fontWithName:@"OpenSans-Semibold" size:15];
        time.textAlignment=NSTextAlignmentLeft;
        time.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"chat_date"]];
        [chat_design addSubview:time];

        
        message=[[UILabel alloc]initWithFrame:CGRectMake(47,45, 150, 20)];
        message.textColor=[UIColor whiteColor];
        message.font=[UIFont fontWithName:@"OpenSans-Semibold" size:16];
        message.textAlignment=NSTextAlignmentLeft;
        message.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"message"]];
        [chat_design addSubview:message];
        



    }
    else
    {
        
        chat_person_image=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-chat_person_image.frame.size.width,+10, 75,75)];
        chat_person_image.layer.cornerRadius=(75.0f/2.0f);
        chat_person_image.clipsToBounds=YES;
        chat_person_image.contentMode=UIViewContentModeScaleAspectFill;
        
        [cell addSubview:chat_person_image];
        
        
        [chat_person_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];

        
        chat_design=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x+5,5,[UIScreen mainScreen].bounds.size.width-60,80)];
        
        [cell addSubview:chat_design];

          chat_design.image=[UIImage imageNamed:@"chat_design_img2"];
        
        
        user_name=[[UILabel alloc]initWithFrame:CGRectMake(15,5, 150, 20)];
        user_name.textColor=[UIColor colorWithRed:(204.0f/255.0f) green:(162.0f/255.0f) blue:(102.0f/255.0f) alpha:1];
        user_name.font=[UIFont fontWithName:@"OpenSans-Semibold" size:17];
        user_name.textAlignment=NSTextAlignmentLeft;
        user_name.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"name"]];
        [chat_design addSubview:user_name];
        
        message=[[UILabel alloc]initWithFrame:CGRectMake(15,45, 150, 20)];
        message.textColor=[UIColor blackColor];
        message.font=[UIFont fontWithName:@"OpenSans-Semibold" size:16];
        message.textAlignment=NSTextAlignmentLeft;
        message.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"message"]];
        [chat_design addSubview:message];

        
        
        time=[[UILabel alloc]initWithFrame:CGRectMake(chat_design.frame.size.width-80,5, 150, 20)];
        time.textColor=[UIColor colorWithRed:(204.0f/255.0f) green:(162.0f/255.0f) blue:(102.0f/255.0f) alpha:1];
        time.font=[UIFont fontWithName:@"OpenSans-Semibold" size:15];
        time.textAlignment=NSTextAlignmentLeft;
        time.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"chat_date"]];
        [chat_design addSubview:time];
      
    }

    
    
    
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=NO;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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

- (IBAction)send_button:(id)sender
{
    [_chatbox resignFirstResponder];
    
    if (_chatbox.text.length==0)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-56,_chatbox.frame.size.width, 56)];
            
            [_send_button setFrame:CGRectMake(_send_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height,_send_button.frame.size.width, _send_button.frame.size.height)];
            
            [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-56,27,56)];
        }];

    }
    else
    {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_chatbox.frame.size.height,_chatbox.frame.size.width, _chatbox.frame.size.height)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height,_send_button.frame.size.width, _send_button.frame.size.height)];
        
         [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-56,27,56)];
    }];

    }
  
    
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    //      NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    //    login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
    
    
    NSString *chattext=[_chatbox.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (chattext.length==0)
    {
        
    }
    else
    {
    
    login_user_id=@"10";
    
    NSString *urlstring=[NSString stringWithFormat:@"%@sendChatUser.php?send_id=10&rec_id=25&message=%@",App_Domain_Url,chattext];
    
    [globalobj GlobalDict:urlstring Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         chat_Data_array=[[NSMutableArray alloc]init];
         chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
         
         NSLog(@"Send Chat -- %@",chat_Data_array);
         
         
         [_chat_table reloadData];
         
         
     }];

    }

}
@end
