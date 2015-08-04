//
//  ChatRoomViewController.h
//  AiCafe
//
//  Created by Priyanka ghosh on 29/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FriendCollectionViewCell.h"
#import "stickercell.h"
#import "UIImageView+WebCache.h"
#import "RS_JsonClass.h"
#import "AFHTTPClient.h"
#define kCellsPerRow 4
@interface ChatRoomViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    UIImageView *chat_person_image,*chat_design;
    
    NSMutableArray *chat_Data_array,*Friend_list_array,*chat_Data_array2;
    
    UIView *chatView;
    
    NSString *login_user_id;
    NSString *Login_user_Id ;
    
    UILabel *user_name,*message,*time,*fulltime;
    AVAudioPlayer *player;
    FriendCollectionViewCell *cell;
    stickercell *cell1;
    BOOL keyboard;
    NSInteger flag;
    NSInteger charcount;
    NSInteger myflag;
    CGFloat kwheight;
    NSInteger i;
    NSInteger up;
    
    NSString *alluserID;
    
    int data_limite;
}
- (IBAction)ChatSendClick:(id)sender;

- (IBAction)openStikerView:(id)sender;

- (IBAction)BackClick:(id)sender;
@property (nonatomic) CGFloat cellWidth;
@property (weak, nonatomic) IBOutlet UITableView *ChatTable;
@property (weak, nonatomic) IBOutlet UITextView *txtVwWriteChat;
@property (weak, nonatomic) IBOutlet UICollectionView *FriendGroupCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UIButton *btnSmly;
@property (weak, nonatomic) IBOutlet UICollectionView *stickerCollection;
@property (weak, nonatomic) IBOutlet UILabel *chattext;
@property (weak, nonatomic) IBOutlet UIImageView *plusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topview;
@property (weak, nonatomic) IBOutlet UIButton *backbtn;


@end
