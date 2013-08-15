//
//  ALFLightView.h
//  Alfred
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ALFLightView : NSView {
@private
    NSStatusItem *_statusItem;
    BOOL _status;
}

+ (id)lightView;

- (id)initWithStatusItem:(NSStatusItem *)statusItem overallStatus:(BOOL)status;

@property(nonatomic) BOOL status;

@end
