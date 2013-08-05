//
//  ALFAppDelegate.h
//  Alfred
//
//  Created by Steven Boles on 8/5/13.
//  Copyright (c) 2013 Mobian Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ALFAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
