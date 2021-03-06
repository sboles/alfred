//
//  ALFProjectTests.m
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Mobian Solutions. All rights reserved.
//

#import "ALFDataTests.h"

@implementation ALFDataTests

- (void)testSaveEntities {
    [self makeLight];
    [self makeProject];
    NSError *error;
    if (![self.moc save:&error]) {
        STFail(@"could not save: %@", [error localizedDescription]);
    }
}

- (void)testAllLights {
    // setup
    NSManagedObject *project = [self makeProject];
    NSManagedObject *light = [project valueForKey:@"light"];
    NSError *error;
    if (![self.moc save:&error]) {
        STFail(@"could not save: %@", [error localizedDescription]);
    }
    
    // test
    NSArray *lights = [ALFLight allLightsUsingContext:self.moc];
    const NSUInteger expectedLength = 1;
    STAssertEquals([lights count], expectedLength, @"should have one light");
    STAssertEquals([[lights objectAtIndex:0] valueForKey:@"name"], [light valueForKey:@"name"], @"light name should be equal");
}

- (void)testLoadEntities {
    // setup
    ALFProject *project = [self makeProject];
    ALFLight *light = [project valueForKey:@"light"];
    NSError *error;
    if (![self.moc save:&error]) {
        STFail(@"could not save: %@", [error localizedDescription]);
    }

    // test
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"ALFLight" inManagedObjectContext:self.moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *lights = [self.moc executeFetchRequest:request error:&error];
    if (lights == nil) {
        STFail(@"could not fetch: %@", [error localizedDescription]);
    }
    const NSUInteger expectedLength = 1;
    STAssertEquals([lights count], expectedLength, @"should have one light");
    STAssertEquals([[lights objectAtIndex:0] valueForKey:@"name"], [light valueForKey:@"name"], @"light name should be equal");

    NSArray *projects = [[lights objectAtIndex:0] valueForKey:@"projects"];
    STAssertEquals([projects count], expectedLength, @"should have one project");
    STAssertEquals([[projects objectAtIndex:0] valueForKey:@"url"], [project valueForKey:@"url"], @"project uri's should be equal");
}

- (void)testLightHasOverallStatus {
    NSManagedObject *light = [self makeLight];
    STAssertEquals([[light valueForKey:@"overallStatus"] boolValue], YES, @"light should be green(YES)");
}

- (void)testProjectHasStatus {
    NSManagedObject *project = [self makeProject];
    STAssertEqualObjects([project valueForKey:@"status"], @"SUCCESS", @"project default status should be SUCCESS");
}

- (void)testInitializeLights {
    [ALFLight initializeLightsUsingContext:self.moc];
    NSArray *lights = [ALFLight allLightsUsingContext:self.moc];
    const NSUInteger expectedLength = 1;
    STAssertEquals([lights count], expectedLength, @"should have one initialized lights");
    STAssertEqualObjects([[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"name"], @"alm", @"light name should be alm");
    STAssertTrue([[[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"projects"] count] == 8, @"alm light project count should be %d", 7);
    
    [ALFLight initializeLightsUsingContext:self.moc];
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
