//
//  MainScreenViewController.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 21/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Side_menu.h"
#import "RS_JsonClass.h"
#import "ChatRoomViewController.h"

@interface MainScreenViewController : UIViewController<Slide_menu_delegate>
{
    NSString *user_image_data,*user_name_info,*user_business_info,*user_sex_info;
    
    Side_menu *sidemenu;
    RS_JsonClass *obj;
    
}

@property (strong, nonatomic) IBOutlet UIView *row_view1;

@property (strong, nonatomic) IBOutlet UIView *row_view2;

@property (strong, nonatomic) IBOutlet UIView *row_view3;

- (IBAction)Add_friend_button:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *user_image;

@property (strong, nonatomic) IBOutlet UILabel *user_name;

@property (strong, nonatomic) IBOutlet UILabel *user_status;

@property (strong, nonatomic) IBOutlet UILabel *user_age;

@property (strong, nonatomic) IBOutlet UILabel *user_sex;

@property (strong, nonatomic) IBOutlet UILabel *user_business;


- (IBAction)Side_button:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *baseView;

@end
