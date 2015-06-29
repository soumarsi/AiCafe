//
//  Side_menu.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 29/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "Side_menu.h"

@implementation Side_menu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"SideMenu" owner:self options:nil]objectAtIndex:0];
    }
    return self;
}


@end
