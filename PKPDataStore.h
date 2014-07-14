//
//  PKPDataStore.h
//  CoreDataParseTest
//
//  Created by Piotr K Prosol on 7/11/14.
//  Copyright (c) 2014 PKP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PKPDataStore : NSObject

+ (instancetype) sharedDataStore;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext; // readonly properties don't autosynthesize; generate getter and setter and synthesize it to get underscore

- (void)saveContext;
- (NSArray *)fetchTestData;

@end
