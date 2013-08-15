//
//  ALFLightsArrayController.h
//  Alfred
//
//  Created by Pairing on 8/14/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ALFLight.h"

@class ALFLightService;

@interface ALFLightsArrayController : NSArrayController

@property (weak) IBOutlet ALFLightService *lightService;
@property NSMutableDictionary *lightControllers;

@end
