//
//  stickercell.h
//  AiCafe
//
//  Created by anirban on 23/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stickercell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *stickerImg;
-(void)setImage:(UIImage *)sticker;
@end
