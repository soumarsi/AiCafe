//
//  UserLikeTableViewCell.h
//  AiCafe
//
//  Created by ios on 17/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLikeTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) UILabel *usertxt;
@property (nonatomic, strong) UIImageView *profileimg;
@property (nonatomic, strong) UIButton *likebtn;
@property (nonatomic, strong) UIView *divider;
@end
