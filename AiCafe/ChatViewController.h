//
//  ChatViewController.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{

    UIImageView *chat_person_image,*chat_design;
    
    NSMutableArray *chat_Data_array;
    
    UIView *chatView;
    
    NSString *login_user_id;
    
    UILabel *user_name,*message,*time,*fulltime;
    AVAudioPlayer *player;
    
    BOOL keyboard;
    
    NSMutableAttributedString *aAttrString1;
}
- (IBAction)openStickerview:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *stickerCollection;
@property (nonatomic) CGFloat cellWidth;
@property (strong, nonatomic) IBOutlet UIButton *smly;

@property (strong, nonatomic) IBOutlet UIImageView *topview;
@property (strong, nonatomic) IBOutlet UILabel *chattext;
@property (strong, nonatomic) IBOutlet UIButton *backbtn;
@property (strong, nonatomic) IBOutlet UIImageView *plusBtn;
@property (weak, nonatomic) IBOutlet UITableView *chat_table;
@property (weak, nonatomic) IBOutlet UITextView *chatbox;
- (IBAction)send_button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *send_button;

@property (weak, nonatomic) IBOutlet UIImageView *clip_button;
@property (weak, nonatomic) IBOutlet UIButton *Smiley_Button;

@property(nonatomic,strong)NSString *getuser_id;
- (IBAction)back_button:(id)sender;

@end
