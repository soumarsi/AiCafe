//
//  ChatInboxTableViewCell.h
//  AiCafe
//
//  Created by ios on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatInboxTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *msg;
@property (strong, nonatomic) IBOutlet UIImageView *online_status;
@property (strong, nonatomic) IBOutlet UIButton *chatbutton;
@end
