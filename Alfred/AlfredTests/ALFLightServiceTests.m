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

- (void)testReinitializeLights {
    ALFLightService *service = [[ALFLightService alloc] initWithManagedObjectContext: self.moc];
    NSArray *lights = [service initializeLights];
    const NSUInteger expectedLength = 2;
    STAssertEquals([lights count], expectedLength, @"should have two initialized lights");
    STAssertEqualObjects([[self getLightWithName: @"alm" fromAllLights:lights] valueForKey:@"name"], @"alm", @"light name should be alm");
    STAssertEqualObjects([[self getLightWithName: @"appsdk" fromAllLights:lights]  valueForKey:@"name"], @"appsdk", @"light name should be appsdk");
    STAssertTrue([[[self getLightWithName: @"alm" fromAllLights:lights]  valueForKey:@"projects"] count] == 7, @"alm light project count should be %d", 7);
    STAssertTrue([[[self getLightWithName: @"appsdk" fromAllLights:lights] valueForKey:@"projects"] count] == 1, @"appsdk light project count should be %d", 1);
    
    lights = [service initializeLights];
    STAssertEquals([lights count], expectedLength, @"should have two initialized lights");
    STAssertEqualObjects([[self getLightWithName: @"alm" fromAllLights:lights]  valueForKey:@"name"], @"alm", @"light name should be alm");
    STAssertEqualObjects([[self getLightWithName: @"appsdk" fromAllLights:lights] valueForKey:@"name"], @"appsdk", @"light name should be appsdk");
    STAssertTrue([[[self getLightWithName: @"alm" fromAllLights:lights]  valueForKey:@"projects"] count] == 7, @"alm light project count should be %d", 7);
    STAssertTrue([[[self getLightWithName: @"appsdk" fromAllLights:lights] valueForKey:@"projects"] count] == 1, @"appsdk light project count should be %d", 1);
}

- (NSManagedObject*) getLightWithName:(NSString*)name fromAllLights:(NSArray*)allLights {
    for (NSManagedObject *o in allLights) {
        if([[o valueForKey:@"name"] isEqualTo:name]){
            return o;
        }
    }
    return nil;
}

- (void)testUpdateOverallStatusForLight {
    // setup
    NSManagedObject* project = [self makeProject];
    NSManagedObject* light = [project valueForKey:@"light"];
    [project setValue:@"FAILED" forKey:@"status"];
    
    // test
    ALFLightService *service = [[ALFLightService alloc] initWithManagedObjectContext: self.moc];
    [service updateOverallStatusForLight: light];
    STAssertEquals([[light valueForKey:@"overallStatus"] boolValue], NO, @"status should be YES");
}

- (void) testUpdateStatusForProject {
    // setup
    NSManagedObject* project = [self makeProject];
    ALFLightService *service = [[ALFLightService alloc] initWithManagedObjectContext: self.moc];
    [service updateStatusForProject: project];
    STAssertEqualObjects([project valueForKey:@"status"], @"SUCCESS", @"status should be SUCCESS");
}

@end
