//
//  AddFriendTableViewCell.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 21/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *user_profile_image;
@property (strong, nonatomic) IBOutlet UILabel *user_name;
@property (strong, nonatomic) IBOutlet UILabel *descriptiohn;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *ChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *AddFriendBtn;

@end
