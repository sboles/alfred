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
    ALFLightService * lightService = [[ALFLightService alloc] init];
    controller = [[ALFLightController alloc] initWith: light withView: view withService:lightService];
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
    ALFLightService * lightService = [[ALFLightService alloc] init];
    controller = [[ALFLightController alloc] initWith: light withView: view withService:lightService];
    [controller checkLightStatus];
    STAssertEquals(view.status, YES, @"status should have been updated");
}

@end
