//
//  ALFController.h
//  Alfred
//
//  Created by Pairing on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALFLightView.h"
#import "ALFApplicationContext.h"

@interface ALFLightController : NSObject {
    @private
    NSManagedObject *_light;
    ALFLightView *_lightView;
}

- (id) initWith:(NSManagedObject*)light withView:(ALFLightView*)view;
- (void) checkLightStatus;

@end
