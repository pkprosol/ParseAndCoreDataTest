//
//  PKPAppDelegate.m
//  CoreDataParseTest
//
//  Created by Piotr K Prosol on 7/11/14.
//  Copyright (c) 2014 PKP. All rights reserved.
//

#import "PKPAppDelegate.h"
#import <Parse/Parse.h>
#import "PKPDataStore.h"
#import "TestClassInCoreData.h"

@implementation PKPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1. Set up Parse
    
    [Parse setApplicationId:@"W2oe07XAuqIeIUKbbLf7bgMwIzsgajfDN9n38quM"
                  clientKey:@"dh9dRsOv7782n4EYnOYrfAXF9rhcxZgWZMatOztX"];
    
    // 2. Create an instance of the Data Store
    
    PKPDataStore *store = [PKPDataStore sharedDataStore];
    
    // 3. Create several NSManagedObjects in the Core Data context managed by the Data Store
    
    TestClassInCoreData *object1 = [NSEntityDescription insertNewObjectForEntityForName:@"TestClassInCoreData" inManagedObjectContext:store.managedObjectContext];
    object1.name = @"Mike";
    object1.idNumber = @100;
    
    TestClassInCoreData *object2 = [NSEntityDescription insertNewObjectForEntityForName:@"TestClassInCoreData" inManagedObjectContext:store.managedObjectContext];
    object2.name = @"Joe";
    object2.idNumber = @20;
    
    TestClassInCoreData *object3 = [NSEntityDescription insertNewObjectForEntityForName:@"TestClassInCoreData" inManagedObjectContext:store.managedObjectContext];
    object3.name = @"Sam";
    object3.idNumber = @30;
    
    // 4. Put them in to an array
    
    NSArray *arrayOfEntries = @[object1, object2, object3];

    // 5. Loop through the entries and create matching PFObjects for each
    
    for (TestClassInCoreData *object in arrayOfEntries) {
        PFObject *testObject = [PFObject objectWithClassName:@"TestClassInCoreData"];
        testObject[@"name"] = object.name;
        testObject[@"idNumber"] = object.idNumber;
        [testObject saveInBackground];
    }
    
    // 6. Retrieve the uploaded objects with a query
    
    PFQuery *query = [PFQuery queryWithClassName:@"TestClassInCoreData"];
    NSArray *scoreArray = [query findObjects];
    
    
    // 7. Loop through the array of retrieved objects and set them all up in Core Data with correct properties; note that this example keeps duplicating the same data
    
    NSMutableArray *dataPulledFromParse = [[NSMutableArray alloc] init];
    
    for (PFObject *object in scoreArray) {
        TestClassInCoreData *testClassObjectToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"TestClassInCoreData" inManagedObjectContext:store.managedObjectContext];
        
        testClassObjectToAdd.name = object[@"name"];
        testClassObjectToAdd.idNumber = object[@"idNumber"];

        [dataPulledFromParse addObject:testClassObjectToAdd];
    }
    
    NSLog(@"%@", dataPulledFromParse);
    
    // 8. Deal with sync logic and duplication
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
