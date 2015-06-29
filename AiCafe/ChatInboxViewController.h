//
//  ChatInboxViewController.h
//  AiCafe
//
//  Created by ios on 08/06/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RS_JsonClass.h"

@interface ChatInboxViewController : UIViewController
{
    RS_JsonClass *obj;
}

@property (weak, nonatomic) IBOutlet UITableView *tabview;

@end

