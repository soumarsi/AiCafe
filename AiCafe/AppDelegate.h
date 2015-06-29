//
//  AppDelegate.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 18/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PTPusherDelegate.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{


     NSString *PUSHER_API_KEY;
     NSString *PUSHER_CHANNEL;
     NSString *PUSHER_EVENT;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) PTPusher *pusherClient;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

