//
//  TestClassInCoreData.h
//  CoreDataParseTest
//
//  Created by Piotr K Prosol on 7/11/14.
//  Copyright (c) 2014 PKP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TestClassInCoreData : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * idNumber;

@end
