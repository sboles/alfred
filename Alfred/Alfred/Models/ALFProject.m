//
//  ALFProject.m
//  Alfred
//
//  Created by Steven Boles on 8/15/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFProject.h"

@implementation ALFProject

+ (id)projectWithLight:(NSManagedObject *)light withURL:(NSString *)url usingContext:(NSManagedObjectContext*)managedObjectContext {
    ALFProject *project = [NSEntityDescription
                                insertNewObjectForEntityForName:@"ALFProject"
                                inManagedObjectContext:managedObjectContext];
    [project setValue:url forKey:@"url"];
    [project setValue:light forKey:@"light"];
    return project;
}

@end
