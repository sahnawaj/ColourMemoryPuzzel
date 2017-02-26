//
//  main.m
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 22/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LList.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
        LList *list = [[LList alloc] init];
        [list insertValue:10];
        [list insertValue:25];
        [list insertValue:5];
        [list insertValue:30];
        [list insertValue:12];
        
        [list printValue];
        
        // and to reverse the list and print it...
        list = [list reverseLinkedList];
        [list printValue];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
