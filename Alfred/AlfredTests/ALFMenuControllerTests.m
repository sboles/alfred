//
//  ALFMenuControllerTests.m
//  Alfred
//
//  Created by Steven Boles on 8/14/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFMenuControllerTests.h"

@implementation ALFMenuControllerTests

- (void)testInitializeLights {
    ALFLightService *service = [[ALFLightService alloc] init];
    ALFMenuController *controller = [[ALFMenuController alloc] init];
    [controller setLightService:service];
    [controller setManagedObjectContext:self.moc];
    [controller initializeLights];
    NSArray *lights = [ALFLight allLightsUsingContext:self.moc];
    const NSUInteger expectedLength = 1;
    STAssertEquals([lights count], expectedLength, @"should have one initialized lights");
    STAssertEqualObjects([[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"name"], @"alm", @"light name should be alm");
    STAssertTrue([[[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"projects"] count] == 8, @"alm light project count should be %d", 7);
    
    [controller initializeLights];
    lights = [ALFLight allLightsUsingContext:self.moc];
    STAssertEquals([lights count], expectedLength, @"should have one initialized lights");
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
