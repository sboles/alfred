//
//  ALFLightsArrayController.m
//  Alfred
//
//  Created by Pairing on 8/14/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightsArrayController.h"
#import "ALFLightView.h"
#import "ALFLightController.h"

@implementation ALFLightsArrayController

-(void)prepareContent {
    [ALFLight initializeLightsUsingContext:self.managedObjectContext];

    NSArray* lights = [ALFLight allLightsUsingContext:self.managedObjectContext];
    [self addObjects:lights];
    NSArray *objects = [self arrangedObjects];
    NSLog(@"count: %li", (unsigned long)[objects count]);
    
    [self makeLightControllers];
}

- (void) makeLightControllers {
    // Install status items into the menu bar
    NSArray *lights = [ALFLight allLightsUsingContext:self.managedObjectContext];
    for (NSManagedObject *light in lights) {
        [self addLightControllerForLight:light];
    }
}

- (void)addLightControllerForLight:(NSManagedObject *)light {
    //create lightcontrollers
    ALFLightView *view = [ALFLightView lightView];
    ALFLightController *lightController = [[ALFLightController alloc] initWith:light withView:view withService:self.lightService];
    [lightController setUpdateInterval:30];
    [self.lightControllers setObject:lightController forKey:[light valueForKey:@"name"]];
}

@end
