//
//  ALFProject.h
//  Alfred
//
//  Created by Steven Boles on 8/15/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ALFProject : NSManagedObject

+ (id)projectWithLight:(NSManagedObject *)light withURL:(NSString *)url usingContext:(NSManagedObjectContext*)managedObjectContext;

@end
