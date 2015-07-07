//
//  FriendCollectionViewCell.h
//  AiCafe
//
//  Created by Priyanka ghosh on 29/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *FriendImg;
@property (weak, nonatomic) IBOutlet UIView *NoofChatView;

-(void)setImage:(UIImage *)Friends;
@end
