//
//  ALFLightsArrayController.m
//  Alfred
//
//  Created by Pairing on 8/14/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightsArrayController.h"
#import "ALFLightView.h"
#import "ALFLightController.h"

@implementation ALFLightsArrayController

@synthesize lightControllers = _lightControllers;

-(void)prepareContent {
    [ALFLight initializeLightsUsingContext:self.managedObjectContext];

    NSArray* lights = [ALFLight allLightsUsingContext:self.managedObjectContext];
    [self addObjects:lights];
    NSArray *objects = [self arrangedObjects];
    NSLog(@"count: %li", (unsigned long)[objects count]);
    
    [self makeLightControllers];
}

-(void) makeLightControllers {
    // Install status items into the menu bar
    NSArray *lights = [ALFLight allLightsUsingContext:self.managedObjectContext];
    for (ALFLight *light in lights) {
        [self addLightControllerForLight:light];
    }
}

-(void)addLightControllerForLight:(NSManagedObject *)light {
    //create lightcontrollers
    ALFLightView *view = [ALFLightView lightView];
    ALFLightController *lightController = [[ALFLightController alloc] initWith:light withView:view withService:self.lightService];
    [lightController setUpdateInterval:30];
    [self.lightControllers setObject:lightController forKey:[light objectID]];
}

-(void)removeLightControllerForLight:(NSManagedObject *)light {
    ALFLightController *controller = [self.lightControllers objectForKey:[light objectID]];
    [controller removeLight];
    [self.lightControllers removeObjectForKey:[light objectID]];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectedObjects:@[]];
}

- (IBAction)addLight:(id)sender {
    NSLog(@"adding light");
    ALFLight *light = [ALFLight lightWithName:@"Light Name" usingContext:self.managedObjectContext];
    [self addObject:light];
    [self setSelectedObjects:@[light]];
    [self addLightControllerForLight:light];
}

- (IBAction)removeLight:(id)sender {
    for (ALFLight *light in [self selectedObjects]) {
        NSLog(@"removing light=%@", light);
        [self removeObject:light];
        [self removeLightControllerForLight:light];
    }
}

- (IBAction)lightSelected:(id)sender {
    for (ALFLight *light in [self selectedObjects]) {
        NSLog(@"selected light=%@", light);
    }    
}

- (NSMutableDictionary*) lightControllers {
    if(!_lightControllers) {
        _lightControllers = [NSMutableDictionary dictionary];
    }
    return _lightControllers;
}

- (void)setLightControllers:(NSMutableDictionary *)lightControllers {
    _lightControllers = lightControllers;
}

@end
