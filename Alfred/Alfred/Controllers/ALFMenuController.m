//
//  ALFMenuController.m
//  Alfred
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFMenuController.h"

@implementation ALFMenuController

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)moc withLightService:(ALFLightService *)lightService {
    self = [super init];
    if (self != nil)
    {
        _moc = moc;
        lightControllers = [NSMutableArray array];
        
        // Install status items into the menu bar
        NSArray * lights = [lightService allLights];
        for (NSManagedObject * light in lights) {
            //create lightcontrollers
            ALFLightView * view = [ALFApplicationContext makeLightView];
            ALFLightController *lightController = [[ALFLightController alloc] initWith:light withView:view withService:lightService];
            [lightControllers addObject: lightController];
        }
    }
    return self;
}

@end
