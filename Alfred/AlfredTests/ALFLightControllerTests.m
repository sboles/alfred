//
//  ALFControllerTests.m
//  Alfred
//
//  Created by Pairing on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightControllerTests.h"

@implementation ALFLightControllerTests

- (ALFLightController*)makeController {
    ALFLightController *controller;
    NSManagedObject *light = [self makeLight];
    controller = [[ALFLightController alloc] initWith: light];
    return controller;
}

- (void) testInitWithLight {
    ALFLightController *controller = [self makeController];
    STAssertNotNil(controller, @"controller is not nil");
}

- (void) testCheckLightStatus {
    ALFLightController *controller = [self makeController];
   [controller checkLightStatus];
}

@end
