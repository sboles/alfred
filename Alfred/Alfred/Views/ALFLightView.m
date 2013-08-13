//
//  ALFLightView.m
//  Alfred
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightView.h"

@implementation ALFLightView

- (id)initWithStatusItem:(NSStatusItem *)statusItem overallStatus:(BOOL)status {
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    if (self != nil) {
        _status = status;
        _statusItem = statusItem;
        _statusItem.view = self;
    }
    return self;
}

- (void)dealloc {
    [[NSStatusBar systemStatusBar] removeStatusItem:_statusItem];
}

- (void)setStatus:(BOOL)status {
    _status = status;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
    if (_status) {
        [self drawGreen];
    } else {
        [self drawRed];
    }
}

- (void)drawGreen {
    NSColor *green = [NSColor colorWithCalibratedRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    [self drawColor:green];
}

- (void)drawRed {
    NSColor *red = [NSColor colorWithCalibratedRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    [self drawColor:red];
}

- (void)drawColor:(NSColor *)color {
    NSGraphicsContext *context = [NSGraphicsContext currentContext];
    [context saveGraphicsState];

    [color setFill];
    NSRect itemRect = NSMakeRect(self.frame.size.width / 4, self.frame.size.height / 4, self.frame.size.width / 2, self.frame.size.height / 2);
    NSRectFill(itemRect);

    [context restoreGraphicsState];
}

@end
