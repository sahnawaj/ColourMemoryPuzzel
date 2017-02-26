//
//  GameScoreVCModel.h
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 24/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface GameScoreVCModel : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

-(NSInteger)numberOfRowsInSection;
@end
