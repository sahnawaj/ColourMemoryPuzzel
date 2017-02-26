//
//  ViewControllerModel.m
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 23/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import "GameViewControllerModel.h"
#import "Constants.h"
#import "GameScore.h"
#import "CoreDataStackManager.h"
@import CoreData;

@interface GameViewControllerModel()
@property (nonatomic, readwrite) NSMutableArray *unqArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation GameViewControllerModel

- (instancetype)init
{
    self = [super init];
    if (self == nil) return nil;
    [self managedObjectContext];
    return self;
}


-(NSInteger)numberOfSections{
    return GAME_BOARD_TYPE*GAME_BOARD_TYPE;
}

// Generate random number to place matching card randomly
-(void) genarateRandomUniqueNum{
    [self generateRandomUniqueNumberInRange:1 :8];
}

-(void)generateRandomUniqueNumberInRange :(int)rangeLow :(int)rangeHigh{
    self.unqArray=[[NSMutableArray alloc] init];
    int randNum=0;
    int counter=0;
    
    while (counter<GAME_BOARD_TYPE*GAME_BOARD_TYPE) {
        
        randNum = arc4random() % (rangeHigh-rangeLow+1) + rangeLow;
        
        if([self countSameObj:self.unqArray :[NSNumber numberWithInteger:randNum]] < 2){
            [self.unqArray addObject:[NSNumber numberWithInt:randNum]];
            counter++;
        }
    }
}

-(NSInteger) countSameObj:(NSArray *)arry :(NSNumber *)num{
    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:arry];
    return [countedSet countForObject:num];
}


// Check for game over
-(BOOL) isGameOver{
    BOOL isGameOver = true;
    for(NSNumber *num in self.unqArray){
        if([num intValue] != 0){
            isGameOver = FALSE;
            break;
        }
    }
    return isGameOver;
}

// Get the Cell Widht
-(float)cellWidth:(float)width{
    float cellWd = (width-((GAME_BOARD_TYPE-1)*10))/GAME_BOARD_TYPE;
    return cellWd;
}
// Get the Cell Widht
-(float)cellHeight:(float)hight{
    float cellHt = (hight-((GAME_BOARD_TYPE-1)*10))/GAME_BOARD_TYPE;
    return cellHt;
}

#pragma mark - AddScore
- (void)addScoreToPersistentStore:(NSString *)name :(int)scor{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *ent = [NSEntityDescription entityForName:@"Score" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = ent;
    
    // narrow the fetch to these two properties
    fetchRequest.propertiesToFetch = [NSArray arrayWithObjects:@"name", @"score", nil];
    [fetchRequest setResultType:NSDictionaryResultType];
    
    // before adding the score, first check if there's a duplicate in the backing store
    NSError *error = nil;
    GameScore *scr = [[GameScore alloc] initWithEntity:ent insertIntoManagedObjectContext:nil];
    scr.name = name;
    scr.score = scor;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name = %@ AND score = %d", scr.name, scr.score];
    
    NSArray *fetchedItems = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedItems.count == 0) {
        // we found no duplicate score, so insert this new one
        [self.managedObjectContext insertObject:scr];
    }
    
    if ([self.managedObjectContext hasChanges]) {
        
        if (![self.managedObjectContext save:&error]) {
          
            abort();
        }
    }
}

#pragma mark - Core Data support

// The managed object context for the view controller (which is bound to the persistent store coordinator for the application).
- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = [[CoreDataStackManager sharedManager] persistentStoreCoordinator];
    
    return _managedObjectContext;
}

@end
