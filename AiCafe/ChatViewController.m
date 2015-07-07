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

@interface ChatViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
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
    
    
    
    _chat_table.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.delegate=self;
    [self.chat_table addGestureRecognizer:gestureRecognizer];
    
    
    
    flag=1;
    myflag=0;
    i=5;
    up=0;
    
    keyboard=0;
    
    _chat_table.backgroundColor=[UIColor clearColor];
    
    _chatbox.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.6];
    _chatbox.font=[UIFont fontWithName:@"OpenSans" size:16];
    
    _chatbox.autocorrectionType = UITextAutocorrectionTypeNo;
    
//    
//     [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height,_chatbox.frame.size.width,_send_button.frame.size.height)];
//    
    
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
  //  up=1;
    
   
    
    if (keyboard==0)
    {
        

        [_chatbox resignFirstResponder];
        
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_chatbox.frame.size.height-_stickerCollection.frame.size.height-2,_chatbox.frame.size.width, _chatbox.frame.size.height)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height-_stickerCollection.frame.size.height-2,_send_button.frame.size.width, _send_button.frame.size.height)];
        
        [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height-_stickerCollection.frame.size.height-2,27,56)];
        
        [_smly setFrame:CGRectMake(_smly.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_smly.frame.size.height-_stickerCollection.frame.size.height-2,_smly.frame.size.width,_smly.frame.size.height)];
        
        self.stickerCollection.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-_stickerCollection.frame.size.height, [UIScreen mainScreen].bounds.size.width,_stickerCollection.frame.size.height);
        
        [_stickerCollection setHidden:NO];
        
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,274);
            
            
        }
        else
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,174);
            
            
        }

        
        
       }
    else
    {
        [_chatbox resignFirstResponder];
        
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_chatbox.frame.size.height-kwheight-2,_chatbox.frame.size.width, _chatbox.frame.size.height)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height-kwheight-2,_send_button.frame.size.width, _send_button.frame.size.height)];
        
        [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height-kwheight-2,27,56)];
        
        [_smly setFrame:CGRectMake(_smly.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_smly.frame.size.height-kwheight-2,_smly.frame.size.width,_smly.frame.size.height)];
        
        self.stickerCollection.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-kwheight, [UIScreen mainScreen].bounds.size.width,220);
     
        [_stickerCollection setHidden:NO];
        
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,274);
            
            
        }
        else
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,174);
            
            
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
    
    NSLog(@"####################........ KeyBoard Will Show");
    
    [UIView animateWithDuration:0.4 animations:^{
        
        charcount=[[_chatbox text]length];
        
        [_stickerCollection setHidden:YES];
        
        //_chatbox.frame.origin.y-_chat_table.frame.origin.y
        
       /* if ([UIScreen mainScreen].bounds.size.width>320)
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,276);
            
            
        }
        else
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,174);
            
            
        }*/
        
     
            
    [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_chatbox.frame.size.height-kwheight-2,_chatbox.frame.size.width, _chatbox.frame.size.height)];
            
    [_send_button setFrame:CGRectMake(_send_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height-kwheight-2,_send_button.frame.size.width, _send_button.frame.size.height)];
            
    [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height-kwheight-2,27,56)];
            
    [_smly setFrame:CGRectMake(_smly.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_smly.frame.size.height-kwheight-2,_smly.frame.size.width,_smly.frame.size.height)];
            flag=0;
        
       
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,_chatbox.frame.origin.y-_chat_table.frame.origin.y);
            
            
        }
        else
        {
            _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,_chatbox.frame.origin.y-_chat_table.frame.origin.y);
            
            
        }
        
  
        
        
        
        
    }];
    
    
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
    
    
    
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{

    
    if ( [text isEqualToString:@"\n"] )
    {
        
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
        
    }
    
    
    
    else{
        
        if ([login_user_id isEqualToString:id_string])
            
        {
            
            
            
            UIFont *font1 = [UIFont fontWithName:@"OpenSans-Semibold" size:17];
            
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
            
            
            
          aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"message"] attributes: arialDict];
            
            
            
            CGRect rect;
            
            
            
            rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            
            
            
            UIView *chatBackView = [[UIView alloc]initWithFrame:CGRectMake(80, 7.5f, [UIScreen mainScreen].bounds.size.width-85, rect.size.height+70)];
            
            [chatBackView setBackgroundColor:[UIColor colorWithRed:(59.0f/255.0f) green:(37.0f/255.0f) blue:(13.0f / 255.0f) alpha:0.7f]];
            
            [celltbl addSubview:chatBackView];
            
            UIBezierPath *maskPath;
            
            maskPath = [UIBezierPath bezierPathWithRoundedRect:chatBackView.bounds
                        
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight)
                        
                                                   cornerRadii:CGSizeMake(10.0, 10.0)];
            
            
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            
            maskLayer.frame = self.view.bounds;
            
            maskLayer.path = maskPath.CGPath;
            
            chatBackView.layer.mask = maskLayer;
            
            
            
            
            
            
            
            UIImageView *imageCorner = [[UIImageView alloc]initWithFrame:CGRectMake(55, rect.size.height+70-52.5f, 25, 60)];
            
            [imageCorner setImage:[UIImage imageNamed:@"cornerimageown"]];
            
            [celltbl addSubview:imageCorner];
            
            
            
            
            
            chat_person_image=[[UIImageView alloc]initWithFrame:CGRectMake(0,rect.size.height+70-69, 75,75)];
            
            chat_person_image.layer.cornerRadius=(75.0f/2.0f);
            
            chat_person_image.clipsToBounds=YES;
            
            chat_person_image.contentMode=UIViewContentModeScaleAspectFill;
            
            
            
            [celltbl addSubview:chat_person_image];
            
            
            
            
            
            [chat_person_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
            
            
            
            user_name=[[UILabel alloc]initWithFrame:CGRectMake(47,5, 150, 20)];
            
            user_name.textColor=[UIColor colorWithRed:(204.0f/255.0f) green:(162.0f/255.0f) blue:(102.0f/255.0f) alpha:1];
            
            user_name.font=[UIFont fontWithName:@"OpenSans-Semibold" size:17];
            
            user_name.textAlignment=NSTextAlignmentLeft;
            
            user_name.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"name"]];
            
            [chatBackView addSubview:user_name];
            
            //
            
            time=[[UILabel alloc]initWithFrame:CGRectMake(chatBackView.frame.size.width-90,5, 150, 20)];
            
            time.textColor=[UIColor colorWithRed:(204.0f/255.0f) green:(162.0f/255.0f) blue:(102.0f/255.0f) alpha:1];
            
            time.font=[UIFont fontWithName:@"OpenSans-Semibold" size:15];
            
            time.textAlignment=NSTextAlignmentLeft;
            
            time.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"chat_date"]];
            
            [chatBackView addSubview:time];
            
            
            
            message=[[UILabel alloc]initWithFrame:CGRectMake(47,25, 230, rect.size.height+50)];
            
            message.textColor=[UIColor whiteColor];
            
            message.numberOfLines =0;
            
            message.clipsToBounds = YES;
            
            message.attributedText = aAttrString1;
            
            message.font=[UIFont fontWithName:@"OpenSans-Semibold" size:16];
            
            message.textAlignment=NSTextAlignmentLeft;
            
            [chatBackView addSubview:message];
            
            
            
        }
        
        else
            
        {
            
            
            
            UIFont *font1 = [UIFont fontWithName:@"OpenSans-Semibold" size:17];
            
            NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
            
            NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"message"] attributes: arialDict];
            
            
            
            CGRect rect;
            
            
            
            rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            
            
            
            UIView *chatBackView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x+5, 7.5f, [UIScreen mainScreen].bounds.size.width-85, rect.size.height+70)];
            
            [chatBackView setBackgroundColor:[UIColor colorWithRed:(250.0f/255.0f) green:(250.0f/255.0f) blue:(250.0f / 255.0f) alpha:0.8f]];
            
            [celltbl addSubview:chatBackView];
            
            UIBezierPath *maskPath;
            
            maskPath = [UIBezierPath bezierPathWithRoundedRect:chatBackView.bounds
                        
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft)
                        
                                                   cornerRadii:CGSizeMake(10.0, 10.0)];
            
            
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            
            maskLayer.frame = self.view.bounds;
            
            maskLayer.path = maskPath.CGPath;
            
            chatBackView.layer.mask = maskLayer;
            
            
            
            
            
            
            
            UIImageView *imageCorner = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, rect.size.height+70-52.5f, 25, 60)];
            
            [imageCorner setImage:[UIImage imageNamed:@"cornerimagewhite"]];
            
            [celltbl addSubview:imageCorner];
            
            
            
            
            
            chat_person_image=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-chat_person_image.frame.size.width,rect.size.height+70-69, 75,75)];
            
            chat_person_image.layer.cornerRadius=(75.0f/2.0f);
            
            chat_person_image.clipsToBounds=YES;
            
            chat_person_image.contentMode=UIViewContentModeScaleAspectFill;
            
            
            
            [celltbl addSubview:chat_person_image];
            
            
            
            
            
            [chat_person_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[chat_Data_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options: (0) == 0?SDWebImageRefreshCached : 0];
            
            
            
            
            
            //            chat_design=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x+5,5,[UIScreen mainScreen].bounds.size.width-60,80)];
            
            //
            
            //            [celltbl addSubview:chat_design];
            
            
            
            
            
            
            
            
            
            user_name=[[UILabel alloc]initWithFrame:CGRectMake(15,5, 150, 20)];
            
            user_name.textColor=[UIColor colorWithRed:(204.0f/255.0f) green:(162.0f/255.0f) blue:(102.0f/255.0f) alpha:1];
            
            user_name.font=[UIFont fontWithName:@"OpenSans-Semibold" size:17];
            
            user_name.textAlignment=NSTextAlignmentLeft;
            
            user_name.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"name"]];
            
            [chatBackView addSubview:user_name];
            
            
            
            message=[[UILabel alloc]initWithFrame:CGRectMake(15,30, 230, rect.size.height+55)];
            
            message.textColor=[UIColor blackColor];
            
            message.font=[UIFont fontWithName:@"OpenSans-Semibold" size:16];
            
            message.textAlignment=NSTextAlignmentLeft;
            
            message.numberOfLines = 0;
            
            message.clipsToBounds = YES;
            
            message.attributedText =aAttrString1;
            
            [chatBackView addSubview:message];
            
            
            
            
            
            
            
            time=[[UILabel alloc]initWithFrame:CGRectMake(chatBackView.frame.size.width-90,5, 150, 20)];
            
            time.textColor=[UIColor colorWithRed:(204.0f/255.0f) green:(162.0f/255.0f) blue:(102.0f/255.0f) alpha:1];
            
            time.font=[UIFont fontWithName:@"OpenSans-Semibold" size:15];
            
            time.textAlignment=NSTextAlignmentLeft;
            
            time.text=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"chat_date"]];
            
            [chatBackView addSubview:time];
            
            
            
        }
        
    }
    
    
    
    
    celltbl.backgroundColor=[UIColor clearColor];
    celltbl.selectionStyle=NO;
    
    return celltbl;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font1 = [UIFont fontWithName:@"OpenSans-Semibold" size:17];
    
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
    
    NSString *msgData=[NSString stringWithFormat:@"%@",[[chat_Data_array objectAtIndex:indexPath.row] objectForKey:@"message"]];
    
    NSData *data = [msgData dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *convertedStr = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];

    NSLog(@"#### ConvertedData....%@",msgData);
    
    if (convertedStr.length==0)
    {
         aAttrString1 = [[NSMutableAttributedString alloc] initWithString:msgData attributes: arialDict];
    }
    else
    {
         aAttrString1 = [[NSMutableAttributedString alloc] initWithString:convertedStr attributes: arialDict];
    }
    
   
    
    
    
    CGRect rect;
    
    
    
    rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    
    
    
    
    return rect.size.height + 80;
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
    
    [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_chatbox.frame.size.height-kwheight-2,_chatbox.frame.size.width, _chatbox.frame.size.height)];
    
    //[_chatbox resignFirstResponder];
    
  /*  [UIView animateWithDuration:0.5 animations:^{
        
        [_stickerCollection setHidden:YES];
        
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height,_chatbox.frame.size.width,_send_button.frame.size.height)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height- _send_button.frame.size.height,_send_button.frame.size.width,_send_button.frame.size.height)];
        
        [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height,27,56)];
        
        [_smly setFrame:CGRectMake(_smly.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_smly.frame.size.height,_smly.frame.size.width,_smly.frame.size.height)];
        

    }];
    
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width, 530);
       
    }
    else
    {
        _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,435);
        
    }
   */
    
    
    [self Load_url];
    
}
-(void)Load_url
{
    
   
    
    NSString *chattext=_chatbox.text;
    
    if ([chattext stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
    {
       
        
        
    }
    else
    {
       
        
        
//        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_chatbox.frame.size.height-kwheight-2,_chatbox.frame.size.width, _chatbox.frame.size.height)];
//
        
        NSData *data = [_chatbox.text dataUsingEncoding:NSNonLossyASCIIStringEncoding];
      //  NSString *goodValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSString *chattext=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
        
        
        NSLog(@"### Url Data ......%@",chattext);
        
        
        
        
       // [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-56,_chatbox.frame.size.width,_send_button.frame.size.height)];
        
        //[_send_button setFrame:CGRectMake(_send_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height,_send_button.frame.size.width, _send_button.frame.size.height)];
        
        //[_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-56,27,56)];
        
        
        NSString *urlstring=[NSString stringWithFormat:@"%@sendChatUser.php",App_Domain_Url];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        
        [request setHTTPMethod:@"POST"];
        
        NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&message=%@&start=0&end=70&type=m&chat_type=O",login_user_id,_getuser_id,chattext];
        
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
    
    NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&message=%@&start=0&end=70&type=s&stickername=%@&chat_type=O",login_user_id,_getuser_id,@"",[NSString stringWithFormat:@"%ld.png",indexPath.row+1]];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         chat_Data_array=[[NSMutableArray alloc]init];
         chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
         
         
         _chatbox.text = nil;
         [self viewDidLoad];
         
         
         [_chatbox resignFirstResponder];
         
         [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_chatbox.frame.size.height-kwheight-2,_chatbox.frame.size.width, _chatbox.frame.size.height)];
         
         [_send_button setFrame:CGRectMake(_send_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height-kwheight-2,_send_button.frame.size.width, _send_button.frame.size.height)];
         
         [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height-kwheight-2,27,56)];
         
         [_smly setFrame:CGRectMake(_smly.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_smly.frame.size.height-kwheight-2,_smly.frame.size.width,_smly.frame.size.height)];
         
         self.stickerCollection.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-kwheight, [UIScreen mainScreen].bounds.size.width,220);
         
         [_stickerCollection setHidden:NO];
         
         if ([UIScreen mainScreen].bounds.size.width>320)
         {
             _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,274);
             
             
         }
         else
         {
             _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,174);
             
             
         }

         
         
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





