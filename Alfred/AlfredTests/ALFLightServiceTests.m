//
//  ALFLightServiceTests.m
//  Alfred
//
//  Created by Pairing on 8/7/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightServiceTests.h"

@implementation ALFLightServiceTests

- (void)setUp {
    [super setUp];

    method_exchangeImplementations(class_getInstanceMethod([ALFLightService class], @selector(getProjectDataWith:)), class_getInstanceMethod([self class], @selector(mockGetProjectDataWith:)));
    method_exchangeImplementations(class_getInstanceMethod([ALFLightService class], @selector(getBuildDataWith:)), class_getInstanceMethod([self class], @selector(mockGetBuildDataWith:)));
}

- (void)tearDown {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(mockGetProjectDataWith:)), class_getInstanceMethod([ALFLightService class], @selector(getProjectDataWith:)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(mockGetBuildDataWith:)), class_getInstanceMethod([ALFLightService class], @selector(getBuildDataWith:)));

    [super tearDown];
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
    ALFLightService *service = [[ALFLightService alloc] initWithManagedObjectContext:self.moc];
    NSArray *lights = [service allLights];
    const NSUInteger expectedLength = 1;
    STAssertEquals([lights count], expectedLength, @"should have one light");
    STAssertEquals([[lights objectAtIndex:0] valueForKey:@"name"], [light valueForKey:@"name"], @"light name should be equal");
}

- (void)testReinitializeLights {
    ALFLightService *service = [[ALFLightService alloc] initWithManagedObjectContext:self.moc];
    [service initializeLights];
    NSArray *lights = [service allLights];
    const NSUInteger expectedLength = 1;
    STAssertEquals([lights count], expectedLength, @"should have two initialized lights");
    STAssertEqualObjects([[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"name"], @"alm", @"light name should be alm");
    STAssertTrue([[[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"projects"] count] == 7, @"alm light project count should be %d", 7);

    [service initializeLights];
    lights = [service allLights];
    STAssertEquals([lights count], expectedLength, @"should have two initialized lights");
    STAssertEqualObjects([[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"name"], @"alm", @"light name should be alm");
    STAssertTrue([[[self getLightWithName:@"alm" fromAllLights:lights] valueForKey:@"projects"] count] == 7, @"alm light project count should be %d", 7);
}

- (NSManagedObject *)getLightWithName:(NSString *)name fromAllLights:(NSArray *)allLights {
    for (NSManagedObject *o in allLights) {
        if ([[o valueForKey:@"name"] isEqualTo:name]) {
            return o;
        }
    }
    return nil;
}

- (void)testUpdateOverallStatusForGreenLightToRedLight {
    // setup
    method_exchangeImplementations(class_getInstanceMethod([ALFLightService class], @selector(updateStatusForProject:)), class_getInstanceMethod([self class], @selector(mockUpdateStatusForProject:)));
    NSManagedObject *project = [self makeProject];
    NSManagedObject *light = [project valueForKey:@"light"];
    [project setValue:@"FAILED" forKey:@"status"];
    STAssertEquals([[light valueForKey:@"overallStatus"] boolValue], YES, @"status should be YES");

    // test
    ALFLightService *service = [[ALFLightService alloc] initWithManagedObjectContext:self.moc];
    [service updateOverallStatusForLight:light];
    STAssertEquals([[light valueForKey:@"overallStatus"] boolValue], NO, @"status should be NO");

    // teardown
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(mockUpdateStatusForProject:)), class_getInstanceMethod([ALFLightService class], @selector(updateStatusForProject:)));
}

- (void)testUpdateOverallStatusForRedLightToGreenLight {
    // setup
    method_exchangeImplementations(class_getInstanceMethod([ALFLightService class], @selector(updateStatusForProject:)), class_getInstanceMethod([self class], @selector(mockUpdateStatusForProject:)));
    NSManagedObject *project = [self makeProject];
    NSManagedObject *light = [project valueForKey:@"light"];
    [light setValue:NO forKey:@"overallStatus"];
    [project setValue:@"SUCCESS" forKey:@"status"];
    STAssertEquals([[light valueForKey:@"overallStatus"] boolValue], NO, @"status should be NO");

    // test
    ALFLightService *service = [[ALFLightService alloc] initWithManagedObjectContext:self.moc];
    [service updateOverallStatusForLight:light];
    STAssertEquals([[light valueForKey:@"overallStatus"] boolValue], YES, @"status should be YES");

    // teardown
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(mockUpdateStatusForProject:)), class_getInstanceMethod([ALFLightService class], @selector(updateStatusForProject:)));
}

- (void)testUpdateStatusForProject {
    // setup
    NSManagedObject *project = [self makeProject];
    ALFLightService *service = [[ALFLightService alloc] initWithManagedObjectContext:self.moc];

    // test
    [service updateStatusForProject:project];
    STAssertEqualObjects([project valueForKey:@"status"], @"SUCCESS", @"status should be SUCCESS");
}

- (NSManagedObject *)mockUpdateStatusForProject:(NSManagedObject *)project {
    return project;
}

- (NSString *)mockGetProjectDataWith:(NSString *)url {
    return [ALFLightServiceTests greenMockData];
}

- (NSString *)mockGetBuildDataWith:(NSString *)url {
    return [ALFLightServiceTests greenBuildData];
}

+ (NSString *)greenMockData {
    return @""
            "{"
            "  \"lastCompletedBuild\": {"
            "    \"number\": 813,"
            "    \"url\": \"http://alm-build:8080/hudson/job/master-alm-continuous/813/\""
            "  }"
            "}";
}

+ (NSString *)redMockData {
    return @""
            "{"
            "  \"lastCompletedBuild\": {"
            "    \"number\": 808,"
            "    \"url\": \"http://alm-build:8080/hudson/job/master-alm-continuous/808/\""
            "  }"
            "}";
}

+ (NSString *)greenBuildData {
    return @""
            "{"
            "  \"result\": \"SUCCESS\""
            "}";
}

+ (NSString *)redBuildData {
    return @""
            "{"
            "  \"result\": \"FAILURE\""
            "}";
}

@end
