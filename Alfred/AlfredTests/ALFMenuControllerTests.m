//
//  ALFMenuControllerTests.m
//  Alfred
//
//  Created by Steven Boles on 8/14/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFMenuControllerTests.h"

@implementation ALFMenuControllerTests

- (void)testAllLights {
    // setup
    NSManagedObject *project = [self makeProject];
    NSManagedObject *light = [project valueForKey:@"light"];
    NSError *error;
    if (![self.moc save:&error]) {
        STFail(@"could not save: %@", [error localizedDescription]);
    }
    
    // test
    ALFLightService *service = [[ALFLightService alloc] init];
    ALFMenuController *controller = [[ALFMenuController alloc] init];
    [controller setLightService:service];
    [controller setManagedObjectContext:self.moc];
    NSArray *lights = [controller allLights];
    const NSUInteger expectedLength = 1;
    STAssertEquals([lights count], expectedLength, @"should have one light");
    STAssertEquals([[lights objectAtIndex:0] valueForKey:@"name"], [light valueForKey:@"name"], @"light name should be equal");
}

- (void)testInitializeLights {
    ALFLightService *service = [[ALFLightService alloc] init];
    ALFMenuController *controller = [[ALFMenuController alloc] init];
    [controller setLightService:service];
    [controller setManagedObjectContext:self.moc];
    [controller initializeLights];
    NSArray *lights = [controller allLights];
    const NSUInteger expectedLength = 1;
    STAssertEquals([lights count], expectedLength, @"should have two initialized lights");
    STAssertEqualObjects([[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"name"], @"alm", @"light name should be alm");
    STAssertTrue([[[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"projects"] count] == 8, @"alm light project count should be %d", 7);
    
    [controller initializeLights];
    lights = [controller allLights];
    STAssertEquals([lights count], expectedLength, @"should have two initialized lights");
    STAssertEqualObjects([[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"name"], @"alm", @"light name should be alm");
    STAssertTrue([[[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"projects"] count] == 8, @"alm light project count should be %d", 7);
}

- (NSManagedObject *)getLightWithName:(NSString *)name fromAllLights:(NSArray *)allLights {
    for (NSManagedObject *o in allLights) {
        if ([[o valueForKey:@"name"] isEqualTo:name]) {
            return o;
        }
    }
    return nil;
}

@end
