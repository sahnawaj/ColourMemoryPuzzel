//
//  CoreDataStackManager.m
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 24/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import "CoreDataStackManager.h"

@interface CoreDataStackManager ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end


#pragma mark -

@implementation CoreDataStackManager

+ (instancetype)sharedManager {
    
    static CoreDataStackManager *sharedManager = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}
- (id)init {
    if (self = [super init]) {
       NSString *someProperty = @"Default Property Value";
    }
    NSLog(@"%@",self);
    return self;
}


// Returns the path to the application's documents directory.
- (NSString *)applicationDocumentsDirectory {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
  CoreDataStackManager *cn= [[CoreDataStackManager alloc] init];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ColourMemory" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it
//
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"ColourMemory.sqlite"];
    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    
    NSError *error;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate.
        // You should not use this function in a shipping application, although it may be useful
        // during development. If it is not possible to recover from the error, display an alert
        // panel that instructs the user to quit the application by pressing the Home button.
        //
        
        // Typical reasons for an error here include:
        // The persistent store is not accessible
        // The schema for the persistent store is incompatible with current managed object model
        // Check the error message to determine what the actual problem was.
        //
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

// The managed object context for the view controller (which is bound to the persistent store coordinator for the application).
- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mergeChanges:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
    
    return _managedObjectContext;
}

// merge changes to main context,fetchedRequestController will automatically monitor the changes and update tableview.
- (void)updateMainContext:(NSNotification *)notification {
    
    assert([NSThread isMainThread]);
    [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
}


- (void)mergeChanges:(NSNotification *)notification {
    
    if (notification.object != self.managedObjectContext) {
        [self performSelectorOnMainThread:@selector(updateMainContext:) withObject:notification waitUntilDone:NO];
    }
}

@end
