//
//  ChatViewController.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{

    UIImageView *chat_person_image,*chat_design;
    
    NSMutableArray *chat_Data_array;
    
    UIView *chatView;
    
    NSString *login_user_id;
    
    UILabel *user_name,*message,*time;
}
@property (weak, nonatomic) IBOutlet UITableView *chat_table;
@property (weak, nonatomic) IBOutlet UITextView *chatbox;
- (IBAction)send_button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *send_button;

@property (weak, nonatomic) IBOutlet UIImageView *clip_button;
@end
