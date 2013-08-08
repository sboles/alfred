//
//  ALFController.m
//  Alfred
//
//  Created by Pairing on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightController.h"

@implementation ALFLightController

- (id) initWith:(NSManagedObject *)light withView:(ALFLightView*)view withService:(ALFLightService*)service {
    self = [super init];
    if(self != nil) {
        _light = light;
        _lightView = view;
        _lightService = service;
    }
    return self;
}

- (void) checkLightStatus {
    [_lightService updateOverallStatusForLight: _light];
    _lightView.status = [[_light valueForKey:@"overallStatus"] boolValue];
}

@end
