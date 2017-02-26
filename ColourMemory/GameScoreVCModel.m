//
//  GameScoreVCModel.m
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 24/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import "GameScoreVCModel.h"
#import "CoreDataStackManager.h"


@implementation GameScoreVCModel

- (instancetype)init
{
    self = [super init];
    if (self == nil) return nil;
    
    return self;
}


-(NSInteger)numberOfRowsInSection{
    NSInteger numberOfRows = 0;
    
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[0];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}



#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    // Set up the fetched results controller if needed.
    if (_fetchedResultsController == nil) {
        
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity =
        [NSEntityDescription entityForName:@"Score"
                    inManagedObjectContext:[[CoreDataStackManager sharedManager] managedObjectContext]];
        [fetchRequest setEntity:entity];
        
        // sort by date
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController =
        [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                            managedObjectContext:[[CoreDataStackManager sharedManager] managedObjectContext]
                                              sectionNameKeyPath:nil
                                                       cacheName:nil];
        self.fetchedResultsController = aFetchedResultsController;
        
        
        NSError *error = nil;
        
        if (![self.fetchedResultsController performFetch:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    return _fetchedResultsController;
}
@end
