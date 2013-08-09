//
//  ALFApplicationContext.m
//  Alfred
//
//  Created by Pairing on 8/7/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFApplicationContext.h"

@implementation ALFApplicationContext

+(ALFLightView*) makeLightView {
    CGFloat length = [[NSStatusBar systemStatusBar] thickness];
    NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: length];
    ALFLightView *lightView = [[ALFLightView alloc] initWithStatusItem:statusItem overallStatus:YES];
    [lightView setStatus:YES];
    return lightView;
}

@end
