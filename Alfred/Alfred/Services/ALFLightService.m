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

- (void)initializeLights {
    NSArray *lights = [self allLights];
    if([lights count] == 0) {
        NSMutableArray *newLights = [NSMutableArray array];
        NSManagedObject *almLight = [self makeLightWithName:@"alm"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/master-alm-continuous/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/view/%20%20master/job/backward-compatibility-of-migrations/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-guitest/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-java/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-chrome/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-alm-continuous-js-firefox/"];
        [self makeProjectFor:almLight withURL:@"http://alm-build:8080/hudson/job/master-flaky-finder-continuous/"];
        NSManagedObject *appsdkLight = [self makeLightWithName:@"appsdk"];
        [self makeProjectFor:appsdkLight withURL:@"http://alm-build:8080/hudson/view/App%20SDK/job/master-appsdk-continuous-js/"];
        [newLights addObject:almLight];
        [newLights addObject:appsdkLight];
    }
}

- (NSManagedObject*)updateOverallStatusForLight:(NSManagedObject *)light {
    NSArray *projects = [light valueForKey:@"projects"];
    for (NSManagedObject *project in projects) {
        [self updateStatusForProject: project];
    }
    BOOL result = YES;
    for (NSManagedObject *project in projects) {
        if([[project valueForKey:@"status"] isNotEqualTo: @"SUCCESS"]) {
            result = NO;
        }
    }
    [light setValue:[NSNumber numberWithBool:result] forKey:@"overallStatus"];
    return light;
}

- (NSManagedObject*)updateStatusForProject:(NSManagedObject *)project {
    NSString *urlString = [NSString stringWithFormat: @"%@api/json", [project valueForKey:@"url"]];
    NSArray *jsonArrayForProject = [self jsonArrayWithData: [[self getProjectDataWith:urlString] dataUsingEncoding:NSUTF8StringEncoding]];
    if (jsonArrayForProject) {
        NSString *lastBuildUrlString = [NSString stringWithFormat: @"%@api/json", [jsonArrayForProject valueForKeyPath:@"lastBuild.url"]];
        NSArray *jsonArrayForBuild = [self jsonArrayWithData: [[self getBuildDataWith:lastBuildUrlString] dataUsingEncoding:NSUTF8StringEncoding]];
        if(jsonArrayForBuild) {
            NSString *status = [jsonArrayForBuild valueForKeyPath:@"result"];
            [project setValue:status forKey:@"status"];
        }
    }
    return project;
}

- (id)getProjectDataWith:(NSString *)urlString {
    return [self getDataWith:urlString];
}

- (id)getBuildDataWith:(NSString *)urlString {
    return [self getDataWith:urlString];
}

- (NSString *) getDataWith:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %ld", url, (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

- (NSArray *)jsonArrayWithData:(NSData *)data {
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    }
    return jsonArray;
}

- (NSManagedObject*) makeLightWithName:(NSString*)name {
    NSManagedObject *light = [NSEntityDescription
                              insertNewObjectForEntityForName:@"ALFLight"
                              inManagedObjectContext:_moc];
    [light setValue:name forKey:@"name"];
    return light;
}

- (NSManagedObject*) makeProjectFor:(NSManagedObject*)light withURL:(NSString*)url {
    NSManagedObject *project = [NSEntityDescription
                                insertNewObjectForEntityForName:@"ALFProject"
                                inManagedObjectContext:_moc];
    [project setValue:url forKey:@"url"];
    [project setValue:light forKey:@"light"];
    return project;
}

@end
