//
//  ALFMenuController.m
//  Alfred
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFMenuController.h"

@implementation ALFMenuController

- (void) prepareContent {
    [super prepareContent];
    [self makeLightControllers];
}

- (void) makeLightControllers {
    // Install status items into the menu bar
    NSArray *lights = [self allLights];
    for (NSManagedObject *light in lights) {
        //create lightcontrollers
        ALFLightView *view = [ALFApplicationContext makeLightView];
        ALFLightController *lightController = [[ALFLightController alloc] initWith:light withView:view withService:self.lightService];
        [lightController setUpdateInterval:30];
        [self addObject:lightController];
    }
}

- (void)initializeLights {
    NSArray *lights = [self allLights];
    if ([lights count] == 0) {
        NSMutableArray *newLights = [NSMutableArray array];
        NSManagedObject *almLight = [self makeLightWithName:@"alm"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/master-alm-continuous/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/backward-compatibility-of-migrations/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-guitest/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-chrome/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-firefox/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-java/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-flaky-finder-continuous/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-appsdk-continuous-js/"];
        [newLights addObject:almLight];
    }
}

- (NSArray *)allLights {
    NSError *error;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"ALFLight" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *lights = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (lights == nil) {
        NSLog(@"could not fetch: %@", [error localizedDescription]);
        lights = [NSArray array];
    }
    return lights;
}

- (NSManagedObject *)makeLightWithName:(NSString *)name {
    NSManagedObject *light = [NSEntityDescription
                              insertNewObjectForEntityForName:@"ALFLight"
                              inManagedObjectContext:self.managedObjectContext];
    [light setValue:name forKey:@"name"];
    return light;
}

- (NSManagedObject *)makeProjectFor:(NSManagedObject *)light withURL:(NSString *)url {
    NSManagedObject *project = [NSEntityDescription
                                insertNewObjectForEntityForName:@"ALFProject"
                                inManagedObjectContext:self.managedObjectContext];
    [project setValue:url forKey:@"url"];
    [project setValue:light forKey:@"light"];
    return project;
}

@end
