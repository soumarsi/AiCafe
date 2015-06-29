//
//  UserLikeViewController.h
//  AiCafe
//
//  Created by ios on 17/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLikeTableViewCell.h"

@interface UserLikeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *UserLikeTabView;

@end
