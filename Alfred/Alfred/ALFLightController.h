//
//  ALFController.h
//  Alfred
//
//  Created by Pairing on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALFLightView.h"
#import "ALFLightService.h"

@interface ALFLightController : NSObject {
@private
    NSManagedObject *_light;
    ALFLightView *_lightView;
    ALFLightService *_lightService;
    NSTimer *_timer;
}

- (id)initWith:(NSManagedObject *)light withView:(ALFLightView *)view withService:(ALFLightService *)service;

- (void)checkLightStatus;

- (void)setUpdateInterval:(NSTimeInterval)seconds;

@end
