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
    [ALFLight initializeLightsUsingContext:self.managedObjectContext];
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

@end
