//
//  AddFriendsViewController.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 21/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddFriendTableViewCell.h"
@interface AddFriendsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    AddFriendTableViewCell *cell;
    
    NSMutableArray *Friend_list;
    //NSString *User_Id;
    NSString *friendstr;
    
    NSInteger custom_index;
    
    NSIndexPath *myindex;
    
    UIButton *AddFriendBtn;
    NSMutableArray *remove_array;
    UIButton *ChatBtn;
    UILabel *user_name;
    UILabel *descriptiohn;
    UILabel *time;
    UIImageView *user_profile_image;
}
@property (strong, nonatomic) IBOutlet UITableView *Friends_Table;

- (IBAction)back_tomainPage:(id)sender;


@end
