//
//  ALFLightServiceTests.m
//  Alfred
//
//  Created by Pairing on 8/7/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightServiceTests.h"

@implementation ALFLightServiceTests

- (void)testAllLights
{
    // setup
    NSManagedObject* project = [self makeProject];
    NSManagedObject* light = [project valueForKey:@"light"];
    NSError *error;
    if (![self.moc save:&error]) {
        STFail(@"could not save: %@", [error localizedDescription]);
    }

    // test
    ALFLightService *service = [[ALFLightService alloc] initWithManagedObjectContext: self.moc];
    NSArray* lights = [service allLights];
    const NSUInteger expectedLength = 1;
    STAssertEquals([lights count], expectedLength, @"should have one light");
    STAssertEquals([[lights objectAtIndex:0] valueForKey:@"name"], [light valueForKey:@"name"], @"light name should be equal");
}

@end
