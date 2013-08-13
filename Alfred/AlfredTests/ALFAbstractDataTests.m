//
//  ALFAbstractDataTests.m
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Mobian Solutions. All rights reserved.
//

#import "ALFAbstractDataTests.h"

@implementation ALFAbstractDataTests

- (void)setUp {
    [super setUp];

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Alfred" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    STAssertTrue([psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL] ? YES : NO, @"Should be able to add in-memory store");
    self.moc = [[NSManagedObjectContext alloc] init];
    self.moc.persistentStoreCoordinator = psc;
}

- (void)tearDown {
    self.moc = nil;
    [super tearDown];
}

- (NSManagedObject *)makeLight {
    NSManagedObject *light = [NSEntityDescription
            insertNewObjectForEntityForName:@"ALFLight"
                     inManagedObjectContext:self.moc];
    [light setValue:[@"test" stringByAppendingString:[self genRandStringLength:10]] forKey:@"name"];
    return light;
}

- (NSManagedObject *)makeProject {
    NSManagedObject *light = [self makeLight];
    NSManagedObject *project = [NSEntityDescription
            insertNewObjectForEntityForName:@"ALFProject"
                     inManagedObjectContext:self.moc];
    [project setValue:[@"http://test" stringByAppendingString:[self genRandStringLength:10]] forKey:@"url"];
    [project setValue:light forKey:@"light"];
    return project;
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

- (NSString *)genRandStringLength:(int)len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];
    for (int i = 0; i < len; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    return randomString;
}

@end
