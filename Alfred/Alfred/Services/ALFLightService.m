//
//  ALFLightService.m
//  Alfred
//
//  Created by Pairing on 8/7/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ALFLightService.h"

@implementation ALFLightService

- (NSManagedObject *)updateOverallStatusForLight:(NSManagedObject *)light {
    NSArray *projects = [light valueForKey:@"projects"];
    for (NSManagedObject *project in projects) {
        [self updateStatusForProject:project];
    }
    BOOL result = YES;
    for (NSManagedObject *project in projects) {
        if ([[project valueForKey:@"status"] isNotEqualTo:@"SUCCESS"]) {
            result = NO;
        }
    }
    [light setValue:[NSNumber numberWithBool:result] forKey:@"overallStatus"];
    return light;
}

- (NSManagedObject *)updateStatusForProject:(NSManagedObject *)project {
    NSString *urlString = [NSString stringWithFormat:@"%@api/json", [project valueForKey:@"url"]];
    NSArray *jsonArrayForProject = [self jsonArrayWithData:[[self getProjectDataWith:urlString] dataUsingEncoding:NSUTF8StringEncoding]];
    if (jsonArrayForProject) {
        NSString *lastBuildUrlString = [NSString stringWithFormat:@"%@api/json", [jsonArrayForProject valueForKeyPath:@"lastCompletedBuild.url"]];
        NSArray *jsonArrayForBuild = [self jsonArrayWithData:[[self getBuildDataWith:lastBuildUrlString] dataUsingEncoding:NSUTF8StringEncoding]];
        if (jsonArrayForBuild) {
            NSString *status = [jsonArrayForBuild valueForKeyPath:@"result"];
            [project setValue:status forKey:@"status"];
        } else {
            NSLog(@"Could not retrieve data for build %@", lastBuildUrlString);
            [project setValue:@"UNKNOWN" forKey:@"status"];
        }
    } else {
        NSLog(@"Could not retrieve data for project %@", project);
        [project setValue:@"UNKNOWN" forKey:@"status"];
    }
    return project;
}

- (id)getProjectDataWith:(NSString *)urlString {
    return [self getDataWith:urlString];
}

- (id)getBuildDataWith:(NSString *)urlString {
    return [self getDataWith:urlString];
}

- (NSString *)getDataWith:(NSString *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];

    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;

    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];

    if ([responseCode statusCode] != 200) {
        NSLog(@"Error getting %@, HTTP status code %ld", url, (long) [responseCode statusCode]);
        return nil;
    }

    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

- (NSArray *)jsonArrayWithData:(NSData *)data {
    if (data == nil) {
        return nil;
    }
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    }
    return jsonArray;
}

@end
