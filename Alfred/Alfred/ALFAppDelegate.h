//
//  ALFAppDelegate.h
//  Alfred
//
//  Created by Steven Boles on 8/5/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ALFMenuController.h"

@interface ALFAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) ALFMenuController *menuController;

- (IBAction)saveAction:(id)sender;

@end
