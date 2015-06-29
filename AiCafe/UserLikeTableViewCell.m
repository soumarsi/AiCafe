//
//  UserLikeTableViewCell.m
//  AiCafe
//
//  Created by ios on 17/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "UserLikeTableViewCell.h"

@implementation UserLikeTableViewCell

@synthesize timeLabel = timeLabel;
@synthesize username = username;
@synthesize profileimg = profileimg;
@synthesize usertxt = usertxt;
@synthesize likebtn = likebtn;
@synthesize divider = divider;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
   
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 50, 150, 30)];
    [timeLabel setTextColor:[UIColor whiteColor]];
    [timeLabel setFont:[UIFont fontWithName:@"OpenSans" size:15]];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.timeLabel];
        
    username = [[UILabel alloc] initWithFrame:CGRectMake(77, 11, 150, 30)];
    [username setTextColor:[UIColor colorWithRed:(78/255.f) green:(39/255.f) blue:(14/255.f) alpha:1.0f]];
    [username setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:18]];
    [username setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.username];
        
    usertxt = [[UILabel alloc] initWithFrame:CGRectMake(92, 31, 150, 30)];
        [usertxt setTextColor:[UIColor whiteColor]];
    [usertxt setFont:[UIFont fontWithName:@"OpenSans" size:15]];
    [username setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.usertxt];
        
     profileimg =[[UIImageView alloc] initWithFrame:CGRectMake(12,17,65,65)];
     profileimg.image = [UIImage imageNamed:@"demo_image2"];
    [self addSubview:self.profileimg];
        
    divider=[[UIView alloc]initWithFrame:CGRectMake(0,89,[UIScreen mainScreen].bounds.size.width,1)];
    [divider setBackgroundColor:[UIColor colorWithRed:(78/255.f) green:(39/255.f) blue:(14/255.f) alpha:1]];
    [self addSubview:self.divider];
        
    if([UIScreen mainScreen].bounds.size.width==375)
    {
    likebtn=[[UIButton alloc]initWithFrame:CGRectMake(246, 22, 114, 37)];
    [likebtn setImage:[UIImage imageNamed:@"userlike"] forState:UIControlStateNormal];
    [self addSubview:self.likebtn];
    }
    else if ([UIScreen mainScreen].bounds.size.width==414)
    {
    likebtn=[[UIButton alloc]initWithFrame:CGRectMake(256, 22, 124, 40)];
    [likebtn setImage:[UIImage imageNamed:@"userlike"] forState:UIControlStateNormal];
    [self addSubview:self.likebtn];
       
    }
    else
    {
    likebtn=[[UIButton alloc]initWithFrame:CGRectMake(224, 22, 92, 34)];
    [likebtn setImage:[UIImage imageNamed:@"userlike"] forState:UIControlStateNormal];
    [self addSubview:self.likebtn];
        
    }
  
    

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
