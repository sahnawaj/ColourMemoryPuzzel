//
//  ViewControllerModel.h
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 23/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface GameViewControllerModel : NSObject

@property (nonatomic, readonly) NSMutableArray *unqArray;

-(NSInteger)numberOfSections;
-(BOOL) isGameOver;
-(void) genarateRandomUniqueNum;

-(float)cellWidth:(float)width;
-(float)cellHeight:(float)hight;

- (void)addScoreToPersistentStore:(NSString *)name :(int)scor;
@end
