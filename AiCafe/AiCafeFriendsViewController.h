//
//  AiCafeFriendsViewController.h
//  AiCafe
//
//  Created by Somenath on 25/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RS_JsonClass.h"


@interface AiCafeFriendsViewController : UIViewController
{
    UITableViewCell *cell;
    RS_JsonClass *obj;
    
    int list_value;
}

@property (strong, nonatomic) IBOutlet UITableView *Friends_Table;
@end
