//
//  ALFLight.h
//  Alfred
//
//  Created by Steven Boles on 8/15/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ALFLight : NSManagedObject

+ (id) lightWithName:(NSString *)name usingContext:(NSManagedObjectContext *)managedObjectContext;
+ (NSArray *)allLightsUsingContext:(NSManagedObjectContext*)managedObjectContext;
+ (void)initializeLightsUsingContext:(NSManagedObjectContext*)managedObjectContext;

@end
