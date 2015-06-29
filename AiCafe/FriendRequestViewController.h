//
//  FriendRequestViewController.h
//  AiCafe
//
//  Created by Soumen on 25/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendRequestTableViewCell.h"
#import "RS_JsonClass.h"

@interface FriendRequestViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
   // FriendRequestTableViewCell *cell;
    
    NSMutableArray *Friend_request;
   // NSMutableArray *details;
    //NSString *User_Id;
    NSString *friendstr;
    
    NSInteger custom_index;
    
    NSIndexPath *myindex;
    RS_JsonClass *globalobj;
    UIButton *AcceptButton;
    NSMutableArray *remove_array;
    UIButton *DenieButton;
    UILabel *user_name;
    UILabel *business;
    UILabel *about;
    UIImageView *user_profile_image;
    NSString *status;
    NSString *Login_user_Id;
}
@property (strong, nonatomic) IBOutlet UITableView *Friends_Table;

- (IBAction)Back_to_main:(id)sender;


@end
