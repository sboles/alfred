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
    ALFLightView * view = [ALFApplicationContext makeLightView];
    controller = [[ALFLightController alloc] initWith: light withView: view];
    return controller;
}

- (void) testInitWithLight {
    ALFLightController *controller = [self makeController];
    STAssertNotNil(controller, @"controller is not nil");
}

- (void) testCheckLightStatus {
    ALFLightController *controller;
    NSManagedObject *light = [self makeLight];
    ALFLightView * view = [ALFApplicationContext makeLightView];
    [view setStatus:NO];
    controller = [[ALFLightController alloc] initWith: light withView: view];
    [controller checkLightStatus];
    STAssertEquals(view.status, YES, @"status should have been updated");
}

@end
