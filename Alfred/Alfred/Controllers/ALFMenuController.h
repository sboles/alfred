//
//  ALFMenuController.h
//  Alfred
//
//  Created by Steven Boles on 8/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALFLightView.h"

@interface ALFMenuController : NSObject{
@private
    NSMutableArray *lightControllers;
    NSManagedObjectContext * _moc;
}
- (id)initWithManagedObjectContext:(NSManagedObjectContext *)moc;

@end
