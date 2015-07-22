//
//  BlockListTableViewCell.h
//  AiCafe
//
//  Created by ios on 21/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *user_image;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *details;

@end
