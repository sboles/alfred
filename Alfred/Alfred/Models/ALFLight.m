//
//  ALFLight.m
//  Alfred
//
//  Created by Steven Boles on 8/15/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLight.h"

@implementation ALFLight

+ (id) lightWithName:(NSString *)name usingContext:(NSManagedObjectContext *)managedObjectContext {
    ALFLight *light = [NSEntityDescription
                              insertNewObjectForEntityForName:@"ALFLight"
                              inManagedObjectContext:managedObjectContext];
    [light setValue:name forKey:@"name"];
    return light;
}

+ (NSArray *)allLightsUsingContext:(NSManagedObjectContext *)managedObjectContext {
    NSError *error;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"ALFLight" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *lights = [managedObjectContext executeFetchRequest:request error:&error];
    if (lights == nil) {
        NSLog(@"could not fetch: %@", [error localizedDescription]);
        lights = [NSArray array];
    }
    return lights;
}

@end
