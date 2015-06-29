//
//  stickercell.m
//  AiCafe
//
//  Created by anirban on 23/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "stickercell.h"

@implementation stickercell
-(void)setImage:(UIImage *)sticker{

    self.stickerImg.image = sticker;
    self.stickerImg.contentMode = UIViewContentModeScaleAspectFit;
}
@end
