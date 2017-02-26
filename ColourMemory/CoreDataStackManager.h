//
//  CoreDataStackManager.h
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 24/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStackManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end

