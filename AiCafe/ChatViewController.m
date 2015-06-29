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
#import "stickercell.h"

@interface ChatViewController ()<UITextFieldDelegate>
{
    NSInteger flag;
    NSInteger charcount;
    NSInteger myflag;
    CGFloat kwheight;
    NSInteger i;
    stickercell *cell;
    NSInteger up;
}
@end

@implementation ChatViewController
#define kCellsPerRow 4
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    flag=1;
    myflag=0;
    i=5;
    up=0;
    
    keyboard=0;
    
    _chat_table.backgroundColor=[UIColor clearColor];
    
    _chatbox.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.6];
    _chatbox.font=[UIFont fontWithName:@"OpenSans" size:16];
    
    _chatbox.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
    
    //    login_user_id=@"10";
    
    //NSString *urlstring=[NSString stringWithFormat:@"%@chat_view.php?send_id=%@&rec_id=%@&start=0&end=70",App_Domain_Url,login_user_id,_getuser_id];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@chat_view.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&start=0&end=250",login_user_id,_getuser_id];
    
    
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //nslog(@"Send Chat -- %@",postData);
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         chat_Data_array=[[NSMutableArray alloc]init];
         chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
         
         //nslog(@"Chat Data-- %@",chat_Data_array);
         
         
         [_chat_table reloadData];
         
         if(chat_Data_array.count > 0){
             
             [_chat_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chat_Data_array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
             
         }
     }];
    
    
}

