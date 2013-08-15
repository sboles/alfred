//
//  ALFLight.m
//  Alfred
//
//  Created by Steven Boles on 8/15/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLight.h"
#import "ALFProject.h"

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

+ (void)initializeLightsUsingContext:(NSManagedObjectContext*)managedObjectContext {
    NSArray *lights = [ALFLight allLightsUsingContext:managedObjectContext];
    if ([lights count] == 0) {
        NSMutableArray *newLights = [NSMutableArray array];
        NSManagedObject *almLight = [ALFLight lightWithName:@"alm" usingContext:managedObjectContext];
        [ALFProject projectWithLight: almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/master-alm-continuous/" usingContext:managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/backward-compatibility-of-migrations/" usingContext:managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-guitest/" usingContext:managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-chrome/" usingContext:managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-firefox/" usingContext:managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-java/" usingContext:managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-flaky-finder-continuous/" usingContext:managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-appsdk-continuous-js/" usingContext:managedObjectContext];
        [newLights addObject:almLight];
    }
}

@end
