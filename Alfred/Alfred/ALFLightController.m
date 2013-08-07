//
//  ALFController.m
//  Alfred
//
//  Created by Pairing on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightController.h"

@implementation ALFLightController

- (id) initWith:(NSManagedObject *)light {
    self = [super init];
    if(self != nil) {
        _light = light;
    }
    return self;
}

- (void) checkLightStatus {
    // call service to check light status
    [self updateStatusTo:YES];
    // update view
}

-(void) updateStatusTo:(BOOL)status
{
    [_light setValue:[NSNumber numberWithBool:status] forKey:@"overallStatus"];
}

@end
