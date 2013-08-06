//
//  ALFMenuController.m
//  Alfred
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFMenuController.h"

@implementation ALFMenuController

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)moc;
{
    self = [super init];
    if (self != nil)
    {
        _moc = moc;
        lightControllers = [NSMutableArray array];
        
        // Install status items into the menu bar
        NSArray * lights = [self allLights];
        for (NSManagedObject * light in lights) {
            [self initControllerWithLight:light];
        }
    }
    return self;
}

// This goes away once we have a real light controller
- (void) initControllerWithLight:(NSManagedObject*) light {
    CGFloat length = [[NSStatusBar systemStatusBar] thickness];
    NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: length];
    ALFLightView *lightView = [[ALFLightView alloc] initWithStatusItem:statusItem overallStatus:NO];
    [lightControllers addObject: lightView];
    [lightView setStatus:YES];
}

// This gets refactored into a service
- (NSArray *) allLights {
    NSManagedObject *light = [NSEntityDescription
                              insertNewObjectForEntityForName:@"ALFLight"
                              inManagedObjectContext: _moc];
    [light setValue:@"alm" forKey:@"name"];
    NSManagedObject *project = [NSEntityDescription
                                insertNewObjectForEntityForName:@"ALFProject"
                                inManagedObjectContext: _moc];
    [project setValue:@"http://alm-build:8080/hudson/view/%20%20master/job/master-alm-continuous/" forKey:@"url"];
    [project setValue:light forKey:@"light"];
    NSManagedObject *appsdklight = [NSEntityDescription
                              insertNewObjectForEntityForName:@"ALFLight"
                              inManagedObjectContext: _moc];
    [appsdklight setValue:@"appsdk" forKey:@"name"];
    return [NSArray arrayWithObjects: light, appsdklight, nil];
}
@end
