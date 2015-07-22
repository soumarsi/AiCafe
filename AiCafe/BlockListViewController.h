//
//  BlockListViewController.h
//  AiCafe
//
//  Created by ios on 21/07/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *BlockListTabview;
@property(strong,nonatomic) NSMutableArray *blockarray;

@end
