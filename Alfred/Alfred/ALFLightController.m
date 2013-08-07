//
//  ALFController.m
//  Alfred
//
//  Created by Pairing on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightController.h"

@implementation ALFLightController

- (id) initWith:(NSManagedObject *)light withView:(ALFLightView*)view {
    self = [super init];
    if(self != nil) {
        _light = light;
        _lightView = view;
    }
    return self;
}

- (void) checkLightStatus {
    // call service to check light status
    BOOL status = YES; //dummied from service

    [_light setValue:[NSNumber numberWithBool:status] forKey:@"overallStatus"];
    _lightView.status = status;
}

@end
