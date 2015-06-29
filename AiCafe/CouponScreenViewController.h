//
//  CouponScreenViewController.h
//  AiCafe
//
//  Created by Soumen on 04/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
@interface CouponScreenViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,Slide_menu_delegate>
{
    Side_menu *sidemenu;
}

- (IBAction)side_menu:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *baseView;


@end
