//
//  ALFLightsArrayController.m
//  Alfred
//
//  Created by Pairing on 8/14/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightsArrayController.h"

@implementation ALFLightsArrayController

-(void)prepareContent {
    NSArray* lights = [ALFLight allLightsUsingContext:self.menuController.managedObjectContext];
    [self addObjects:lights];
    NSArray *objects = [self arrangedObjects];
    NSLog(@"count: %li", (unsigned long)[objects count]);
}

@end
