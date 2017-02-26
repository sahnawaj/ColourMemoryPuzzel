//
//  Score.h
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 24/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface GameScore : NSManagedObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int score;

@end
