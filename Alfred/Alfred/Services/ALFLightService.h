//
//  ALFLightService.h
//  Alfred
//
//  Created by Pairing on 8/7/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALFLightService : NSObject {
    @private
    NSManagedObjectContext *_moc;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)moc;
- (NSArray *)allLights;

@end
