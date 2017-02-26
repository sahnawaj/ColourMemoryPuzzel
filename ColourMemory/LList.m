//
//  LList.m
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 25/02/17.
//  Copyright © 2017 Sahnawaj Biswas. All rights reserved.
//

#import "LList.h"
#define kNotYetSet NSIntegerMin

@implementation LList
@synthesize currentValue;
@synthesize next;

- (id) init
{
    self = [super init];
    if(self)
    {
        _currentValue = kNotYetSet;
        
        // no need to do this, since Objective C does it automagically
        // but just to make it clear...
        _next = NULL;
        NSLog(@"%d",self.currentValue);
        NSLog(@"%d",_currentValue);
    }
    return(self);
}


- (void) insertValue:(NSInteger)valueToInsert{
    // look at the next value (if it exists) and see if there is the right place to insert a new LinkedList node
    LList * nextNode = self.next;
    LList * newNode;
    NSLog(@"%d",_currentValue);
    if(self.currentValue == kNotYetSet)
    {
        self.currentValue = valueToInsert;
        return;
    }
    
    if(valueToInsert < self.currentValue)
    {
        newNode = [[LList alloc] init];
        if(newNode)
        {
            newNode.currentValue = self.currentValue;
            newNode.next = self.next;
            
            self.currentValue = valueToInsert;
            self.next = newNode;
        }
        return;
    }
    
    if(nextNode == NULL)
    {
        // nothing is next, so this is the place to insert the new LinkedList node
        newNode = [[LList alloc] init];
        if(newNode)
        {
            newNode.currentValue = valueToInsert;
            // no need to reset "next" for the newNode, since this is the new tail of the LinkedList
            self.next = newNode;
            return;
        }
    } else {
        // see if the value we're trying to insert fits between the current and the next value
        if((valueToInsert >= self.currentValue) && (valueToInsert < nextNode.currentValue))
        {
            newNode = [[LList alloc] init];
            if(newNode)
            {
                newNode.currentValue = valueToInsert;
                newNode.next = nextNode;
                self.next = newNode;
            }
        } else {
            [nextNode insertValue: valueToInsert];
        }
    }
}

- (void) printValue
{
    LList * nextNode = self.next;
    NSLog( @"%d", self.currentValue);
    if(nextNode)
    {
        // keep going down the list
        [nextNode printValue];
    }
}

- (LList *) reverseLinkedList
{
    // walk to the end of the linked list, reversing things as we go
    LList *curNode = self;
    LList *prevNode = nil;
    LList *nextNode;
    
    while(curNode) {
        
        nextNode = curNode.next;
        
        curNode.next = prevNode;
        
        prevNode = curNode;
        
        curNode = nextNode;
    }
    
    // and return the new top of the list (which was the previous end of the list)
    return(prevNode);
}
@end