- (IBAction)openStickerview:(id)sender {
    up=1;
    
   
    
    if (keyboard==0)
    {
        
        NSLog(@"Keyboard 0");
        
        
        
        _chat_table.frame = CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y-220, _chat_table.frame.size.width, _chat_table.frame.size.height);
        
        self.stickerCollection.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-220, [UIScreen mainScreen].bounds.size.width,220);


        _chatbox.frame =CGRectMake(_chatbox.frame.origin.x, _chatbox.frame.origin.y-220, _chatbox.frame.size.width, _chatbox.frame.size.height);
        _smly.frame =CGRectMake(_smly.frame.origin.x, _smly.frame.origin.y-220, _smly.frame.size.width, _smly.frame.size.height);
        _clip_button.frame =CGRectMake(_clip_button.frame.origin.x, _clip_button.frame.origin.y-220, _clip_button.frame.size.width, _clip_button.frame.size.height);
        _send_button.frame =CGRectMake(_send_button.frame.origin.x, _send_button.frame.origin.y-220, _send_button.frame.size.width, _send_button.frame.size.height);
        
        
       }
    else
    {
        if (up==1)
        {
            [_chatbox resignFirstResponder];
            
            
            self.stickerCollection.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height+kwheight, [UIScreen mainScreen].bounds.size.width,kwheight);
            
            _chat_table.frame = CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y+220, _chat_table.frame.size.width, _chat_table.frame.size.height);
            
            _chatbox.frame =CGRectMake(_chatbox.frame.origin.x, _chatbox.frame.origin.y+220, _chatbox.frame.size.width, _chatbox.frame.size.height);
            _smly.frame =CGRectMake(_smly.frame.origin.x, _smly.frame.origin.y+220, _smly.frame.size.width, _smly.frame.size.height);
            _clip_button.frame =CGRectMake(_clip_button.frame.origin.x, _clip_button.frame.origin.y+220, _clip_button.frame.size.width, _clip_button.frame.size.height);
            _send_button.frame =CGRectMake(_send_button.frame.origin.x, _send_button.frame.origin.y+220, _send_button.frame.size.width, _send_button.frame.size.height);

            
            NSLog(@"Keyboard 11 ....... %f",kwheight);
            
            up=0;

        }
        else
        {
            [_chatbox resignFirstResponder];
            
            
            self.stickerCollection.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-kwheight, [UIScreen mainScreen].bounds.size.width,kwheight);
            
            NSLog(@"Keyboard 1 ....... %f",kwheight);
            
            _chat_table.frame = CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y-220, _chat_table.frame.size.width, _chat_table.frame.size.height);

            _chatbox.frame =CGRectMake(_chatbox.frame.origin.x, _chatbox.frame.origin.y-220, _chatbox.frame.size.width, _chatbox.frame.size.height);
            _smly.frame =CGRectMake(_smly.frame.origin.x, _smly.frame.origin.y-220, _smly.frame.size.width, _smly.frame.size.height);
            _clip_button.frame =CGRectMake(_clip_button.frame.origin.x, _clip_button.frame.origin.y-220, _clip_button.frame.size.width, _clip_button.frame.size.height);
            _send_button.frame =CGRectMake(_send_button.frame.origin.x, _send_button.frame.origin.y-220, _send_button.frame.size.width, _send_button.frame.size.height);

            
            up=1;

        }
        
     
    }
    

}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
    
    [self.view bringSubviewToFront:_topview];
    [self.view bringSubviewToFront:_chattext];
    [self.view bringSubviewToFront:_backbtn];
    [self.view bringSubviewToFront:_plusBtn];
    [self.view bringSubviewToFront:_chatbox];
    [self.view bringSubviewToFront:_clip_button];
    [self.view bringSubviewToFront:_send_button];
    [self.view bringSubviewToFront:_smly];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceiveNotification) name:@"DataEdited" object:nil];
    
    
}
- (void)playMusic
{
    NSLog(@"playingg.....");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sounds-874-gets-in-the-way" ofType:@"mp3"];
    NSError *error = nil;
    NSURL *url = [NSURL fileURLWithPath:path];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [player play];
}
-(void)ReceiveNotification{
    [self playMusic];
    
    
    [self viewDidLoad];
    
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    keyboard=1;
    
    kwheight=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //nslog(@"keyboard height.....%f", kwheight);
    if(kwheight==252.0f && flag==0 && myflag==0)
    {
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x, _chatbox.frame.origin.y-35,_chatbox.frame.size.width, _chatbox.frame.size.height)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x, _send_button.frame.origin.y-35,_send_button.frame.size.width, _send_button.frame.size.height)];
        
        [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, _clip_button.frame.origin.y-35,27,56)];
        
        
        flag=1;
        myflag=1;
    }
    
    if(kwheight==216.0f && myflag==1)
    {
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x, _chatbox.frame.origin.y+35,_chatbox.frame.size.width, _chatbox.frame.size.height)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x, _send_button.frame.origin.y+35,_send_button.frame.size.width, _send_button.frame.size.height)];
        
        [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, _clip_button.frame.origin.y+35,27,56)];
        
        
        myflag=0;
        flag=0;
    }
    
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    keyboard=1;
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
    
    //NSString *urlstring=[NSString stringWithFormat:@"%@chat_view.php?send_id=%@&rec_id=%@&start=0&end=70",App_Domain_Url,login_user_id,_getuser_id];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@chat_view.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&start=0&end=70",login_user_id,_getuser_id];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         chat_Data_array=[[NSMutableArray alloc]init];
         chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
         
         [_chat_table reloadData];
         
         if(chat_Data_array.count > 0){
             
             [_chat_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chat_Data_array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
             
         }
     }];
    
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        charcount=[[_chatbox text]length];
        
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,274);
            
            
        }
        else
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,174);
            
            
        }
        
        
        if(flag==1 && myflag==0 && up!=1)
        {
            
            [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x, _chatbox.frame.origin.y-220,_chatbox.frame.size.width, _chatbox.frame.size.height)];
            
            [_send_button setFrame:CGRectMake(_send_button.frame.origin.x, _send_button.frame.origin.y-220,_send_button.frame.size.width, _send_button.frame.size.height)];
            
            [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, _clip_button.frame.origin.y-220,27,56)];
            
            [_smly setFrame:CGRectMake(_smly.frame.origin.x, _smly.frame.origin.y-220,_smly.frame.size.width,_smly.frame.size.height)];
            flag=0;
        }
        
        
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
    //        //nslog(@"BackSpace .... ");
    //    }
    //
    //
    
    
    
    
    if ( [text isEqualToString:@"\n"] )
    {
        
        //nslog(@"Changing line .....%f",_chatbox.frame.size.height);
        
        
        if (i>0)
        {
            
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,_chat_table.frame.size.height-25);
            
            [_chat_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chat_Data_array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            i--;
        }
        
        
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
    UITableViewCell *celltbl = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    
    
    NSString *id_string=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"send_from"]];
    
    if([[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"type"]  isEqual: @"s"]){
        
        
        if ([login_user_id isEqualToString:id_string])
        {
            
            chat_person_image=[[UIImageView alloc]initWithFrame:CGRectMake(0,+10, 75,75)];
            chat_person_image.layer.cornerRadius=(75.0f/2.0f);
            chat_person_image.clipsToBounds=YES;
            chat_person_image.contentMode=UIViewContentModeScaleAspectFill;
            
            [celltbl addSubview:chat_person_image];
            
            
            [chat_person_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
            UIImageView *cmngimg=[[UIImageView alloc]initWithFrame:CGRectMake(90,+10, 75,75)];
            cmngimg.layer.cornerRadius=(75.0f/2.0f);
            cmngimg.clipsToBounds=YES;
            cmngimg.contentMode=UIViewContentModeScaleAspectFill;
            cmngimg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"stickername"]]];
            [celltbl addSubview:cmngimg];
            
            
        }else{
            
            chat_person_image=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-chat_person_image.frame.size.width,+10, 75,75)];
            chat_person_image.layer.cornerRadius=(75.0f/2.0f);
            chat_person_image.clipsToBounds=YES;
            chat_person_image.contentMode=UIViewContentModeScaleAspectFill;
            
            [celltbl addSubview:chat_person_image];
            
            
            [chat_person_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
            UIImageView *cmngimg=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-chat_person_image.frame.size.width-90,+10, 75,75)];
            cmngimg.layer.cornerRadius=(75.0f/2.0f);
            cmngimg.clipsToBounds=YES;
            cmngimg.contentMode=UIViewContentModeScaleAspectFill;
            cmngimg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"stickername"]]];
            [celltbl addSubview:cmngimg];
            
        }
        
    }else{
        
        if ([login_user_id isEqualToString:id_string])
        {
            
            
            chat_person_image=[[UIImageView alloc]initWithFrame:CGRectMake(0,+10, 75,75)];
            chat_person_image.layer.cornerRadius=(75.0f/2.0f);
            chat_person_image.clipsToBounds=YES;
            chat_person_image.contentMode=UIViewContentModeScaleAspectFill;
            
            [celltbl addSubview:chat_person_image];
            
            
            [chat_person_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
            chat_design=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x+55,5,[UIScreen mainScreen].bounds.size.width-60,80)];
            
            [celltbl addSubview:chat_design];
            
            
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
            
            [celltbl addSubview:chat_person_image];
            
            
            [chat_person_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
            chat_design=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x+5,5,[UIScreen mainScreen].bounds.size.width-60,80)];
            
            [celltbl addSubview:chat_design];
            
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
        
    }
    
    
    
    
    celltbl.backgroundColor=[UIColor clearColor];
    celltbl.selectionStyle=NO;
    
    return celltbl;
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
    keyboard=0;
    [_chatbox resignFirstResponder];
    
    
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width, 540);
        [_smly setFrame:CGRectMake(_smly.frame.origin.x, _smly.frame.origin.y+220,_smly.frame.size.width,_smly.frame.size.height)];
    }
    else
    {
        _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,435);
        
        [_smly setFrame:CGRectMake(_smly.frame.origin.x, _smly.frame.origin.y+220,54,56)];
    }
    
    
    [self Load_url];
    
}
-(void)Load_url
{
    NSString *chattext=[_chatbox.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([chattext stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
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
        
        
        RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
        
        
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-56,_chatbox.frame.size.width, 56)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height,_send_button.frame.size.width, _send_button.frame.size.height)];
        
        [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-56,27,56)];
        
        
        NSString *urlstring=[NSString stringWithFormat:@"%@sendChatUser.php",App_Domain_Url];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        
        [request setHTTPMethod:@"POST"];
        
        NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&message=%@&start=0&end=70&type=m",login_user_id,_getuser_id,chattext];
        
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
        [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             chat_Data_array=[[NSMutableArray alloc]init];
             chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
             
             NSLog(@"hello....%@",result);
             _chatbox.text = nil;
             [self viewDidLoad];
             
             
         }];
        
    }
    
    
}
- (IBAction)back_button:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    
    NSString *urlstring=[NSString stringWithFormat:@"%@sendChatUser.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&message=%@&start=0&end=70&type=s&stickername=%@",login_user_id,_getuser_id,@"",[NSString stringWithFormat:@"%ld.png",indexPath.row+1]];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         chat_Data_array=[[NSMutableArray alloc]init];
         chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
         
         
         _chatbox.text = nil;
         [self viewDidLoad];
         
         
     }];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    return 8;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"stickercell" forIndexPath:indexPath];
    [cell setImage:(UIImage *)[UIImage imageNamed:[NSString stringWithFormat:@"%ld%@",indexPath.row+1,@".png"]]];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.stickerCollection.collectionViewLayout;
    CGFloat availableWidthForCells = CGRectGetWidth(self.stickerCollection.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (kCellsPerRow - 1);
    self.cellWidth = availableWidthForCells / kCellsPerRow;
    flowLayout.itemSize = CGSizeMake(self.cellWidth, flowLayout.itemSize.height);
    return flowLayout.itemSize;
    
}




@end
