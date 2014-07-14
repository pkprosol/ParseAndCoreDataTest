//
//  PKPDataStore.m
//  CoreDataParseTest
//
//  Created by Piotr K Prosol on 7/11/14.
//  Copyright (c) 2014 PKP. All rights reserved.
//

#import "PKPDataStore.h"

@implementation PKPDataStore
@synthesize managedObjectContext = _managedObjectContext; // not an assignment, synthesize 1 with _1

+ (instancetype)sharedDataStore {
    static PKPDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[PKPDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Error saving");
            abort();
        }
    }
}

- (NSArray *)fetchTestData
{
    NSFetchRequest *fetchTestData = [NSFetchRequest fetchRequestWithEntityName:@"TestClassInCoreData"];
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchTestData error:nil];
    
    return result;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext; // lazy instantiation
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataParseTest.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
