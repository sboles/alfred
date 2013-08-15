//
//  ALFMenuController.h
//  Alfred
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALFLightController.h"

@interface ALFMenuController : NSArrayController

@property (weak) IBOutlet ALFLightService *lightService;

@end
