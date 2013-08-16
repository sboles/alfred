//
//  ALFController.m
//  Alfred
//
//  Created by Pairing on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightController.h"

@implementation ALFLightController

- (id)initWith:(NSManagedObject *)light withView:(ALFLightView *)view withService:(ALFLightService *)service {
    self = [super init];
    if (self != nil) {
        _light = light;
        _lightView = view;
        _lightService = service;
    }
    return self;
}

- (void)checkLightStatus {
    NSLog(@"checking light status...");
    [_lightService updateOverallStatusForLight:_light];
    _lightView.status = [[_light valueForKey:@"overallStatus"] boolValue];
}

- (void)setUpdateInterval:(NSTimeInterval)seconds {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(checkLightStatus) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)removeLight {
    [_lightView removeLight];
}

@end
