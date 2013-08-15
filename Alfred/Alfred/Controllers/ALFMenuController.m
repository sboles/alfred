//
//  ALFMenuController.m
//  Alfred
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFMenuController.h"
#import "AlFLight.h"
#import "ALFProject.h"

@implementation ALFMenuController

- (void) prepareContent {
    [super prepareContent];
    [self initializeLights];
    [self makeLightControllers];
}

- (void) makeLightControllers {
    // Install status items into the menu bar
    NSArray *lights = [ALFLight allLightsUsingContext:self.managedObjectContext];
    for (NSManagedObject *light in lights) {
        //create lightcontrollers
        ALFLightView *view = [ALFLightView lightView];
        ALFLightController *lightController = [[ALFLightController alloc] initWith:light withView:view withService:self.lightService];
        [lightController setUpdateInterval:30];
        [self addObject:lightController];
    }
}

- (void)initializeLights {
    NSArray *lights = [ALFLight allLightsUsingContext:self.managedObjectContext];
    if ([lights count] == 0) {
        NSMutableArray *newLights = [NSMutableArray array];
        NSManagedObject *almLight = [ALFLight lightWithName:@"alm" usingContext:self.managedObjectContext];
        [ALFProject projectWithLight: almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/master-alm-continuous/" usingContext:self.managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/backward-compatibility-of-migrations/" usingContext:self.managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-guitest/" usingContext:self.managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-chrome/" usingContext:self.managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-firefox/" usingContext:self.managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-java/" usingContext:self.managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-flaky-finder-continuous/" usingContext:self.managedObjectContext];
        [ALFProject projectWithLight:almLight withURL:@"http://alm-build:8080/hudson/job/master-appsdk-continuous-js/" usingContext:self.managedObjectContext];
        [newLights addObject:almLight];
    }
}

@end
