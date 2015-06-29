//
//  ChatInboxTableViewCell.m
//  AiCafe
//
//  Created by ios on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "ChatInboxTableViewCell.h"

@implementation ChatInboxTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
    _imageview.layer.cornerRadius=(_imageview.frame.size.width)/2;
    _imageview.clipsToBounds=YES;
    _imageview.contentMode=UIViewContentModeScaleAspectFill;
}

@end
