//
//  LList.h
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 25/02/17.
//  Copyright © 2017 Sahnawaj Biswas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LList : NSObject{
    NSInteger _currentValue;
    LList *_next;
}

-(void) insertValue:(NSInteger) valueToInsert;
-(void) printValue;
- (LList *) reverseLinkedList;

@property(readwrite) NSInteger currentValue;
@property(strong) LList *next;


@end
