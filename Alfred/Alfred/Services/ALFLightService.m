//
//  ALFLightService.m
//  Alfred
//
//  Created by Pairing on 8/7/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightService.h"

@implementation ALFLightService

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)moc {
    self = [super init];
    if(self != nil) {
        _moc = moc;
    }
    return self;
}

- (NSArray *)allLights {
    NSError *error;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"ALFLight" inManagedObjectContext:_moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *lights = [_moc executeFetchRequest:request error:&error];
    if (lights == nil)
    {
        NSLog(@"could not fetch: %@", [error localizedDescription]);
        lights = [NSArray array];
    }
    return lights;
}

@end
