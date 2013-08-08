//
//  ALFLightService.m
//  Alfred
//
//  Created by Pairing on 8/7/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightService.h"

@implementation ALFLightService

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)moc {
    self = [super init];
    if(self != nil) {
        _moc = moc;
    }
    return self;
}

- (NSArray *)allLights {
    NSError *error;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"ALFLight" inManagedObjectContext:_moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *lights = [_moc executeFetchRequest:request error:&error];
    if (lights == nil)
    {
        NSLog(@"could not fetch: %@", [error localizedDescription]);
        lights = [NSArray array];
    }
    return lights;
}

- (NSArray *)initializeLights {
    NSArray *lights = [self allLights];
    if([lights count] == 0) {
        NSMutableArray *newLights = [NSMutableArray array];
        NSManagedObject *almLight = [self makeLightWithName:@"alm"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/master-alm-continuous/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/backward-compatibility-of-migrations/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-guitest/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-java/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-chrome/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-firefox/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-flaky-finder-continuous/"];
        NSManagedObject *appsdkLight = [self makeLightWithName:@"appsdk"];
        [self makeProjectFor:appsdkLight withURL:@"http://alm-build:8080/hudson/view/App%20SDK/job/master-appsdk-continuous-js/"];
        [newLights addObject:almLight];
        [newLights addObject:appsdkLight];
    }
    return [self allLights];
}

- (NSManagedObject*)updateOverallStatusForLight:(NSManagedObject *)light {
    NSArray *projects = [light valueForKey:@"projects"];
    for (NSManagedObject *project in projects) {
        // [self updateStatusForProject: project]
    }
    BOOL result = [[light valueForKey:@"overallStatus"] boolValue];
    for (NSManagedObject *project in projects) {
        if([[project valueForKey:@"status"] isNotEqualTo: @"SUCCESS"]) {
            result = NO;
        }
    }
    [light setValue:[NSNumber numberWithBool:result] forKey:@"overallStatus"];
    return light;
}

- (NSManagedObject*) makeLightWithName:(NSString*)name {
    NSManagedObject *light = [NSEntityDescription
                              insertNewObjectForEntityForName:@"ALFLight"
                              inManagedObjectContext:_moc];
    [light setValue:name forKey:@"name"];
    return light;
}

- (NSManagedObject*) makeProjectFor:(NSManagedObject*)light withURL:(NSString*)url {
    NSManagedObject *project = [NSEntityDescription
                                insertNewObjectForEntityForName:@"ALFProject"
                                inManagedObjectContext:_moc];
    [project setValue:url forKey:@"url"];
    [project setValue:light forKey:@"light"];
    return project;
}

@end
