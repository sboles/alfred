//
//  ALFAbstractDataTests.h
//
//  Used by subclasses to get an in memory managed object context for testing
//  and for building test objects
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Mobian Solutions. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface ALFAbstractDataTests : SenTestCase
@property(nonatomic, retain) NSManagedObjectContext *moc;

- (NSManagedObject *)makeLight;

- (NSManagedObject *)makeProject;
@end
