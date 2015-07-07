//
//  ChatRoomViewController.m
//  AiCafe
//
//  Created by Priyanka ghosh on 29/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "UserInfoViewController.h"

@interface ChatRoomViewController ()

@end

@implementation ChatRoomViewController
@synthesize ChatTable,FriendGroupCollectionView,txtVwWriteChat,btnSend,btnSmly,stickerCollection;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"View did load...");
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    flag=1;
    myflag=0;
    i=5;
    up=0;
    
    keyboard=0;
    
    ChatTable.backgroundColor=[UIColor clearColor];
    
    txtVwWriteChat.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.6];
    txtVwWriteChat.font=[UIFont fontWithName:@"OpenSans" size:16];
    
    txtVwWriteChat.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
    
    Login_user_Id = [UserData stringForKey:@"Login_User_id"];
    
    //    login_user_id=@"10";
    
    //NSString *urlstring=[NSString stringWithFormat:@"%@chat_view.php?send_id=%@&rec_id=%@&start=0&end=70",App_Domain_Url,login_user_id,_getuser_id];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@group_chat_view.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
//    NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&start=0&end=250",login_user_id,@"20"];
    
    NSLog(@"Login user id: %@",login_user_id);
    
        NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&start=1&end=250",login_user_id,Login_user_Id/*@"25,10,21,30"*/];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //nslog(@"Send Chat -- %@",postData);
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         chat_Data_array=[[NSMutableArray alloc]init];
         chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
         
         
         
         NSLog(@"Chat Data-- %@",chat_Data_array);
         
         
         [ChatTable reloadData];
         [self allUserUrl];
         if(chat_Data_array.count > 0){
             
             [ChatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chat_Data_array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
             
         }
     }];
}
-(void)allUserUrl
{
    Friend_list_array =[[NSMutableArray alloc]init];
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    Login_user_Id = [UserData stringForKey:@"Login_User_id"];
    
    
    NSString *urlstring=[NSString stringWithFormat:@"%@user_listing.php?id=%@",App_Domain_Url,Login_user_Id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         if ([[result objectForKey:@"auth"]isEqualToString:@"fail"])
         {
             
         }
         else
         {
           //  NSLog(@"All User Data....%@",request);
             
             Friend_list_array=[[NSMutableArray alloc]init];
             Friend_list_array=[[result objectForKey:@"details"] mutableCopy];
             
             [FriendGroupCollectionView reloadData];
             
         }
         
         
     }];
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    if (collectionView==stickerCollection)
    {
        return 8;
    }
    else
    {
    return [Friend_list_array count];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    if (collectionView==stickerCollection)
    {
        cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"stickercell" forIndexPath:indexPath];
        [cell1 setImage:(UIImage *)[UIImage imageNamed:[NSString stringWithFormat:@"%ld%@",indexPath.row+1,@".png"]]];//indexPath.row+1
        
        return cell1;
   
    }
    else
    {
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"FriendCollectionViewCell" forIndexPath:indexPath];
        if ([[[Friend_list_array objectAtIndex:indexPath.row]objectForKey:@"sex"] isEqualToString:@"M"])
        {
            [cell.FriendImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"PlaceholderM"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
        }
        else
        {
            [cell.FriendImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Domain_Url,[[Friend_list_array objectAtIndex:indexPath.row]objectForKey:@"photo_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholderF"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
            
            
        }
        cell.FriendImg.layer.cornerRadius=(cell.FriendImg.frame.size.width)/2;
        cell.FriendImg.clipsToBounds=YES;
        cell.FriendImg.contentMode=UIViewContentModeScaleAspectFill;
        cell.FriendImg.layer.borderColor=[[UIColor whiteColor]colorWithAlphaComponent:.6].CGColor;
        cell.FriendImg.layer.borderWidth=2.0;
        
        cell.NoofChatView.layer.cornerRadius=(cell.NoofChatView.frame.size.width)/2;
        
        return cell;
    }
}
/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.stickerCollection.collectionViewLayout;
    if (collectionView==stickerCollection)
    {
    
    CGFloat availableWidthForCells = CGRectGetWidth(self.stickerCollection.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (kCellsPerRow - 1);
    self.cellWidth = availableWidthForCells / kCellsPerRow;
    flowLayout.itemSize = CGSizeMake(self.cellWidth, flowLayout.itemSize.height);
    
    }
    return flowLayout.itemSize;
     
}
*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==stickerCollection) {
        
         [stickerCollection setHidden:YES];
        
        [txtVwWriteChat setFrame:CGRectMake(txtVwWriteChat.frame.origin.x,[UIScreen mainScreen].bounds.size.height-btnSend.frame.size.height,txtVwWriteChat.frame.size.width,btnSend.frame.size.height)];
        
        [btnSend setFrame:CGRectMake(btnSend.frame.origin.x,[UIScreen mainScreen].bounds.size.height- btnSend.frame.size.height,btnSend.frame.size.width,btnSend.frame.size.height)];
        
        //     [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height,27,56)];
        
        [btnSmly setFrame:CGRectMake(btnSmly.frame.origin.x,[UIScreen mainScreen].bounds.size.height-btnSmly.frame.size.height,btnSmly.frame.size.width,btnSmly.frame.size.height)];
        
        ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,txtVwWriteChat.frame.origin.y-(FriendGroupCollectionView.frame.origin.y+FriendGroupCollectionView.frame.size.height));
        
      
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    
    NSString *urlstring=[NSString stringWithFormat:@"%@sendChatGroup.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
//    NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&message=@""&start=0&end=250&type=s&stickername=%@",login_user_id,Login_user_Id,[NSString stringWithFormat:@"%ld.png",indexPath.row+1]];
        
        NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&message=hello&type=s&stickername=%@&chat_type=G",login_user_id,Login_user_Id,[NSString stringWithFormat:@"%ld.png",indexPath.row+1]];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         chat_Data_array=[[NSMutableArray alloc]init];
         chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
         
         
         txtVwWriteChat.text = nil;
         [self viewDidLoad];
         
         
     }];
    }
    
    
    
    if (collectionView==FriendGroupCollectionView) {
        
        
        //details -> id
        
         [[Friend_list_array objectAtIndex:indexPath.row] valueForKey:@"id"];
        
        NSLog(@"User id: %@",[[Friend_list_array objectAtIndex:indexPath.row] valueForKey:@"id"]);
        
       
        UserInfoViewController *userVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"User_info_page"];
        
        userVC.getuser_id=[[Friend_list_array objectAtIndex:indexPath.row] valueForKey:@"id"];
        
        [self.navigationController pushViewController:userVC animated:YES];
        
    }
    
    
    
    
}
- (IBAction)ChatSendClick:(id)sender
{
    keyboard=0;
    [txtVwWriteChat resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [stickerCollection setHidden:YES];
        
        [txtVwWriteChat setFrame:CGRectMake(txtVwWriteChat.frame.origin.x,[UIScreen mainScreen].bounds.size.height-btnSend.frame.size.height,txtVwWriteChat.frame.size.width,btnSend.frame.size.height)];
        
        [btnSend setFrame:CGRectMake(btnSend.frame.origin.x,[UIScreen mainScreen].bounds.size.height- btnSend.frame.size.height,btnSend.frame.size.width,btnSend.frame.size.height)];
        
   //     [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x,[UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height,27,56)];
        
        [btnSmly setFrame:CGRectMake(btnSmly.frame.origin.x,[UIScreen mainScreen].bounds.size.height-btnSmly.frame.size.height,btnSmly.frame.size.width,btnSmly.frame.size.height)];
        
        ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,txtVwWriteChat.frame.origin.y-(FriendGroupCollectionView.frame.origin.y+FriendGroupCollectionView.frame.size.height));
        
    }];
    
    /*
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width, 530);
        
    }
    else
    {
        ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,435);
        
    }
    */
    if (txtVwWriteChat.text.length>0)
    {
        [self Load_url];
    }
    
}
-(void)Load_url
{
    
    NSString *chattext=txtVwWriteChat.text;
    
    if ([chattext stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
    {
        
        
    }
    else
    {
        
        NSString *chattext=[txtVwWriteChat.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
        
        
        [txtVwWriteChat setFrame:CGRectMake(txtVwWriteChat.frame.origin.x,[UIScreen mainScreen].bounds.size.height-56,txtVwWriteChat.frame.size.width,btnSend.frame.size.height)];
        
        [btnSend setFrame:CGRectMake(btnSend.frame.origin.x, [UIScreen mainScreen].bounds.size.height-btnSend.frame.size.height,btnSend.frame.size.width, btnSend.frame.size.height)];
        
    //    [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-56,27,56)];
        
        
       // NSString *urlstring=[NSString stringWithFormat:@"%@sendChatUser.php",App_Domain_Url];
        
         NSString *urlstring=[NSString stringWithFormat:@"%@sendChatGroup.php",App_Domain_Url];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        
        [request setHTTPMethod:@"POST"];
        
       // NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&message=%@&start=0&end=70&type=m",login_user_id,@"20",chattext];
        
         NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&message=%@&type=m&stickername=abc&chat_type=G",login_user_id,Login_user_Id,chattext];
        
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
        [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
         {
             
             chat_Data_array=[[NSMutableArray alloc]init];
             chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
             
             NSLog(@"hello....%@",result);
             txtVwWriteChat.text = nil;
             [self viewDidLoad];
             
             
         }];
        
    }
    
    
}
- (IBAction)openStikerView:(id)sender
{
    if (keyboard==0)
    {
        if(chat_Data_array.count > 0){
            
         //   [ChatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chat_Data_array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            CGFloat yOffset = 0;
            
            if (ChatTable.contentSize.height > ChatTable.bounds.size.height) {
                yOffset = ChatTable.contentSize.height - ChatTable.bounds.size.height;
            }
            
            [ChatTable setContentOffset:CGPointMake(0, yOffset) animated:NO];
            
        }
        
        [txtVwWriteChat resignFirstResponder];
        
        [txtVwWriteChat setFrame:CGRectMake(txtVwWriteChat.frame.origin.x,[UIScreen mainScreen].bounds.size.height-txtVwWriteChat.frame.size.height-stickerCollection.frame.size.height-2,txtVwWriteChat.frame.size.width, txtVwWriteChat.frame.size.height)];
        
        [btnSend setFrame:CGRectMake(btnSend.frame.origin.x,[UIScreen mainScreen].bounds.size.height-btnSend.frame.size.height-stickerCollection.frame.size.height-2,btnSend.frame.size.width, btnSend.frame.size.height)];
        
     //   [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height-_stickerCollection.frame.size.height-2,27,56)];
        
        [btnSmly setFrame:CGRectMake(btnSmly.frame.origin.x, [UIScreen mainScreen].bounds.size.height-btnSmly.frame.size.height-stickerCollection.frame.size.height-2,btnSmly.frame.size.width,btnSmly.frame.size.height)];
        
        stickerCollection.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-stickerCollection.frame.size.height, [UIScreen mainScreen].bounds.size.width,stickerCollection.frame.size.height);
        
        [stickerCollection setHidden:NO];
        
        ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,txtVwWriteChat.frame.origin.y-(FriendGroupCollectionView.frame.origin.y+FriendGroupCollectionView.frame.size.height));
      /*
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,274);
            
            
        }
        else
        {
            ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,174);
            
            
        }
        */
        
        
    }
    else
    {
        [txtVwWriteChat resignFirstResponder];
        
        if(chat_Data_array.count > 0){
            
            [ChatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chat_Data_array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            [ChatTable reloadData];

        }

        [txtVwWriteChat setFrame:CGRectMake(txtVwWriteChat.frame.origin.x,[UIScreen mainScreen].bounds.size.height-txtVwWriteChat.frame.size.height-kwheight-2,txtVwWriteChat.frame.size.width, txtVwWriteChat.frame.size.height)];
        
        [btnSend setFrame:CGRectMake(btnSend.frame.origin.x,[UIScreen mainScreen].bounds.size.height-btnSend.frame.size.height-kwheight-2,btnSend.frame.size.width, btnSend.frame.size.height)];
        
 //       [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height-kwheight-2,27,56)];
        
        [btnSmly setFrame:CGRectMake(btnSmly.frame.origin.x, [UIScreen mainScreen].bounds.size.height-btnSmly.frame.size.height-kwheight-2,btnSmly.frame.size.width,btnSmly.frame.size.height)];
        
        self.stickerCollection.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-kwheight, [UIScreen mainScreen].bounds.size.width,220);
        
        [stickerCollection setHidden:NO];
       
         ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,txtVwWriteChat.frame.origin.y-(FriendGroupCollectionView.frame.origin.y+FriendGroupCollectionView.frame.size.height));
        /*
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
            ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,274);
            
            
        }
        else
        {
            ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,174);
            
            
        }
        */
    }

}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
    
    
    [self.view bringSubviewToFront:_topview];
    [self.view bringSubviewToFront:_chattext];
    [self.view bringSubviewToFront:_backbtn];
    [self.view bringSubviewToFront:_plusBtn];
    [self.view bringSubviewToFront:txtVwWriteChat];
 //   [self.view bringSubviewToFront:_clip_button];
    [self.view bringSubviewToFront:btnSend];
    [self.view bringSubviewToFront:btnSmly];
    
    
    
    
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
        
        charcount=[[txtVwWriteChat text]length];
        
        [stickerCollection setHidden:YES];
        
        [txtVwWriteChat setFrame:CGRectMake(txtVwWriteChat.frame.origin.x,[UIScreen mainScreen].bounds.size.height-txtVwWriteChat.frame.size.height-kwheight-2,txtVwWriteChat.frame.size.width, txtVwWriteChat.frame.size.height)];
        
        [btnSend setFrame:CGRectMake(btnSend.frame.origin.x,[UIScreen mainScreen].bounds.size.height-btnSend.frame.size.height-kwheight-2,btnSend.frame.size.width, btnSend.frame.size.height)];
        
        //    [_clip_button setFrame:CGRectMake(_clip_button.frame.origin.x, [UIScreen mainScreen].bounds.size.height-_clip_button.frame.size.height-kwheight-2,27,56)];
        
        [btnSmly setFrame:CGRectMake(btnSmly.frame.origin.x, [UIScreen mainScreen].bounds.size.height-btnSmly.frame.size.height-kwheight-2,btnSmly.frame.size.width,btnSmly.frame.size.height)];
        
         ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,txtVwWriteChat.frame.origin.y-(FriendGroupCollectionView.frame.origin.y+FriendGroupCollectionView.frame.size.height));
        flag=0;
        
        /*
        if ([UIScreen mainScreen].bounds.size.width>320)
        {
          //  ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,230);
           
            
            
        }
        else
        {
            ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,174);
            
            
        }
        */
        
        
       
        
        
        
    }];

    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    keyboard=1;
    
    RS_JsonClass *globalobj=[[RS_JsonClass alloc]init];
    
    NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    login_user_id=[NSString stringWithFormat:@"%@",[UserData objectForKey:@"Login_User_id"]];
    
    //NSString *urlstring=[NSString stringWithFormat:@"%@chat_view.php?send_id=%@&rec_id=%@&start=0&end=70",App_Domain_Url,login_user_id,_getuser_id];
    
    NSString *urlstring=[NSString stringWithFormat:@"%@group_chat_view.php",App_Domain_Url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postData = [NSString stringWithFormat:@"send_id=%@&rec_id=%@&start=1&end=250",login_user_id,Login_user_Id];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [globalobj GlobalDict:request Globalstr:@"array" Withblock:^(id result, NSError *error)
     {
         
         chat_Data_array=[[NSMutableArray alloc]init];
         chat_Data_array=[[result objectForKey:@"details"] mutableCopy];
         
         NSLog(@"Chat data after textfield click: %@",chat_Data_array);
         
         [ChatTable reloadData];
         
         if(chat_Data_array.count > 0){
             
             [ChatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chat_Data_array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
             
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
            
            ChatTable.frame=CGRectMake(ChatTable.frame.origin.x, ChatTable.frame.origin.y, ChatTable.frame.size.width,ChatTable.frame.size.height-25);
            
            [ChatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chat_Data_array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            i--;
        }
        
        
        if (txtVwWriteChat.frame.size.height<150)
        {
            
            [txtVwWriteChat setFrame:CGRectMake(txtVwWriteChat.frame.origin.x, txtVwWriteChat.frame.origin.y-25,txtVwWriteChat.frame.size.width, txtVwWriteChat.frame.size.height+25)];
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
            
            
             NSLog(@"Here in the condition...");
            
            
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
            
            
        //    time=[[UILabel alloc]initWithFrame:CGRectMake(chat_design.frame.size.width-60,5, 150, 20)];
             time=[[UILabel alloc]initWithFrame:CGRectMake(chat_design.frame.origin.x+chat_design.frame.size.width-150,5, 150, 20)];
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
            NSLog(@"Message: %@",message.text);
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
            NSLog(@"Message: %@",message.text);
            [chat_design addSubview:message];
            
            
             time=[[UILabel alloc]initWithFrame:CGRectMake(chat_design.frame.origin.x+chat_design.frame.size.width-150,5, 150, 20)];
          //  time=[[UILabel alloc]initWithFrame:CGRectMake(chat_design.frame.size.width-80,5, 150, 20)];
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

- (IBAction)BackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end