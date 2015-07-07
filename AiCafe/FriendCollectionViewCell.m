//
//  FriendCollectionViewCell.m
//  AiCafe
//
//  Created by Priyanka ghosh on 29/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "FriendCollectionViewCell.h"

@implementation FriendCollectionViewCell
-(void)setImage:(UIImage *)memberImg
{
    
    self.FriendImg.image = memberImg;
    
    
     self.NoofChatView.layer.cornerRadius=(self.NoofChatView.frame.size.width)/2;
}
@end