-(void)hideKeyboard
{
    
    
    [self.view endEditing:YES];
    
    [_chatbox resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [_stickerCollection setHidden:YES];
        
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height,_chatbox.frame.size.width,_send_button.frame.size.height)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height- _send_button.frame.size.height,_send_button.frame.size.width,_send_button.frame.size.height)];
        
        //     [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height,27,56)];
        
        [_smly setFrame:CGRectMake(_smly.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_smly.frame.size.height,_smly.frame.size.width,_smly.frame.size.height)];
        
       _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,_chatbox.frame.origin.y-_chat_table.frame.origin.y);
        
    }];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
    
    [_chatbox resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [_stickerCollection setHidden:YES];
        
        [_chatbox setFrame:CGRectMake(_chatbox.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_send_button.frame.size.height,_chatbox.frame.size.width,_send_button.frame.size.height)];
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height- _send_button.frame.size.height,_send_button.frame.size.width,_send_button.frame.size.height)];
        
        //     [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height,27,56)];
        
        [_smly setFrame:CGRectMake(_smly.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_smly.frame.size.height,_smly.frame.size.width,_smly.frame.size.height)];
        
         _chat_table.frame=CGRectMake(_chat_table.frame.origin.x, _chat_table.frame.origin.y, _chat_table.frame.size.width,_chatbox.frame.origin.y-_chat_table.frame.origin.y);
        
    }];
    
}





@end
